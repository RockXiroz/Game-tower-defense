extends Node2D
## Root game scene. Orchestrates the grid, waves, towers, and HUD.

const TOWER_SCENES: Dictionary = {
	"harpoon_turret": "res://scenes/towers/HarpoonTurret.tscn",
	"occult_obelisk": "res://scenes/towers/OccultObelisk.tscn",
	"salt_cannon": "res://scenes/towers/SaltCannon.tscn",
	"mad_choir_shrine": "res://scenes/towers/MadChoirShrine.tscn",
}
const TOWER_ORDER: Array = ["harpoon_turret", "occult_obelisk", "salt_cannon", "mad_choir_shrine"]

@onready var grid: GridMap = $GridMap
@onready var hud: Node = $HUD
@onready var wave_manager: Node = $WaveManager
@onready var input_handler: Node = $InputHandler
@onready var spawn_point: Node2D = $SpawnPoint
@onready var towers_container: Node2D = $TowersContainer

var _wave_running: bool = false

func _ready() -> void:
	GameManager.reset()
	hud.set_game_ref(self)

	# Wire input
	input_handler.move_cursor.connect(_on_move_cursor)
	input_handler.build_tower.connect(_on_build_tower)
	input_handler.upgrade_tower.connect(_on_upgrade_tower)
	input_handler.sell_tower.connect(_on_sell_tower)
	input_handler.start_wave.connect(_on_start_wave)
	input_handler.toggle_pause_requested.connect(_on_toggle_pause)
	input_handler.cancel_action.connect(_on_cancel)

	# Wire wave manager
	wave_manager.spawn_point = spawn_point
	wave_manager.wave_started.connect(_on_wave_started)
	wave_manager.wave_ended.connect(_on_wave_ended)

	# Wire grid
	grid.cell_selected.connect(_on_cell_selected)

	hud.set_wave_status("Press N to start Wave 1")

func _on_move_cursor(delta: Vector2i) -> void:
	grid.move_cursor(delta)
	var cell := grid.get_cursor_cell()
	hud.update_selected_cell(cell, grid)

func _on_build_tower(index: int) -> void:
	if index < 0 or index >= TOWER_ORDER.size():
		return
	var cell := grid.get_cursor_cell()
	if not grid.is_buildable(cell):
		return
	var tower_id: String = TOWER_ORDER[index]
	var cost: int = TowerData.get_tower(tower_id).get("cost", 9999)
	if not GameManager.spend(cost):
		return
	var scene: PackedScene = load(TOWER_SCENES[tower_id])
	var tower: BaseTower = scene.instantiate()
	towers_container.add_child(tower)
	grid.place_tower(cell, tower)
	tower.tower_sold.connect(_on_tower_sold.bind(cell))
	hud.update_selected_cell(cell, grid)

func _on_upgrade_tower() -> void:
	var cell := grid.get_cursor_cell()
	var tower: BaseTower = grid.get_tower_at(cell)
	if tower:
		tower.upgrade()
		hud.update_selected_cell(cell, grid)

func _on_sell_tower() -> void:
	var cell := grid.get_cursor_cell()
	var tower: BaseTower = grid.get_tower_at(cell)
	if tower:
		tower.sell()

func _on_tower_sold(cell: Vector2i) -> void:
	grid.remove_tower(cell)
	hud.update_selected_cell(cell, grid)

func _on_start_wave() -> void:
	if _wave_running or not GameManager.game_active:
		return
	if GameManager.current_round >= GameManager.TOTAL_ROUNDS:
		return
	GameManager.advance_round()
	_wave_running = true
	wave_manager.start_wave(GameManager.current_round)

func _on_wave_started(round: int) -> void:
	hud.set_wave_status("Wave %d in progress..." % round)

func _on_wave_ended(round: int) -> void:
	_wave_running = false
	if GameManager.current_round >= GameManager.TOTAL_ROUNDS:
		hud.set_wave_status("All waves complete! Victory!")
	else:
		hud.set_wave_status("Wave %d complete! Press N for next wave." % round)

func _on_toggle_pause() -> void:
	if not GameManager.game_active:
		return
	GameManager.toggle_pause()
	hud.show_pause(GameManager.is_paused)

func _on_cancel() -> void:
	if GameManager.is_paused:
		GameManager.toggle_pause()
		hud.show_pause(false)

func _on_cell_selected(cell: Vector2i) -> void:
	hud.update_selected_cell(cell, grid)
	# Show range ring on selected tower
	for t in towers_container.get_children():
		if t is BaseTower:
			t.show_range(false)
	var tower: BaseTower = grid.get_tower_at(cell)
	if tower:
		tower.show_range(true)
