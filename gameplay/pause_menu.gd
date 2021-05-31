extends Control

export(Resource) var settings = preload("res://settings/default_settings.tres")

onready var _mute_button = $VBoxContainer/MuteButton


func _notification(what: int) -> void:
	if what == NOTIFICATION_VISIBILITY_CHANGED and is_visible_in_tree():
		_mute_button.pressed = settings.audio_mute
		_refresh_text()


func _on_meta_clicked(meta) -> void:
	var _err = OS.shell_open(meta)


func _on_MuteButton_toggled(button_pressed: bool) -> void:
	settings.audio_mute = button_pressed
	_refresh_text()


func _refresh_text() -> void:
	_mute_button.text = "🔇" if settings.audio_mute else "🔊"
