extends Node2D

onready var _animation_player = $AnimationPlayer


func play() -> void:
	_animation_player.play("Flip")
