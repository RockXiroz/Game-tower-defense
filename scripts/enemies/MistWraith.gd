extends BaseEnemy

func _ready() -> void:
	enemy_id = "mist_wraith"
	super._ready()

func take_damage(amount: int) -> void:
	# Immune to salt cannon projectiles (filtered in Projectile._apply_to via group check)
	super.take_damage(amount)
