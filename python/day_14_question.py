# Design a Python class for a reusable ETL pipeline that supports context manager syntax (with statement), 
# configurable retry logic, step logging, and raises custom exceptions on failure. 
# How do you make it extensible for different sources without modifying the base class?

from abc import ABC, abstractmethod
import logging
from typing import Any
import time
 
class PipelineError(Exception):
    pass

class ExtractError(PipelineError):
    pass

class TransformError(PipelineError):
    pass

class LoadError(PipelineError):
    pass

class RetryExhaustedError(PipelineError):
    def __init__(self, step_name: str, attempts:int, last_error: Exception):
        self.strp_name = step_name
        self.attempts = attempts
        self.last_error = last_error
        super().__init__(
            f"Step '{step_name}' failed after {attempts} attempts. "
            f"Last error: {last_error!r}"
        )

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s | %(levelname)-7s | %(message)s",
    datefmt="%H:%M:%S",
)
logger = logging.getLogger("etl_pipeline")

class BasePipeline(ABC):
    def __init__(self, name:str, max_retries: int = 3, retry_delay: float = 1.0, retry_backoff: float = 2.0):
        self.name = name
        self.max_reties = max_retries
        self.retry_delay = retry_delay
        self.retry_backoff = retry_backoff
        self.data: Any = None
        self.status = "idle"
        self.start_time = None

    @abstractmethod
    def extract(self) -> Any:
        raise NotImplementedError

    @abstractmethod
    def load(self, data:Any) -> None:
        raise NotImplementedError

    @abstractmethod
    def tranform(self, data: Any) -> Any:
        return data

    def _run_with_retry(self, step_name: str, func, *args):
        delay = self.retry_delay
        last_error = Any
        for attempt in range(1, self.max_reties + 1):
            try:
                logger.info(f"[{self.name}] {step_name} — attempt {attempt}/{self.max_reties}")
                result = func(*args)
                logger.info(f"[{self.name}] {step_name} — succeeded")
                return result
            except Exception as e:
                last_error = e
                logger.warning(f"[{self.name}] {step_name} — failed: {e!r}")
                if attempt < self.max_reties:
                    logger.info(f"[{self.name}] retrying in {delay}s...")
                    time.sleep(delay)
                    delay *= self.retry_backoff
        raise RetryExhaustedError(step_name, self.max_reties, last_error)

    def run(self) -> Any:
        try:
            raw = self._run_with_retry("extract", self.extract)
        except RetryExhaustedError as e:
            raise ExtractError(str(e)) from e

        try:
            clean = self._run_with_retry("tranform", self.tranform, raw)
        except RetryExhaustedError as e:
            raise TransformError(str(e)) from e

        try:
            self._run_with_retry("load", self.load, clean)
        except RetryExhaustedError as e:
            raise LoadError(str(e)) from e

        self.data = clean
        return clean
    
    def __repr__(self) -> str:
        return f"{self.__class__.__name__}(name={self.name!r}, status={self.status!r})"

    def __enter__(self):
        self.status = "running"
        self.start_time = time.time()
        logger.info(f"[{self.name}] pipeline started")
        return self

    def __exit__(self, exc_type, exc_val, tb):
        elasped = round(time.time() - self.start_time, 2)
        if exc_type is None:
            self._status = "done"
            logger.info(f"[{self.name}] pipeline finished in {elasped}s")
        else:
            self._status = "failed"
            logger.error(f"[{self.name}] pipeline failed after {elasped}s "
                         f"— {exc_type.__name__}: {exc_val}")

        return False

class CSVPipeline(BasePipeline):
    def __init__(self, name:str, csv_text:str, destination:list, **kwargs):
        super().__init__(name, **kwargs)
        self.csv_text = csv_text
        self.destination = destination

    def extract(self) -> Any:
        import csv, io
        reader = csv.DictReader(io.StringIO(self.csv_text.strip()))
        return [dict(row) for row in reader]

    def tranform(self, data: Any) -> Any:
        return [row for row in data if all(v for v in row.values())]

    def load(self, data: Any) -> None:
        self.destination.extend(data)
