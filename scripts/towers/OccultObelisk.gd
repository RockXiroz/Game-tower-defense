extends BaseTower

const PROJECTILE_SCENE := preload("res://scenes/towers/Projectile.tscn")

func _ready() -> void:
	tower_id = "occult_obelisk"
	super._ready()

func _fire() -> void:
	if not is_instance_valid(_target):
		return
	var proj: Projectile = PROJECTILE_SCENE.instantiate()
	proj.target = _target
	proj.damage = _level_data.get("damage", 15)
	proj.slow_amount = _level_data.get("slow", 0.4)
	proj.speed = 250.0
	proj.global_position = global_position
	if proj.visual:
		proj.visual.color = Color(0.5, 0.1, 0.9)
	get_tree().root.add_child(proj)
