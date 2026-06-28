from typing import List


def lenght_of_longest_substr(s:str) -> int:
    if len(s) < 2:
        return 1
    left:int = 0
    right:int = 1
    tracker:List = [s[0]]
    max = 1
    while right < len(s):
        if s[right] not in tracker:
            tracker.append(s[right])
        if len(tracker) > max:
            max = len(tracker)
        if s[right] in tracker:
            left += 1
            tracker.pop(0)
        right += 1

    return max
