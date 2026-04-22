#!/usr/bin/env python3
"""
add_round.py — Generates a new wave and appends it to WaveData.gd,
then increments TOTAL_ROUNDS in GameManager.gd.

Wave difficulty scales based on the current round count:
  - Enemy counts increase by ~10-15% per round beyond 30
  - New enemy types are weighted toward harder ones in later rounds
  - Spawn intervals shorten gradually (more pressure over time)

Run from the repo root:
    python3 scripts/tools/add_round.py
"""

import re
import os
import sys
import math
import random

WAVE_DATA_PATH = "scripts/data/WaveData.gd"
GAME_MANAGER_PATH = "scripts/managers/GameManager.gd"

ALL_ENEMIES = ["cultist", "deep_one", "mist_wraith", "brine_brute", "oracle_of_rot", "spawn_of_the_sleeper"]

# Weight tables by round tier (>30 = post-game content).
# Higher tiers shift weight toward harder enemies.
ENEMY_WEIGHTS_BY_TIER = {
    1:  [50, 30, 15,  4,  1,  0],   # rounds 31-35
    2:  [35, 25, 20, 10,  7,  3],   # rounds 36-45
    3:  [20, 20, 20, 15, 15, 10],   # rounds 46-60
    4:  [10, 15, 15, 20, 20, 20],   # rounds 61+
}


def _weights_for_round(round_num: int) -> list[int]:
    if round_num <= 35:
        return ENEMY_WEIGHTS_BY_TIER[1]
    elif round_num <= 45:
        return ENEMY_WEIGHTS_BY_TIER[2]
    elif round_num <= 60:
        return ENEMY_WEIGHTS_BY_TIER[3]
    return ENEMY_WEIGHTS_BY_TIER[4]


def _choose_enemy(round_num: int, exclude: str | None = None) -> str:
    weights = _weights_for_round(round_num)
    pool = list(zip(ALL_ENEMIES, weights))
    if exclude:
        pool = [(e, w) for e, w in pool if e != exclude]
    enemies, ws = zip(*pool)
    total = sum(ws)
    r = random.random() * total
    running = 0
    for enemy, w in zip(enemies, ws):
        running += w
        if r <= running:
            return enemy
    return enemies[-1]


def _scale_count(base: int, round_num: int) -> int:
    """Increase count by ~12% per round beyond 30, rounded."""
    factor = 1.0 + 0.12 * (round_num - 30)
    return max(base, round(base * factor))


def _scale_interval(base: float, round_num: int) -> float:
    """Gradually reduce spawn interval (floors at 0.4s)."""
    reduction = 0.015 * (round_num - 30)
    return round(max(0.4, base - reduction), 2)


def generate_wave(round_num: int) -> str:
    """Return a GDScript wave dictionary string for the given round number."""
    random.seed(round_num)  # deterministic per round

    groups = []
    num_groups = min(2 + (round_num - 30) // 5, 6)  # grows with rounds

    delays_used = []
    delay_cursor = 0.0

    for i in range(num_groups):
        enemy = _choose_enemy(round_num, exclude=groups[-1]["enemy"] if groups else None)
        base_count = {
            "cultist": 20, "deep_one": 12, "mist_wraith": 10,
            "brine_brute": 5, "oracle_of_rot": 4, "spawn_of_the_sleeper": 2,
        }[enemy]
        count = _scale_count(base_count, round_num)

        base_interval = {
            "cultist": 0.5, "deep_one": 0.9, "mist_wraith": 0.7,
            "brine_brute": 2.5, "oracle_of_rot": 2.0, "spawn_of_the_sleeper": 5.0,
        }[enemy]
        interval = _scale_interval(base_interval, round_num)

        delay = round(delay_cursor, 1)
        delay_cursor += count * interval * 0.5 + 3.0  # next group starts partway through

        groups.append({"enemy": enemy, "count": count, "interval": interval, "delay": delay})

    group_strs = []
    for g in groups:
        group_strs.append(
            f'{{\"enemy\":\"{g["enemy"]}\",\"count\":{g["count"]},\"interval\":{g["interval"]},\"delay\":{g["delay"]}}}'
        )

    groups_joined = ",".join(group_strs)
    return f'\t\t{{\"groups\": [{groups_joined}]}},'


def get_current_round_count(wave_data: str) -> int:
    """Count the number of wave entries (lines starting with a group block)."""
    # Each wave entry is a dict with a "groups" key inside the return array.
    matches = re.findall(r'\{"groups":', wave_data)
    return len(matches)


def append_wave(wave_data: str, new_wave_str: str) -> str:
    """Insert the new wave just before the closing bracket of the return array."""
    # Find the last line that looks like a wave entry and insert after it.
    # The return array ends with `\n\t]` inside get_all_waves().
    marker = "\n\t]"
    idx = wave_data.rfind(marker)
    if idx == -1:
        raise ValueError("Could not find closing bracket of wave array in WaveData.gd")
    return wave_data[:idx] + "\n" + new_wave_str + wave_data[idx:]


def update_total_rounds(gm_data: str, new_total: int) -> str:
    return re.sub(
        r'(const TOTAL_ROUNDS\s*:=\s*)\d+',
        rf'\g<1>{new_total}',
        gm_data
    )


def main():
    repo_root = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
    wave_path = os.path.join(repo_root, WAVE_DATA_PATH)
    gm_path = os.path.join(repo_root, GAME_MANAGER_PATH)

    with open(wave_path, "r") as f:
        wave_data = f.read()

    current_count = get_current_round_count(wave_data)
    new_round_num = current_count + 1

    print(f"Current rounds: {current_count}")
    print(f"Generating round {new_round_num}...")

    new_wave = generate_wave(new_round_num)
    updated_wave_data = append_wave(wave_data, new_wave)

    with open(wave_path, "w") as f:
        f.write(updated_wave_data)

    with open(gm_path, "r") as f:
        gm_data = f.read()

    updated_gm = update_total_rounds(gm_data, new_round_num)

    with open(gm_path, "w") as f:
        f.write(updated_gm)

    print(f"Done. Round {new_round_num} added. TOTAL_ROUNDS updated to {new_round_num}.")


if __name__ == "__main__":
    main()
