extends Control

export(Vector2) var player_start = Vector2(0.5, 0.75)

onready var _player = $Ball


func _ready() -> void:
	_player.position = rect_size * player_start
