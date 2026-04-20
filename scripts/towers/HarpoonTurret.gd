extends BaseTower

const PROJECTILE_SCENE := preload("res://scenes/towers/Projectile.tscn")

func _ready() -> void:
	tower_id = "harpoon_turret"
	super._ready()

func _fire() -> void:
	if not is_instance_valid(_target):
		return
	var proj: Projectile = PROJECTILE_SCENE.instantiate()
	proj.target = _target
	proj.damage = _level_data.get("damage", 25)
	proj.speed = 350.0
	proj.global_position = global_position
	get_tree().root.add_child(proj)
