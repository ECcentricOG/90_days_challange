from typing import Dict, List, Set


employees = [
    {"id": 1, "name": "Alice",   "salary": 70000, "department": "IT"},
    {"id": 2, "name": "Bob",     "salary": 50000, "department": "HR"},
    {"id": 3, "name": "Charlie", "salary": 90000, "department": "IT"},
    {"id": 4, "name": "David",   "salary": 45000, "department": "Sales"},
    {"id": 5, "name": "Eva",     "salary": 80000, "department": "IT"}
]

# List Comprehensions
high_paid_it:List = [
    emp["name"].upper()
    for emp in employees
    if emp["salary"] > 75000 and emp["department"] == "IT"
]
print(high_paid_it)

# Set Comprehensions
all_dept:Set = {
    rec["department"] for rec in employees
}
print(all_dept)

#Dict Comprehension
emp_lvl:Dict = {
    emp["name"]:(
        "Senior" if emp["salary"] > 75000 else "Junior"
    )
    for emp in employees
}
print(emp_lvl)
