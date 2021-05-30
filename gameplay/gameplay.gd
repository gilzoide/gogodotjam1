extends Control

export(Resource) var score = preload("res://gameplay/gameplay_score.tres")
export(float) var gameover_restart_delay = 1

var _is_running = false

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


func reset_pre_game(delay = 0) -> void:
	get_tree().paused = true
	if delay > 0:
		yield(get_tree().create_timer(delay), "timeout")
	_pinch_hint.connect("pinch_detected", self, "_on_PinchHint_pinch_detected", [], CONNECT_ONESHOT)
	_pinch_hint.start()


func start_game() -> void:
	_player.position = Vector2.ZERO
	score.reset()
	_second_timer.start()
	_spawner.reset()
	_gameover_popup.hide()
	_is_running = true
	get_tree().paused = false


func end_game() -> void:
	_is_running = false
	reset_pre_game(gameover_restart_delay)
	_gameover_popup.show()


func _on_Ball_hit_mob(_mob) -> void:
	end_game()


func _on_PinchHint_pinch_detected() -> void:
	start_game()
	_pinch_hint.stop()


func _on_PauseButton_pressed() -> void:
	if _is_running:
		get_tree().paused = not get_tree().paused
