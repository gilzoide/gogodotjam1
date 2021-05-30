extends Control

export(Vector2) var player_start = Vector2(0.5, 0.75)
export(Resource) var score = preload("res://gameplay/gameplay_score.tres")

onready var _pinch_hint = $PinchHintPosition/PinchHint
onready var _player = $Ball
onready var _second_timer = $SecondTimer
onready var _spawner = $Spawner


func _ready() -> void:
	GestureInputManager.pause_mode = Node.PAUSE_MODE_PROCESS
	get_tree().paused = true
	_pinch_hint.start()


func _on_SecondTimer_timeout() -> void:
	score.seconds += 1


func start_game() -> void:
	_player.position = rect_size * player_start
	_second_timer.start()
	_spawner.reset()
	get_tree().paused = false


func end_game() -> void:
	get_tree().paused = true


func _on_Ball_hit_mob(_mob) -> void:
	end_game()


func _on_PinchHint_pinch_detected() -> void:
	start_game()
	_pinch_hint.stop()
