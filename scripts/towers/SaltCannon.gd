extends BaseTower

const PROJECTILE_SCENE := preload("res://scenes/towers/Projectile.tscn")

func _ready() -> void:
	tower_id = "salt_cannon"
	super._ready()

func _fire() -> void:
	if not is_instance_valid(_target):
		return
	var proj: Projectile = PROJECTILE_SCENE.instantiate()
	proj.target = _target
	proj.damage = _level_data.get("damage", 40)
	proj.aoe_radius = _level_data.get("aoe_radius", 60.0)
	proj.speed = 280.0
	proj.global_position = global_position
	if proj.visual:
		proj.visual.color = Color(0.95, 0.95, 0.8)
	get_tree().root.add_child(proj)
