extends Control

onready var _mute_button = $VBoxContainer/MuteButton


func _on_meta_clicked(meta) -> void:
	var _err = OS.shell_open(meta)


func _on_MuteButton_toggled(button_pressed: bool) -> void:
	var master_idx = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(master_idx, button_pressed)
	_mute_button.text = "🔇" if button_pressed else "🔊"
