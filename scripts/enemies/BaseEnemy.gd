extends CharacterBody2D
class_name BaseEnemy
## Base class for all enemies. Follows a path, takes damage, and reaches the end.

signal died
signal reached_end

@export var enemy_id: String = ""

var _data: Dictionary = {}
var _hp: int = 100
var _max_hp: int = 100
var _base_speed: float = 80.0
var _speed_multiplier: float = 1.0
var _slow_timer: float = 0.0
var _confused: bool = false
var _confusion_timer: float = 0.0
var _path_points: PackedVector2Array = []
var _path_index: int = 0
var _dead: bool = false

@onready var health_bar: ColorRect = $HealthBar
@onready var health_fill: ColorRect = $HealthBar/Fill
@onready var body_visual: ColorRect = $BodyVisual

func _ready() -> void:
	add_to_group("enemies")
	_data = EnemyData.get_enemy(enemy_id)
	_max_hp = _data.get("max_hp", 100)
	_hp = _max_hp
	_base_speed = _data.get("speed", 80.0)
	_update_visuals()
	# Receive path from the map
	var map := get_tree().get_first_node_in_group("game_map")
	if map:
		_path_points = map.get_path_points()

func _update_visuals() -> void:
	var size: float = _data.get("size", 14.0)
	if body_visual:
		body_visual.color = _data.get("color", Color.WHITE)
		body_visual.size = Vector2(size, size)
		body_visual.position = Vector2(-size / 2.0, -size / 2.0)

func _physics_process(delta: float) -> void:
	if _dead:
		return
	_update_timers(delta)
	if _confused:
		_do_confused_move(delta)
	else:
		_follow_path(delta)
	_update_health_bar()

func _update_timers(delta: float) -> void:
	if _slow_timer > 0.0:
		_slow_timer -= delta
		if _slow_timer <= 0.0:
			_speed_multiplier = 1.0
	if _confusion_timer > 0.0:
		_confusion_timer -= delta
		if _confusion_timer <= 0.0:
			_confused = false

func _follow_path(delta: float) -> void:
	if _path_index >= _path_points.size():
		_on_reached_end()
		return
	var target_pos: Vector2 = _path_points[_path_index]
	var dir := (target_pos - global_position)
	if dir.length() < 8.0:
		_path_index += 1
		return
	var effective_speed := _base_speed * _speed_multiplier
	velocity = dir.normalized() * effective_speed
	move_and_slide()

func _do_confused_move(delta: float) -> void:
	# Move backwards when confused
	if _path_index > 0:
		var target_pos: Vector2 = _path_points[_path_index - 1]
		var dir := (target_pos - global_position).normalized()
		velocity = dir * _base_speed * 0.5
		move_and_slide()

func _on_reached_end() -> void:
	if _dead:
		return
	_dead = true
	var dmg: int = _data.get("damage_to_base", 1)
	GameManager.lose_life(dmg)
	reached_end.emit()
	queue_free()

func take_damage(amount: int) -> void:
	if _dead:
		return
	_hp -= amount
	if _hp <= 0:
		_die()

func _die() -> void:
	if _dead:
		return
	_dead = true
	GameManager.earn(_data.get("reward", 5))
	died.emit()
	queue_free()

func apply_slow(factor: float, duration: float) -> void:
	_speed_multiplier = 1.0 - factor
	_slow_timer = duration

func apply_confusion(duration: float) -> void:
	_confused = true
	_confusion_timer = duration

func get_speed_bonus() -> float:
	return _data.get("aura_speed_bonus", 0.0)

func _update_health_bar() -> void:
	if health_fill:
		health_fill.scale.x = float(_hp) / float(_max_hp)
