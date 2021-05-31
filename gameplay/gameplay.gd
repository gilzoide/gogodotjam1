extends Control

export(Resource) var score = preload("res://gameplay/gameplay_score.tres")
export(float) var gameover_restart_delay = 1
export(float) var pause_bgm_fade_duration = 0.3

var _is_running = false
var _pinch_hint

onready var _bgm = $BGM
onready var _gameover_popup = $GameOverPopup
onready var _pause_menu = $PauseMenu
onready var _pinch_hint_position = $InputHintPosition
onready var _player = $BallPosition/Ball
onready var _second_timer = $SecondTimer
onready var _spawner = $Spawner
onready var _tween = $Tween


func _ready() -> void:
	GestureInputManager.pause_mode = Node.PAUSE_MODE_PROCESS
	if OS.has_touchscreen_ui_hint():
		_pinch_hint = load("res://gameplay/pinch_hint.tscn").instance()
	else:
		_pinch_hint = load("res://gameplay/mouse_hint.tscn").instance()
	_pinch_hint_position.add_child(_pinch_hint)
	_pause_menu.set_as_toplevel(true)
	var _err = _pause_menu.connect("modal_closed", self, "_on_pause_menu_modal_closed")
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
		get_tree().paused = true
	_pause_menu.show_modal()
	_tween.interpolate_property(_bgm, "pitch_scale", 1.0, 0.1, pause_bgm_fade_duration, Tween.TRANS_LINEAR)
	_tween.start()
	yield(_tween, "tween_completed")
	_bgm.stream_paused = true


func _on_pause_menu_modal_closed() -> void:
	if _is_running:
		get_tree().paused = false
	_tween.interpolate_property(_bgm, "pitch_scale", 0.1, 1.0, pause_bgm_fade_duration, Tween.TRANS_LINEAR)
	_tween.start()
	_bgm.stream_paused = false
