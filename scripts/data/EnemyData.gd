extends Node
## Static definitions for all six enemy types.

const ENEMIES: Dictionary = {
	"cultist": {
		"id": "cultist",
		"name": "Cultist",
		"description": "A fanatical human servant of the Old Ones.",
		"max_hp": 60,
		"speed": 80.0,
		"reward": 8,
		"damage_to_base": 1,
		"color": Color(0.5, 0.2, 0.1),
		"size": 14.0,
	},
	"deep_one": {
		"id": "deep_one",
		"name": "Deep One",
		"description": "An amphibious horror from the sunken depths.",
		"max_hp": 150,
		"speed": 60.0,
		"reward": 15,
		"damage_to_base": 2,
		"color": Color(0.1, 0.4, 0.5),
		"size": 18.0,
	},
	"mist_wraith": {
		"id": "mist_wraith",
		"name": "Mist Wraith",
		"description": "An intangible spirit immune to salt rounds.",
		"max_hp": 80,
		"speed": 120.0,
		"reward": 12,
		"damage_to_base": 1,
		"color": Color(0.7, 0.7, 0.9),
		"size": 16.0,
		"immune_to": ["salt_cannon"],
	},
	"brine_brute": {
		"id": "brine_brute",
		"name": "Brine Brute",
		"description": "A massive barnacle-encrusted abomination.",
		"max_hp": 400,
		"speed": 40.0,
		"reward": 30,
		"damage_to_base": 3,
		"color": Color(0.3, 0.5, 0.2),
		"size": 26.0,
	},
	"oracle_of_rot": {
		"id": "oracle_of_rot",
		"name": "Oracle of Rot",
		"description": "A prophetic abomination that buffs nearby enemies.",
		"max_hp": 200,
		"speed": 55.0,
		"reward": 25,
		"damage_to_base": 2,
		"color": Color(0.6, 0.3, 0.0),
		"size": 20.0,
		"aura_radius": 80.0,
		"aura_speed_bonus": 0.25,
	},
	"spawn_of_the_sleeper": {
		"id": "spawn_of_the_sleeper",
		"name": "Spawn of the Sleeper",
		"description": "A primordial horror, herald of the end.",
		"max_hp": 1200,
		"speed": 30.0,
		"reward": 80,
		"damage_to_base": 5,
		"color": Color(0.1, 0.05, 0.2),
		"size": 36.0,
	}
}

static func get_enemy(id: String) -> Dictionary:
	return ENEMIES.get(id, {})
