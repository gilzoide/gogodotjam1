extends KinematicBody2D

export(float) var speed = 100
export(float) var angular_speed = -2
export(float) var size = 100
export(float) var min_size = 50
export(float) var max_size = 1000

var _movement = Vector2.LEFT
onready var _sprite = $Sprite


func _input(event: InputEvent) -> void:
	if event is InputEventScreenPinch:
		set_size(size + event.relative)


func _process(delta: float) -> void:
	_sprite.rotate(angular_speed * delta)


func _physics_process(delta: float) -> void:
	var collision = move_and_collide(_movement * speed * delta)
	if collision:
		_movement = collision.normal


func set_size(value: float) -> void:
	size = clamp(value, min_size, max_size)
	var sprite_size = _sprite.texture.get_size()
	scale = Vector2(size, size) / sprite_size
