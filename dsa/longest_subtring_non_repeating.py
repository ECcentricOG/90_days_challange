def lenght_of_longest_substr(s:str) -> int:
    tracker = {}
    left:int = 0
    max_len = 0
    for right in range(len(s)):
        if s[right] in tracker and tracker[s[right]] >= left:
            left = tracker[s[right]] + 1
        else:
            max_len = max(max_len, right - left + 1)
        tracker[s[right]] = right
    return max_len
