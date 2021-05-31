extends Resource

const SETTINGS_PATH = "user://settings.ini"
const SECTION_AUDIO = "audio"
const SECTION_INTERFACE = "interface"
const KEY_MUTE = "mute"
const KEY_PALETTE = "color_theme"

export(bool) var audio_mute = false setget set_audio_mute
export(int) var palette_index = 0 setget set_palette_index


func _init() -> void:
	call_deferred("_load")


func set_audio_mute(value: bool, should_save = true) -> void:
	if value != audio_mute:
		audio_mute = value
		var master_idx = AudioServer.get_bus_index("Master")
		AudioServer.set_bus_mute(master_idx, audio_mute)
		emit_signal("changed")
		if should_save:
			call_deferred("_save")


func set_palette_index(value: int, should_save = true) -> void:
	if value != palette_index:
		palette_index = value
		emit_signal("changed")
		if should_save:
			call_deferred("_save")


func _load() -> void:
	var config = ConfigFile.new()
	if config.load(SETTINGS_PATH) == OK:
		var value = convert(config.get_value(SECTION_AUDIO, KEY_MUTE, false), TYPE_BOOL)
		set_audio_mute(value, false)
		
		value = convert(config.get_value(SECTION_INTERFACE, KEY_PALETTE, 0), TYPE_INT)
		set_palette_index(value, false)


func _save() -> void:
	var config = ConfigFile.new()
	config.set_value(SECTION_AUDIO, KEY_MUTE, audio_mute)
	config.set_value(SECTION_INTERFACE, KEY_PALETTE, palette_index)
	if config.save(SETTINGS_PATH) != OK:
		print_debug("Error saving settings file")
