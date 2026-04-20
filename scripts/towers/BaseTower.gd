extends Node2D
class_name BaseTower
## Base class for all towers. Handles targeting, firing, and upgrades.

signal tower_sold(refund: int)

@export var tower_id: String = ""

var _data: Dictionary = {}
var _level: int = 0
var _level_data: Dictionary = {}
var _target: Node2D = null
var _fire_timer: float = 0.0
var _enemies_in_range: Array[Node2D] = []

@onready var range_indicator: Node2D = $RangeIndicator
@onready var body_visual: ColorRect = $BodyVisual

func _ready() -> void:
	_data = TowerData.get_tower(tower_id)
	_apply_level_data()
	_update_visuals()
	var area: Area2D = $DetectionArea
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)

func _apply_level_data() -> void:
	_level_data = TowerData.get_level_data(tower_id, _level)
	var range_val: float = _level_data.get("range", 100.0)
	var area: Area2D = $DetectionArea
	var shape: CircleShape2D = area.get_node("CollisionShape2D").shape
	shape.radius = range_val
	if range_indicator:
		range_indicator.scale = Vector2.ONE * (range_val / 50.0)

func _update_visuals() -> void:
	if body_visual and _data.has("color"):
		body_visual.color = _data["color"]

func _process(delta: float) -> void:
	_fire_timer -= delta
	_pick_target()
	if _target and _fire_timer <= 0.0:
		_fire()
		var rate: float = _level_data.get("fire_rate", 1.0)
		_fire_timer = 1.0 / rate

func _pick_target() -> void:
	_enemies_in_range = _enemies_in_range.filter(func(e): return is_instance_valid(e) and not e.is_queued_for_deletion())
	if _target == null or not is_instance_valid(_target):
		_target = null
	if _target == null and not _enemies_in_range.is_empty():
		_target = _enemies_in_range[0]

func _fire() -> void:
	# Overridden by subclasses
	pass

func upgrade() -> bool:
	var levels: Array = _data.get("levels", [])
	if _level + 1 >= levels.size():
		return false
	var next_level_data: Dictionary = levels[_level + 1]
	var cost: int = next_level_data.get("upgrade_cost", 9999)
	if GameManager.spend(cost):
		_level += 1
		_apply_level_data()
		return true
	return false

func sell() -> void:
	var sell_val: int = _level_data.get("sell_value", 0)
	GameManager.earn(sell_val)
	tower_sold.emit(sell_val)
	queue_free()

func get_upgrade_cost() -> int:
	var levels: Array = _data.get("levels", [])
	if _level + 1 >= levels.size():
		return -1
	return levels[_level + 1].get("upgrade_cost", 9999)

func get_sell_value() -> int:
	return _level_data.get("sell_value", 0)

func get_display_name() -> String:
	return _data.get("name", tower_id)

func get_level() -> int:
	return _level

func is_max_level() -> bool:
	return _level + 1 >= _data.get("levels", []).size()

func show_range(visible: bool) -> void:
	if range_indicator:
		range_indicator.visible = visible

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		_enemies_in_range.append(body)

func _on_body_exited(body: Node2D) -> void:
	_enemies_in_range.erase(body)
