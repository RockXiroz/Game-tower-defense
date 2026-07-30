extends Node
## Central game state manager. Tracks currency, HP, round, and emits signals.

signal currency_changed(new_amount: int)
signal lives_changed(new_lives: int)
signal round_changed(new_round: int)
signal game_over(victory: bool)
signal wave_completed(round: int)

const STARTING_CURRENCY := 150
const STARTING_LIVES := 20
const TOTAL_ROUNDS := 73

var currency: int = STARTING_CURRENCY
var lives: int = STARTING_LIVES
var current_round: int = 0
var is_paused: bool = false
var game_active: bool = false

func _ready() -> void:
	reset()

func reset() -> void:
	currency = STARTING_CURRENCY
	lives = STARTING_LIVES
	current_round = 0
	is_paused = false
	game_active = true

func spend(amount: int) -> bool:
	if currency >= amount:
		currency -= amount
		currency_changed.emit(currency)
		return true
	return false

func earn(amount: int) -> void:
	currency += amount
	currency_changed.emit(currency)

func lose_life(amount: int = 1) -> void:
	lives = max(0, lives - amount)
	lives_changed.emit(lives)
	if lives <= 0:
		game_over.emit(false)
		game_active = false

func on_wave_complete() -> void:
	wave_completed.emit(current_round)
	if current_round >= TOTAL_ROUNDS:
		game_over.emit(true)
		game_active = false

func advance_round() -> void:
	current_round += 1
	round_changed.emit(current_round)

func can_afford(amount: int) -> bool:
	return currency >= amount

func toggle_pause() -> void:
	is_paused = !is_paused
	get_tree().paused = is_paused
