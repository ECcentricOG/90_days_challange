# Write a DataPipeline class with extract(), transform(), load(). 
# Use @property, @staticmethod, @classmethod. 
# Implement __repr__, __enter__, __exit__ for context manager usage.
import time


class DataPipeline:
    
    def __init__(self, name) -> None:
        self._name = name
        self._data = []
        self._status = "idle"
        self._start = None

    @property # it is like getter
    def name(self):
        return self._name

    #@name.setter   -- this is setter for getter @property
    #def name(self, value):
    #   self._name = value

    @property
    def status(self):
        return self._status
    
    @property
    def row_count(self):
        return len(self._data)

    @staticmethod # pure helper needs no self,cls
    def is_valid(record):
        if not isinstance(record, dict) or not record:
            return False
        return all(value is not None for value in record.values())

    @staticmethod
    def clean_keys(record):
        return {
            key.strip().lower().replace(" ", "_") : value
            for key, value in record.items()
        }

    @classmethod # works on class not on instance
    def from_config(cls, config: dict):
        if "name" not in config:
            raise ValueError("config must have 'name' key")
        return cls(config["name"])

    def extract(self, source: list) -> list:
        print(f"[extract] pulling {len(source)} records")
        self._data = source
        return self._data

    def transform(self, records: list) -> list:
        print(f"[transform] cleaning {len(records)} records")
        clean = []
        for i, record in enumerate(records):
            record = DataPipeline.clean_keys(record)
            if not DataPipeline.is_valid(record):
                print(f"skipping row {i} — failed validation: {record}")
                continue
            clean.append(record)
        self._data = clean
        return self._data

    def load(self, records: list, destination=None) -> list:
        if destination is not None:
            destination.extend(records)
        print(f"[Load] done")
        return records

    def __repr__(self) -> str: # when we print the object like toString method in java
        return (
            f"DataPipeline name='{self._name}'"
            f"status='{self._status}'"
            f"records='{self.row_count}'"
        )

    def __enter__(self): # Runs when you enter the `with` block — starts the pipeline
        self._status = "running"
        self._start = time.time()
        print(f"\n--- Pipeline '{self._name}' started ---")
        return self     # this becomes the `as p` variable 

    def __exit__(self, exc_type, exc_value, tb):
        elapsed = round(time.time()- self._start, 2)
        if exc_type is None:
            self._status = "done"
            print(f"--- Pipeline '{self._name}' finished in {elapsed}s ---\n")
        else:
            self._status = "failed"
            print(f"--- Pipeline '{self._name}' FAILED after {elapsed}s ---")
            print(f"    Error: {exc_type.__name__}: {exc_value}\n")

        return False    # False = don't hide the exception if one occurred

