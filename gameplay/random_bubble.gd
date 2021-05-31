extends Control

export(float) var min_delay = 2
export(float) var max_delay = 5

var _next_delay = 0
var _timer = 0
onready var _bubble = $Bubble


func _ready() -> void:
	_reset()


func _process(delta: float) -> void:
	_timer += delta
	if _timer >= _next_delay:
		_bubble.position = Vector2(rand_range(0, rect_size.x), rand_range(0, rect_size.y))
		_bubble.play()
		_reset()


func _reset() -> void:
	_next_delay = rand_range(min_delay, max_delay)
	_timer = 0
