extends Popup

export(Resource) var gameplay_score = preload("res://gameplay/gameplay_score.tres")

onready var _current_timer = $VBoxContainer/HBoxContainer/CurrentTimer


func _notification(what: int) -> void:
	if what == NOTIFICATION_POST_POPUP:
		_current_timer.text = gameplay_score.get_seconds_as_text()
