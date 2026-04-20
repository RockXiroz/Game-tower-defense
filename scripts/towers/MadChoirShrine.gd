extends BaseTower

const PROJECTILE_SCENE := preload("res://scenes/towers/Projectile.tscn")

func _ready() -> void:
	tower_id = "mad_choir_shrine"
	super._ready()

func _fire() -> void:
	if not is_instance_valid(_target):
		return
	var proj: Projectile = PROJECTILE_SCENE.instantiate()
	proj.target = _target
	proj.damage = _level_data.get("damage", 10)
	proj.confusion_duration = _level_data.get("confusion_duration", 2.0)
	proj.speed = 200.0
	proj.global_position = global_position
	if proj.visual:
		proj.visual.color = Color(0.2, 0.8, 0.6)
	get_tree().root.add_child(proj)
