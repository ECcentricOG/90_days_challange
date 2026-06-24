from typing import DefaultDict, List
from collections import defaultdict


def subarray_sum_k(nums:List[int], k:int) -> int:
    prefix:int = 0
    tracker:DefaultDict = defaultdict(int)
    tracker[0] = 1
    count:int = 0   
    for num in nums:
        prefix += num
        count += tracker[prefix - k]
        tracker[prefix] += 1

    return count
