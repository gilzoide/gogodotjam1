extends Node2D

export(float) var size = 100
export(float) var min_size = 50
export(float) var max_size = 1000

func _ready() -> void:
	position = get_viewport().size * 0.5


func _draw() -> void:
	draw_circle(Vector2.ZERO, size * 0.5, Color.white)


func _input(event: InputEvent) -> void:
	if event is InputEventScreenPinch:
		set_size(size + event.relative)
	elif event is InputEventMouseMotion:
		set_size(lerp(min_size, max_size, 1.0 - (event.position.y / get_viewport().size.y)))


func set_size(value: float) -> void:
	size = clamp(value, min_size, max_size)
	update()
	
