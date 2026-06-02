from typing import Dict, List

def two_sum(nums:List[int], target:int) -> List[int]:
    tracker:Dict = {}
    for i in range(len(nums)):
        rem = target - nums[i]

        if rem in tracker:
            return [tracker[rem], i]

        tracker[nums[i]] = i
    return []
