from typing import List

def maximum_subarray(nums:List[int]) -> int:
    max: int = 0
    total: int = 0
    
    for num in nums:
        total += num

        if total > max:
            max = total

        if total < 0:
            total = 0

    return max
