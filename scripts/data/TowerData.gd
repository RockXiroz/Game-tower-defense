extends Node
## Static data definitions for all four tower types.

const TOWERS: Dictionary = {
	"harpoon_turret": {
		"id": "harpoon_turret",
		"name": "Harpoon Turret",
		"description": "Fires harpoons that pierce enemies.",
		"cost": 75,
		"color": Color(0.6, 0.4, 0.2),
		"key": "1",
		"levels": [
			{"damage": 25, "range": 150.0, "fire_rate": 1.2, "sell_value": 37},
			{"damage": 45, "range": 170.0, "fire_rate": 1.4, "sell_value": 75, "upgrade_cost": 80},
			{"damage": 70, "range": 190.0, "fire_rate": 1.6, "sell_value": 125, "upgrade_cost": 120},
		]
	},
	"occult_obelisk": {
		"id": "occult_obelisk",
		"name": "Occult Obelisk",
		"description": "Slows and weakens enemies with arcane energy.",
		"cost": 100,
		"color": Color(0.4, 0.1, 0.6),
		"key": "2",
		"levels": [
			{"damage": 15, "range": 130.0, "fire_rate": 0.8, "slow": 0.4, "sell_value": 50},
			{"damage": 28, "range": 150.0, "fire_rate": 1.0, "slow": 0.5, "sell_value": 100, "upgrade_cost": 100},
			{"damage": 45, "range": 175.0, "fire_rate": 1.2, "slow": 0.6, "sell_value": 165, "upgrade_cost": 150},
		]
	},
	"salt_cannon": {
		"id": "salt_cannon",
		"name": "Salt Cannon",
		"description": "Fires blessed salt in an AoE burst.",
		"cost": 125,
		"color": Color(0.9, 0.9, 0.8),
		"key": "3",
		"levels": [
			{"damage": 40, "range": 120.0, "fire_rate": 0.5, "aoe_radius": 60.0, "sell_value": 62},
			{"damage": 70, "range": 140.0, "fire_rate": 0.65, "aoe_radius": 75.0, "sell_value": 125, "upgrade_cost": 110},
			{"damage": 110, "range": 160.0, "fire_rate": 0.8, "aoe_radius": 90.0, "sell_value": 200, "upgrade_cost": 160},
		]
	},
	"mad_choir_shrine": {
		"id": "mad_choir_shrine",
		"name": "Mad Choir Shrine",
		"description": "Drives enemies mad, causing them to damage each other.",
		"cost": 150,
		"color": Color(0.2, 0.6, 0.5),
		"key": "4",
		"levels": [
			{"damage": 10, "range": 140.0, "fire_rate": 2.0, "confusion_duration": 2.0, "sell_value": 75},
			{"damage": 18, "range": 160.0, "fire_rate": 2.5, "confusion_duration": 3.0, "sell_value": 150, "upgrade_cost": 130},
			{"damage": 30, "range": 185.0, "fire_rate": 3.0, "confusion_duration": 4.0, "sell_value": 240, "upgrade_cost": 180},
		]
	}
}

static func get_tower(id: String) -> Dictionary:
	return TOWERS.get(id, {})

static func get_all_ids() -> Array:
	return TOWERS.keys()

static func get_level_data(id: String, level: int) -> Dictionary:
	var tower := TOWERS.get(id, {})
	var levels: Array = tower.get("levels", [])
	if level < levels.size():
		return levels[level]
	return {}
