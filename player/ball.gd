tool
extends KinematicBody2D

export(Texture) var texture
export(float) var size = 100
export(float) var min_size = 50
export(float) var max_size = 1000

onready var _sprite = $Sprite


func _input(event: InputEvent) -> void:
	if event is InputEventScreenPinch:
		set_size(size + event.relative)


func _physics_process(delta: float) -> void:
	pass


func set_size(value: float) -> void:
	size = clamp(value, min_size, max_size)
	var sprite_size = _sprite.texture.get_size()
	scale = Vector2(size, size) / sprite_size
