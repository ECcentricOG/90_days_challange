# Design a Python class for a reusable ETL pipeline that supports context manager syntax (with statement), 
# configurable retry logic, step logging, and raises custom exceptions on failure. 
# How do you make it extensible for different sources without modifying the base class?

from abc import ABC, abstractmethod
import logging
from typing import Any
 
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
