from typing import Dict


def is_anagram(s:str, t:str) -> bool:
    tracker:dict = {}
    for ch in s:
        tracker[ch] = tracker.get(ch, 0) + 1
    for ch in t:
        if ch not in tracker:
            return false
        tracker[ch] -= 1
        if tracker[ch] == 0:
            tracker.pop(ch)

    if len(tracker) == 0:
        return true
    return false
