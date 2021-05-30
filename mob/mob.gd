extends RigidBody2D

signal screen_exited()


func _on_screen_exited() -> void:
	emit_signal("screen_exited")
