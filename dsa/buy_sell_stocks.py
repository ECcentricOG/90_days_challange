from typing import List


def max_profit(prices:List[int]) -> int:
    left:int = 0
    right:int = 1
    max_profit:int = 0

    while right < len(prices):
        if prices[right] > prices[left]:
            profit:int = prices[right] - prices[left]
            max_profit = max(max_profit, profit)
        else:
            left = right

        right += 1
    
    return max_profit
