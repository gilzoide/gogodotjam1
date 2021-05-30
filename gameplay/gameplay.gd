extends Control

onready var _player = $Ball


func _ready() -> void:
	_player.position = rect_size * 0.5
