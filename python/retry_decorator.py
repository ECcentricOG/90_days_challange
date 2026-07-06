import time
from functools import wraps

def retry(n, delay=1, backoff=2, exceptions=(Exception,)):
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            current_delay = delay

            for attempt in range(1, n + 1):
                try:
                    func(*args, **kwargs)
                except exceptions as e:
                    if attempt == n:
                        raise 
                    print(f"Attempt {attempt} failed: {e}. Retrying in {current_delay} seconds...")
                    time.sleep(current_delay)
                    current_delay *= backoff

        return wrapper
    return decorator
