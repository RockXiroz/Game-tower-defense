extends CanvasLayer
## Heads-up display. Shows round, HP, currency, and selected cell info.
## Also handles all keyboard input for the game.

@onready var label_round: Label = $TopBar/RoundLabel
@onready var label_lives: Label = $TopBar/LivesLabel
@onready var label_currency: Label = $TopBar/CurrencyLabel
@onready var label_wave_status: Label = $TopBar/WaveStatusLabel
@onready var panel_tower_info: PanelContainer = $TowerInfoPanel
@onready var label_tower_name: Label = $TowerInfoPanel/VBox/TowerName
@onready var label_tower_level: Label = $TowerInfoPanel/VBox/TowerLevel
@onready var label_upgrade_cost: Label = $TowerInfoPanel/VBox/UpgradeCost
@onready var label_sell_value: Label = $TowerInfoPanel/VBox/SellValue
@onready var label_controls: Label = $ControlsPanel/ControlsLabel
@onready var overlay_pause: ColorRect = $PauseOverlay
@onready var overlay_gameover: ColorRect = $GameOverOverlay
@onready var label_gameover: Label = $GameOverOverlay/Label

var _game_ref: Node = null
var _wave_active: bool = false

func _ready() -> void:
	GameManager.currency_changed.connect(_on_currency_changed)
	GameManager.lives_changed.connect(_on_lives_changed)
	GameManager.round_changed.connect(_on_round_changed)
	GameManager.game_over.connect(_on_game_over)
	_refresh_labels()
	panel_tower_info.hide()
	overlay_pause.hide()
	overlay_gameover.hide()

func set_game_ref(game: Node) -> void:
	_game_ref = game

func _refresh_labels() -> void:
	label_round.text = "Round: %d / %d" % [GameManager.current_round, GameManager.TOTAL_ROUNDS]
	label_lives.text = "HP: %d" % GameManager.lives
	label_currency.text = "Gold: %d" % GameManager.currency

func _on_currency_changed(v: int) -> void:
	label_currency.text = "Gold: %d" % v

func _on_lives_changed(v: int) -> void:
	label_lives.text = "HP: %d" % v

func _on_round_changed(v: int) -> void:
	label_round.text = "Round: %d / %d" % [v, GameManager.TOTAL_ROUNDS]

func _on_game_over(victory: bool) -> void:
	overlay_gameover.show()
	if victory:
		label_gameover.text = "VICTORY!\nThe Old Ones are held at bay... for now.\n\nPress Esc to quit"
		overlay_gameover.color = Color(0.0, 0.2, 0.1, 0.85)
	else:
		label_gameover.text = "DEFEAT!\nThe Keep has fallen to the darkness.\n\nPress Esc to quit"
		overlay_gameover.color = Color(0.3, 0.0, 0.0, 0.85)

func update_selected_cell(cell: Vector2i, grid: GridMap) -> void:
	var tower: BaseTower = grid.get_tower_at(cell)
	if tower:
		panel_tower_info.show()
		label_tower_name.text = tower.get_display_name() + " (Lv %d)" % (tower.get_level() + 1)
		label_tower_level.text = "Max Level" if tower.is_max_level() else "Level %d" % (tower.get_level() + 1)
		if tower.is_max_level():
			label_upgrade_cost.text = "Upgrade: MAX"
		else:
			label_upgrade_cost.text = "Upgrade: %d G" % tower.get_upgrade_cost()
		label_sell_value.text = "Sell: %d G" % tower.get_sell_value()
	else:
		panel_tower_info.hide()

func set_wave_status(text: String) -> void:
	label_wave_status.text = text

func show_pause(paused: bool) -> void:
	overlay_pause.visible = paused
