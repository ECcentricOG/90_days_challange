from typing import List
from collections import Counter, defaultdict

#Counter from collections import counter
nums:List = [1,1,2,2,2,3,3,4,4,4,4]
freq = Counter(nums)
print(freq) #({4: 4, 2: 3, 1: 2, 3: 2})
print(freq.most_common(2)) #[(4, 4), (2, 3)]

#DefaultDict from collections import defaultdict 
dept_emp = defaultdict(list)
dept_emp["IT"].append("Messi")
dept_emp["IT"].append("Neymar")
employees = [
    ("IT", "Ronaldo"),
    ("IT", "Iniesta"),
    ("HR", "Pep")
]
for dept, name in employees:
    dept_emp[dept].append(name)
print(dept_emp)

#zip : Combines multiple iterable or make dict with two lists
names:List[str] = ["Messi", "Mbappe", "Haland", "Ronaldo"]
goals:List[int] = [5,4,4,2]
result = zip(names,goals)
print(result)
result_dict = dict(result)
print(result_dict)

#enumerate: both index and value
lst:List[int] = [10, 20, 30, 40]
for index, value in enumerate(lst):
    print(index, value)

#sorted(keys) sort data
top_scorers = sorted(
    result,
    key= lambda x:x[1]
)
print(top_scorers)
