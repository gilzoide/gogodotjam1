extends Control

const Score = preload("res://gameplay/score.gd")

export(Resource) var gameplay_score = preload("res://gameplay/gameplay_score.tres")
export(Resource) var highscore = preload("res://gameplay/highscore.tres")
export(String) var highscore_save_path = "user://highscore.res"

onready var _current_label = $VBoxContainer/CurrentTimer/Label
onready var _greater_icon = $VBoxContainer/CurrentTimer/GreaterIcon
onready var _highscore_label = $VBoxContainer/MaxTimer/Label


func _ready() -> void:
	if ResourceLoader.exists(highscore_save_path):
		var loaded = load(highscore_save_path)
		if loaded is Score:
			highscore = loaded


func _notification(what: int) -> void:
	if what == NOTIFICATION_VISIBILITY_CHANGED and is_visible_in_tree():
		_appeared()


func _appeared() -> void:
	if gameplay_score.seconds > highscore.seconds:
		highscore.seconds = gameplay_score.seconds
		if OS.is_userfs_persistent():
			var _err = ResourceSaver.save(highscore_save_path, highscore)
		_greater_icon.visible = true
	else:
		_greater_icon.visible = false
	_current_label.text = gameplay_score.get_seconds_as_text()
	_highscore_label.text = highscore.get_seconds_as_text()
