extends KinematicBody2D

signal hit_mob(mob)

const LAYER_MOB_BIT = 2

export(float) var speed = 100
export(float) var angular_speed = 3
export(float) var size = 100
export(float) var min_size = 50
export(float) var max_size = 1000

var _angular_movement = -1
var _movement = Vector2.LEFT
onready var _audio_player = $AudioStreamPlayer2D
onready var _sprite = $Sprite


func _ready() -> void:
	set_size(size)


func _input(event: InputEvent) -> void:
	if event is InputEventScreenPinch:
		set_size(size + event.relative)


func _process(delta: float) -> void:
	_sprite.rotate(_angular_movement * delta)


func _physics_process(delta: float) -> void:
	var collision = move_and_collide(_movement * speed * delta)
	if collision:
		if not _audio_player.playing:
			_audio_player.pitch_scale = 1 - inverse_lerp(min_size, max_size, size) * 0.5
			_audio_player.play()
		_movement.x = -_movement.x
		_angular_movement = -_angular_movement


func set_size(value: float) -> void:
	size = clamp(value, min_size, max_size)
	var sprite_size = _sprite.texture.get_size()
	scale = Vector2(size, size) / sprite_size
	_angular_movement = sign(_angular_movement) * angular_speed / scale.x


func _on_Area2D_body_entered(body: PhysicsBody2D) -> void:
	if body.get_collision_layer_bit(LAYER_MOB_BIT):
		emit_signal("hit_mob", body)
