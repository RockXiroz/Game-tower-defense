extends Node
## Processes all keyboard input and delegates to the game scene.
## Kept separate so UI and game logic don't need direct coupling.

signal move_cursor(delta: Vector2i)
signal build_tower(index: int)
signal upgrade_tower
signal sell_tower
signal start_wave
signal toggle_pause_requested
signal cancel_action

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("move_up"):
		move_cursor.emit(Vector2i(0, -1))
	elif event.is_action_pressed("move_down"):
		move_cursor.emit(Vector2i(0, 1))
	elif event.is_action_pressed("move_left"):
		move_cursor.emit(Vector2i(-1, 0))
	elif event.is_action_pressed("move_right"):
		move_cursor.emit(Vector2i(1, 0))
	elif event.is_action_pressed("confirm"):
		# confirm acts as upgrade if tower exists, else no-op (build uses 1-4)
		upgrade_tower.emit()
	elif event.is_action_pressed("cancel"):
		cancel_action.emit()
	elif event.is_action_pressed("build_1"):
		build_tower.emit(0)
	elif event.is_action_pressed("build_2"):
		build_tower.emit(1)
	elif event.is_action_pressed("build_3"):
		build_tower.emit(2)
	elif event.is_action_pressed("build_4"):
		build_tower.emit(3)
	elif event.is_action_pressed("upgrade"):
		upgrade_tower.emit()
	elif event.is_action_pressed("sell"):
		sell_tower.emit()
	elif event.is_action_pressed("next_wave"):
		start_wave.emit()
	elif event.is_action_pressed("pause"):
		toggle_pause_requested.emit()
