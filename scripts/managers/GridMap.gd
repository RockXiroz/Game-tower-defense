extends Node2D
class_name GridMap
## Manages the tile grid for tower placement. Tracks which cells are occupied
## and which are on the enemy path (not buildable).

const TILE_SIZE := 64
const GRID_COLS := 18
const GRID_ROWS := 10

# Path waypoints in grid coordinates (col, row)
const PATH_WAYPOINTS: Array = [
	Vector2i(0, 2),
	Vector2i(4, 2),
	Vector2i(4, 7),
	Vector2i(9, 7),
	Vector2i(9, 2),
	Vector2i(14, 2),
	Vector2i(14, 7),
	Vector2i(17, 7),
]

var _occupied_cells: Dictionary = {}   # Vector2i -> BaseTower
var _path_cells: Array[Vector2i] = []  # cells that are ON the path

var _path_world_points: PackedVector2Array = []
var _cursor_cell: Vector2i = Vector2i(5, 5)

signal cell_selected(cell: Vector2i)

func _ready() -> void:
	add_to_group("game_map")
	_build_path_cells()
	_build_world_path()

func _build_path_cells() -> void:
	for i in range(PATH_WAYPOINTS.size() - 1):
		var from: Vector2i = PATH_WAYPOINTS[i]
		var to: Vector2i = PATH_WAYPOINTS[i + 1]
		var step: Vector2i = Vector2i(
			sign(to.x - from.x),
			sign(to.y - from.y)
		)
		var cur: Vector2i = from
		while cur != to:
			_path_cells.append(cur)
			cur += step
	_path_cells.append(PATH_WAYPOINTS[-1])

func _build_world_path() -> void:
	_path_world_points.clear()
	for wp in PATH_WAYPOINTS:
		_path_world_points.append(cell_to_world(wp))

func get_path_points() -> PackedVector2Array:
	return _path_world_points

func cell_to_world(cell: Vector2i) -> Vector2:
	return Vector2(cell.x * TILE_SIZE + TILE_SIZE / 2, cell.y * TILE_SIZE + TILE_SIZE / 2)

func world_to_cell(pos: Vector2) -> Vector2i:
	return Vector2i(int(pos.x / TILE_SIZE), int(pos.y / TILE_SIZE))

func is_buildable(cell: Vector2i) -> bool:
	if cell.x < 0 or cell.x >= GRID_COLS or cell.y < 0 or cell.y >= GRID_ROWS:
		return false
	if cell in _path_cells:
		return false
	if _occupied_cells.has(cell):
		return false
	return true

func place_tower(cell: Vector2i, tower: BaseTower) -> void:
	_occupied_cells[cell] = tower
	tower.global_position = cell_to_world(cell)

func remove_tower(cell: Vector2i) -> void:
	_occupied_cells.erase(cell)

func get_tower_at(cell: Vector2i) -> BaseTower:
	return _occupied_cells.get(cell, null)

func move_cursor(delta: Vector2i) -> void:
	_cursor_cell += delta
	_cursor_cell.x = clamp(_cursor_cell.x, 0, GRID_COLS - 1)
	_cursor_cell.y = clamp(_cursor_cell.y, 0, GRID_ROWS - 1)
	cell_selected.emit(_cursor_cell)
	queue_redraw()

func get_cursor_cell() -> Vector2i:
	return _cursor_cell

func _draw() -> void:
	# Draw grid
	for col in GRID_COLS:
		for row in GRID_ROWS:
			var cell := Vector2i(col, row)
			var rect := Rect2(col * TILE_SIZE, row * TILE_SIZE, TILE_SIZE, TILE_SIZE)
			if cell in _path_cells:
				draw_rect(rect, Color(0.4, 0.3, 0.15), true)
				draw_rect(rect, Color(0.3, 0.2, 0.1), false, 1.0)
			else:
				draw_rect(rect, Color(0.1, 0.15, 0.1), true)
				draw_rect(rect, Color(0.15, 0.2, 0.15), false, 1.0)

	# Highlight cursor
	var cr := Rect2(_cursor_cell.x * TILE_SIZE, _cursor_cell.y * TILE_SIZE, TILE_SIZE, TILE_SIZE)
	var color := Color(0.9, 0.9, 0.2, 0.5) if is_buildable(_cursor_cell) else Color(0.9, 0.2, 0.2, 0.5)
	draw_rect(cr, color, true)
	draw_rect(cr, Color(1, 1, 0, 0.8), false, 2.0)

	# Draw path lines
	for i in range(_path_world_points.size() - 1):
		draw_line(_path_world_points[i], _path_world_points[i + 1], Color(0.6, 0.4, 0.1), 3.0)
