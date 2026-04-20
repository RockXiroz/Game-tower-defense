extends Node2D
class_name Projectile
## Generic projectile. Moves toward a target and applies damage on hit.

var target: Node2D = null
var damage: int = 10
var speed: float = 300.0
var aoe_radius: float = 0.0
var slow_amount: float = 0.0
var confusion_duration: float = 0.0
var immune_check: String = ""

@onready var visual: ColorRect = $Visual

func _process(delta: float) -> void:
	if not is_instance_valid(target):
		queue_free()
		return
	var dir := (target.global_position - global_position).normalized()
	global_position += dir * speed * delta
	rotation = dir.angle()
	if global_position.distance_to(target.global_position) < 12.0:
		_on_hit()

func _on_hit() -> void:
	if aoe_radius > 0.0:
		_apply_aoe()
	else:
		_apply_to(target)
	queue_free()

func _apply_aoe() -> void:
	var enemies := get_tree().get_nodes_in_group("enemies")
	for e in enemies:
		if e.global_position.distance_to(global_position) <= aoe_radius:
			_apply_to(e)

func _apply_to(enemy: Node) -> void:
	if not is_instance_valid(enemy):
		return
	enemy.take_damage(damage)
	if slow_amount > 0.0:
		enemy.apply_slow(slow_amount, 2.0)
	if confusion_duration > 0.0:
		enemy.apply_confusion(confusion_duration)
