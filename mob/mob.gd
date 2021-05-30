extends RigidBody2D

signal screen_exited()

onready var _sprite = $Sprite


func _ready() -> void:
	var size = _sprite.texture.get_size()
	$VisibilityNotifier2D.rect = Rect2(-(size * 0.5), size)


func _on_screen_exited() -> void:
	emit_signal("screen_exited")
