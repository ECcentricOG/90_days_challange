from typing import List


def missing_number(nums:List[int]) -> int:
    n:int = len(nums)
    total:int = n * (n + 1) // 2
    sum:int = 0
    for num in nums:
        sum += num

    return total - sum
