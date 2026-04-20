extends Node
## Handles wave spawning. Reads wave data and spawns enemies along the path.

signal wave_started(round: int)
signal wave_ended(round: int)
signal all_waves_complete

@export var spawn_point: Node2D
@export var enemy_path: Path2D

var _wave_data: Array = []
var _active_enemies: int = 0
var _spawning: bool = false
var _current_wave_index: int = 0
var _spawn_queue: Array = []

func _ready() -> void:
	_wave_data = WaveData.get_all_waves()

func start_wave(round_number: int) -> void:
	if _spawning or round_number < 1 or round_number > _wave_data.size():
		return
	_current_wave_index = round_number - 1
	var wave: Dictionary = _wave_data[_current_wave_index]
	_build_spawn_queue(wave)
	_spawning = true
	_active_enemies = 0
	wave_started.emit(round_number)
	_process_spawn_queue()

func _build_spawn_queue(wave: Dictionary) -> void:
	_spawn_queue.clear()
	for group in wave.get("groups", []):
		var enemy_id: String = group["enemy"]
		var count: int = group["count"]
		var interval: float = group.get("interval", 1.0)
		var delay: float = group.get("delay", 0.0)
		for i in count:
			_spawn_queue.append({
				"enemy": enemy_id,
				"time": delay + i * interval
			})
	_spawn_queue.sort_custom(func(a, b): return a["time"] < b["time"])

func _process_spawn_queue() -> void:
	if _spawn_queue.is_empty():
		return
	var first_entry: Dictionary = _spawn_queue[0]
	var timer := get_tree().create_timer(first_entry["time"])
	timer.timeout.connect(_spawn_next.bind(first_entry["time"]))

func _spawn_next(elapsed: float) -> void:
	if _spawn_queue.is_empty():
		return
	var entry: Dictionary = _spawn_queue.pop_front()
	_spawn_enemy(entry["enemy"])
	if not _spawn_queue.is_empty():
		var next_time: float = _spawn_queue[0]["time"] - elapsed
		var timer := get_tree().create_timer(maxf(0.0, next_time))
		timer.timeout.connect(_spawn_next.bind(_spawn_queue[0]["time"]))

func _spawn_enemy(enemy_id: String) -> void:
	var scene_path: String = "res://scenes/enemies/%s.tscn" % enemy_id
	if not ResourceLoader.exists(scene_path):
		push_warning("Enemy scene not found: " + scene_path)
		return
	var enemy_scene: PackedScene = load(scene_path)
	var enemy: Node = enemy_scene.instantiate()
	enemy.died.connect(_on_enemy_died)
	enemy.reached_end.connect(_on_enemy_reached_end)
	get_parent().add_child(enemy)
	enemy.global_position = spawn_point.global_position if spawn_point else Vector2.ZERO
	_active_enemies += 1

func _on_enemy_died() -> void:
	_active_enemies -= 1
	_check_wave_end()

func _on_enemy_reached_end() -> void:
	_active_enemies -= 1
	_check_wave_end()

func _check_wave_end() -> void:
	if _active_enemies <= 0 and _spawn_queue.is_empty() and _spawning:
		_spawning = false
		wave_ended.emit(_current_wave_index + 1)
		GameManager.on_wave_complete()
