extends Resource

const SETTINGS_PATH = "user://settings.ini"
const SECTION_AUDIO = "audio"
const KEY_MUTE = "mute"

export(bool) var audio_mute = false setget set_audio_mute


func _init() -> void:
	call_deferred("_load")


func set_audio_mute(value: bool) -> void:
	if value != audio_mute:
		audio_mute = value
		var master_idx = AudioServer.get_bus_index("Master")
		AudioServer.set_bus_mute(master_idx, audio_mute)
		call_deferred("_save")
		emit_signal("changed")


func _load() -> void:
	var config = ConfigFile.new()
	if config.load(SETTINGS_PATH) == OK:
		var value = convert(config.get_value(SECTION_AUDIO, KEY_MUTE, false), TYPE_BOOL)
		set_audio_mute(value)


func _save() -> void:
	var config = ConfigFile.new()
	config.set_value(SECTION_AUDIO, KEY_MUTE, audio_mute)
	if config.save(SETTINGS_PATH) != OK:
		print_debug("Error saving settings file")
