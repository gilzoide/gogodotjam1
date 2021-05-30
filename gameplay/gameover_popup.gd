extends Control

export(Resource) var gameplay_score = preload("res://gameplay/gameplay_score.tres")

onready var _current_timer = $VBoxContainer/CurrentTimer/Label


func _notification(what: int) -> void:
	if what == NOTIFICATION_VISIBILITY_CHANGED and is_visible_in_tree():
		_current_timer.text = gameplay_score.get_seconds_as_text()
