extends Control

const PALETTES = PoolColorArray([
	Color("#FFFFFF"), Color("#000000"),  # White on Black
	Color("#F1CD36"), Color("#354A5F"),  # Yellow on Blue (FoG)
	Color("#97BC62"), Color("#2C5F2D"),  # Green on darker Green (Gameboy)
	Color("#F0EDCC"), Color("#02343F"),  # 
	Color("#C7D3D4"), Color("#603F83"),  # White-ish on Purple
	Color("#ADEFD1"), Color("#00203F"),  # 
	Color("#CE4A7E"), Color("#1C1C1B"),  # Pink on Brown
])

export(Resource) var settings = preload("res://settings/default_settings.tres")
export(float) var tween_duration = 0.25

var _current_palette = 0
var _foreground = Color.white
var _background = Color.black

onready var _tween = $Tween
onready var _viewport = $Viewport


func _ready() -> void:
	var _err = settings.connect("changed", self, "_on_settings_changed")
	grab_focus()


func _input(event: InputEvent) -> void:
	GestureInputManager._unhandled_input(event)
	_viewport.input(event)


func _on_settings_changed() -> void:
	_current_palette = settings.palette_index % PALETTES.size()
	_update_shader(Engine.get_idle_frames() > 0)


func _update_shader(animated = true) -> void:
	var is_inverted = _current_palette % 2
	var new_foreground = PALETTES[_current_palette]
	var new_background = PALETTES[_current_palette + (-1 if is_inverted else 1)]
	_tween.stop_all()
	_tween.interpolate_method(
		self, "_set_foreground",
		_foreground, new_foreground,
		tween_duration * float(animated), Tween.TRANS_QUAD, Tween.EASE_IN
	)
	_tween.interpolate_method(
		self, "_set_background",
		_background, new_background,
		tween_duration * float(animated), Tween.TRANS_QUAD, Tween.EASE_IN
	)
	_tween.start()
	_foreground = new_foreground
	_background = new_background


func _set_foreground(color: Color) -> void:
	material.set_shader_param("foreground", color)


func _set_background(color: Color) -> void:
	material.set_shader_param("background", color)
