from typing import Dict, List


def top_k_frequent(nums:List[int], k:int) -> List[int]:
    tracker:Dict = {}

    for num in nums:
        tracker[num] = tracker.get(num, 0) + 1
