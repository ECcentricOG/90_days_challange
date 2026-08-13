from pyspark.sql import SparkSession

def get_session(name:str="Default") -> SparkSession:
    return SparkSession.builder \
        .appName(name)\
        .master("local[*]")\
        .getOrCreate()
