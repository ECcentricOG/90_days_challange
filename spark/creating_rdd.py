from session import get_session

session = get_session(__name__)
context = session.sparkContext

data = [
    [1,2,3,4,5],
    ['a', 'b', 'c', 'd', 'e'],
    ['A', 'B']
]

rdd = context.parallelize(data)
#Map one to one one input give one output
print(rdd.map(lambda arr: len(arr)).collect())
#FlatMap one to many one input give many output
print(rdd.flatMap(lambda arr: arr * 2).collect())

#filter as name says
print(rdd.filter(lambda x: len(x) >= 3).collect())

data = [
    ("Ronaldo", 1),
    ("Messi", 4),
    ("Ronaldo", 2),
    ("Messi", 1),
    ("Ronaldo", 2),
    ("Modric", 1),
    ("Messi", 2),
    ("Benzema", 1),
    ("Levendoski", 1),
    ("Messi", 1)
]

rdd = context.parallelize(data)
#ReducebyKey - it performs aggregation during shuffle
print(rdd.reduceByKey(lambda a,b: a + b).collect())
#GroupbyKey - it firstly group the data then perform aggregation that is why show than ReducebyKey
print(rdd.groupByKey().collect())
