extends TextureRect

export(SpriteFrames) var frames: SpriteFrames
export(String) var animation: String = "default"
export(int) var frame = 0
export(bool) var play_on_ready = true

var _timer = Timer.new()


func _ready() -> void:
	add_child(_timer)
	var _err = _timer.connect("timeout", self, "_on_timer_timeout")
	if play_on_ready:
		play(animation)


func play(new_animation: String) -> void:
	animation = new_animation
	_timer.start(1.0 / frames.get_animation_speed(animation))
	_refresh_texture()


func stop() -> void:
	_timer.stop()


func _on_timer_timeout() -> void:
	frame += 1
	_refresh_texture()


func _refresh_texture() -> void:
	frame = posmod(frame, frames.get_frame_count(animation))
	texture = frames.get_frame(animation, frame)
