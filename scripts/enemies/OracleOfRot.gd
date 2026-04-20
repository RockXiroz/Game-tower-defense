extends BaseEnemy
## Buffs nearby enemies with speed increase.

var _aura_timer: float = 0.0

func _ready() -> void:
	enemy_id = "oracle_of_rot"
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	_aura_timer -= delta
	if _aura_timer <= 0.0:
		_aura_timer = 0.5
		_apply_aura()

func _apply_aura() -> void:
	var aura_radius: float = _data.get("aura_radius", 80.0)
	var speed_bonus: float = _data.get("aura_speed_bonus", 0.25)
	var enemies := get_tree().get_nodes_in_group("enemies")
	for e in enemies:
		if e == self:
			continue
		if e.global_position.distance_to(global_position) <= aura_radius:
			if e.has_method("apply_aura_bonus"):
				e.apply_aura_bonus(speed_bonus)
