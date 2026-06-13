from typing import List


def product_except_self(nums:List[int]) -> List[int]:
    n:int = len(nums)
    left:List[int] = [1] * n
    right:List[int] = [1] * n

    for i in range(1, n):
        left[i] = left[i - 1] * nums[i - 1]

    for i in range(n - 2, -1, -1):
        right[i] = right[i + 1] * nums[i + 1]

    for i in range(n):
        nums[i] = left[i] * right[i]

    return nums
