extends BaseEnemy
## Boss enemy. Spawns cultists when taking significant damage.

var _spawn_threshold: int = 0
var _spawns_remaining: int = 3

func _ready() -> void:
	enemy_id = "spawn_of_the_sleeper"
	super._ready()
	_spawn_threshold = _max_hp / 4

func take_damage(amount: int) -> void:
	var hp_before := _hp
	super.take_damage(amount)
	if _spawns_remaining > 0 and _hp > 0:
		var crossed_threshold := (hp_before / _spawn_threshold) > (_hp / _spawn_threshold)
		if crossed_threshold:
			_spawn_cultists()

func _spawn_cultists() -> void:
	_spawns_remaining -= 1
	var cultist_scene: PackedScene = load("res://scenes/enemies/Cultist.tscn")
	for i in 2:
		var c: Node = cultist_scene.instantiate()
		get_parent().add_child(c)
		c.global_position = global_position + Vector2(randf_range(-20, 20), randf_range(-20, 20))
