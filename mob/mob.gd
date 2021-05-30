extends RigidBody2D

signal screen_exited()

onready var _sprite = $Sprite


func _ready() -> void:
	$VisibilityNotifier2D.rect = _sprite.get_rect()


func _on_screen_exited() -> void:
	emit_signal("screen_exited")
