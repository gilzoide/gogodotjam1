extends Control

const PALETTES = PoolColorArray([
	Color.white, Color.black,
	Color("#F1CD36"), Color("#354A5F"),
	Color("#97BC62"), Color("#2C5F2D"),
	Color("#F0EDCC"), Color("#02343F"),
	Color("#C7D3D4"), Color("#603F83"),
	Color("#ADEFD1"), Color("#00203F"),
	Color("#CE4A7E"), Color("#1C1C1B"),
])

export(Resource) var settings = preload("res://settings/default_settings.tres")

var _current_palette = 0

onready var _viewport = $Viewport

func _ready() -> void:
	var _err = settings.connect("changed", self, "_on_settings_changed")
	grab_focus()


func _input(event: InputEvent) -> void:
	GestureInputManager._unhandled_input(event)
	_viewport.input(event)


func _on_settings_changed() -> void:
	_current_palette = settings.palette_index % PALETTES.size()
	_update_shader()


func _update_shader() -> void:
	var is_inverted = _current_palette % 2
	var foreground
	var background
	if is_inverted:
		foreground = PALETTES[_current_palette]
		background = PALETTES[_current_palette - 1]
	else:
		foreground = PALETTES[_current_palette]
		background = PALETTES[_current_palette + 1]
	material.set_shader_param("foreground", foreground)
	material.set_shader_param("background", background)
