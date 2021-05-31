extends Node2D

signal animation_finished()

onready var _animation_player = $AnimationPlayer


func play() -> void:
	_animation_player.play("Flip")


func _on_animation_finished(anim_name: String) -> void:
	emit_signal("animation_finished")
