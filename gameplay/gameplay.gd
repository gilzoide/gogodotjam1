extends Control

export(Vector2) var player_start = Vector2(0.5, 0.75)
export(Resource) var score = preload("res://gameplay/gameplay_score.tres")

onready var _gameover_popup = $GameOverPopup
onready var _pinch_hint = $InputHintPosition/PinchHint
onready var _player = $BallPosition/Ball
onready var _second_timer = $SecondTimer
onready var _spawner = $Spawner


func _ready() -> void:
	GestureInputManager.pause_mode = Node.PAUSE_MODE_PROCESS
	reset_pre_game()


func _on_SecondTimer_timeout() -> void:
	score.seconds += 1


func reset_pre_game() -> void:
	get_tree().paused = true
	_pinch_hint.start()
	_pinch_hint.connect("pinch_detected", self, "_on_PinchHint_pinch_detected", [], CONNECT_ONESHOT)


func start_game() -> void:
	_player.position = Vector2.ZERO
	score.reset()
	_second_timer.start()
	_spawner.reset()
	get_tree().paused = false
	_gameover_popup.hide()


func end_game() -> void:
	reset_pre_game()
	_gameover_popup.show()


func _on_Ball_hit_mob(_mob) -> void:
	end_game()


func _on_PinchHint_pinch_detected() -> void:
	start_game()
	_pinch_hint.stop()
