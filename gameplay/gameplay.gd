extends Control

export(Vector2) var player_start = Vector2(0.5, 0.75)
export(Resource) var score = preload("res://gameplay/gameplay_score.tres")

onready var _player = $Ball
onready var _second_timer = $SecondTimer


func _ready() -> void:
	start_game()


func _on_SecondTimer_timeout() -> void:
	score.seconds += 1


func start_game() -> void:
	_player.position = rect_size * player_start
	_second_timer.start()
