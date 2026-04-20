# Cthulhu Keep — Architecture Guide

## Overview

Cthulhu Keep is a Godot 4 tower defense game inspired by Kingdom Rush, set in the Lovecraftian cosmic horror universe. The project targets macOS and is structured for a future Steam release.

## Folder Structure

```
CthulhuKeep/
├── project.godot           # Engine config, autoloads, input map
├── icon.svg                # Game icon
├── scenes/
│   ├── main/Main.tscn      # Root scene (entry point)
│   ├── game/Game.tscn      # Main game scene
│   ├── ui/HUD.tscn         # Heads-up display overlay
│   ├── towers/             # One .tscn per tower type
│   └── enemies/            # One .tscn per enemy type
├── scripts/
│   ├── managers/
│   │   ├── GameManager.gd  # Autoload: currency, lives, rounds, signals
│   │   ├── WaveManager.gd  # Spawns enemies each wave
│   │   ├── GridMap.gd      # Grid state, path definition, cursor
│   │   ├── InputHandler.gd # Keyboard input → signals
│   │   └── Game.gd         # Scene root: wires everything together
│   ├── towers/
│   │   ├── BaseTower.gd    # Targeting, firing, upgrade/sell logic
│   │   ├── Projectile.gd   # Moving projectile with damage/effects
│   │   ├── HarpoonTurret.gd
│   │   ├── OccultObelisk.gd
│   │   ├── SaltCannon.gd
│   │   └── MadChoirShrine.gd
│   ├── enemies/
│   │   ├── BaseEnemy.gd    # Path following, HP, slow/confusion effects
│   │   ├── Cultist.gd
│   │   ├── DeepOne.gd
│   │   ├── MistWraith.gd
│   │   ├── BrineBrute.gd
│   │   ├── OracleOfRot.gd  # Buffs nearby enemies
│   │   └── SpawnOfTheSleeper.gd  # Boss: spawns cultists on damage
│   ├── ui/
│   │   └── HUD.gd
│   └── data/
│       ├── TowerData.gd    # Autoload: static tower stats/costs
│       ├── EnemyData.gd    # Autoload: static enemy stats
│       └── WaveData.gd     # Autoload: all 30 wave definitions
└── assets/                 # Placeholder (textures, audio, fonts)
```

## Architecture Patterns

### Autoloads (Singletons)
`GameManager`, `TowerData`, `EnemyData`, and `WaveData` are registered as autoloads in `project.godot`. Any script can access them by name without imports.

### Signal Flow
```
InputHandler → signals → Game.gd (orchestrator)
                              ↓
                    GridMap / WaveManager / BaseTower
                              ↓
                    GameManager signals → HUD.gd
```

### Grid System
The map is an 18×10 tile grid (64px tiles = 1152×640 viewport usable area). The `GridMap` node:
- Stores which cells are occupied by towers (`_occupied_cells`)
- Marks path cells as unbuildable (`_path_cells`)
- Draws the grid using `_draw()` (no TextureRect, just `draw_rect`)
- Exports `get_path_points()` → PackedVector2Array for enemy path following

### Enemy Path
Defined as waypoints in `GridMap.PATH_WAYPOINTS`. The `BaseEnemy` fetches them from the map node on `_ready()` and walks them sequentially. Enemies use `CharacterBody2D.move_and_slide()`.

### Tower Targeting
Each tower has an `Area2D` (collision mask = layer 2, which enemies are on). When enemies enter/exit the area, they're added/removed from `_enemies_in_range`. The first valid enemy in that list is targeted.

### Wave System
`WaveData` returns an array of 30 wave dictionaries. Each wave has "groups" specifying enemy type, count, spawn interval, and initial delay. `WaveManager` builds a sorted time-based spawn queue and uses `SceneTree.create_timer()` for scheduling.

## Keyboard Controls

| Key | Action |
|-----|--------|
| WASD / Arrows | Move grid cursor |
| 1–4 | Build tower (Harpoon / Obelisk / Salt / Shrine) |
| U or Enter | Upgrade selected tower |
| S | Sell selected tower |
| N | Start next wave |
| P | Pause / Unpause |
| Esc | Cancel / Unpause |

## Tower Types

| Tower | Cost | Effect |
|-------|------|--------|
| Harpoon Turret | 75G | Fast single-target physical damage |
| Occult Obelisk | 100G | Slows enemies, magic damage |
| Salt Cannon | 125G | AoE burst (ineffective vs. Mist Wraiths) |
| Mad Choir Shrine | 150G | Confusion: reverses enemy movement |

## Enemy Types

| Enemy | HP | Speed | Notes |
|-------|-----|-------|-------|
| Cultist | 60 | Fast | Basic cannon fodder |
| Deep One | 150 | Medium | Tanky amphibian |
| Mist Wraith | 80 | Very fast | Immune to Salt Cannon |
| Brine Brute | 400 | Slow | High armor, heavy base damage |
| Oracle of Rot | 200 | Medium | Buffs nearby enemy speed |
| Spawn of the Sleeper | 1200 | Very slow | Boss; spawns Cultists when hurt |

## 30-Wave Progression

- Rounds 1–5: Cultist introduction, Deep Ones appear round 3
- Rounds 6–10: Mist Wraiths and first Brine Brute
- Rounds 11–15: Oracle of Rot introduced, midpoint boss wave
- Rounds 16–20: Increased density, mixed types
- Rounds 21–25: Spawn of the Sleeper appears
- Rounds 26–30: Maximum density, final wave is all 6 types simultaneously

## Adding Content

**New tower**: Create `scripts/towers/MyTower.gd` extending `BaseTower`, add stats to `TowerData.gd`, create `scenes/towers/MyTower.tscn`, add to `TOWER_SCENES` and `TOWER_ORDER` in `Game.gd`.

**New enemy**: Create `scripts/enemies/MyEnemy.gd` extending `BaseEnemy`, add stats to `EnemyData.gd`, create `scenes/enemies/MyEnemy.tscn`, reference in `WaveData.gd`.

**New map**: Modify `GridMap.PATH_WAYPOINTS` and adjust `GRID_COLS`/`GRID_ROWS` as needed.
