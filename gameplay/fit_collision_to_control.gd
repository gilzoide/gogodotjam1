tool
extends ColorRect

onready var _collision_polygon = $StaticBody2D/CollisionShape2D


func _ready() -> void:
	_refresh_shape()


func _notification(what: int) -> void:
	if what == NOTIFICATION_RESIZED:
		_refresh_shape()


func _refresh_shape() -> void:
	_collision_polygon.polygon = PoolVector2Array([
		Vector2(0, 0),
		Vector2(rect_size.x, 0),
		rect_size,
		Vector2(0, rect_size.y),
	])
