from contextlib import contextmanager
import psycopg2 
from psycopg2 import OperationalError
import logging

logging.basicConfig(
    level=logging.INFO, 
    format="%(asctime)s | %(levelname)s | %(message)s"
)
logger = logging.getLogger(__name__)

class DBConnectionException(Exception):
    def __init__(self, message) -> None:
        self.message = message
        super().__init__(self.message)

class DBQueryError(Exception):
    def __init__(self, message) -> None:
        self.message = message
        super().__init__(self.message)

@contextmanager
def db_connect():
    conn = None
    try:
        logger.info("Connecting to PSQL DB")
        conn = psycopg2.connect(
            host="localhost",
            database="challange",
            user="umeshunde",
            #password="psql",
            port=5432
        )
        logger.info("Connected to PSQL DB")
        yield conn

    except OperationalError as e:
        logger.error(f"Connection failed: {e}") 
        raise DBConnectionException(f"Could not connect to PostgreSQL: {e}")

    except Exception as e:
        logger.exception("Unexpected error while managing DB connection.") 
        raise DBConnectionException(f"Unexpected DB connection error: {e}")

    finally:
        if conn is not None:
            try:
                conn.close()
                logger.info("DB Connections closed")
            except Exception as e:
                logger.warning(f"Failed to close connection cleanly: {e}")

def extract_data(query, param=None):
    with db_connect() as conn:
        try:
            with conn.cursor() as cursor:
                cursor.execute(query, param)
                return cursor.fetchall()
        except psycopg2.Error as e:
            logger.error(e)
            raise DBQueryError(f"Query failed: {e}")

print(extract_data("select * from orders"))
