extends Node

signal pinch_detected()

onready var _animation_player = $AnimationPlayer


func _input(event: InputEvent) -> void:
	if event is InputEventScreenPinch:
		emit_signal("pinch_detected")


func start() -> void:
	_animation_player.get_animation("Hint").loop = true
	_animation_player.play("Hint")


func stop() -> void:
	_animation_player.get_animation("Hint").loop = false
