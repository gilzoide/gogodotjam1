extends Resource

export(int) var seconds = 0 setget set_seconds


func reset() -> void:
	seconds = 0
	emit_signal("changed")


func set_seconds(value: int) -> void:
	if value != seconds:
		seconds = value
		emit_signal("changed")


func get_seconds_as_text() -> String:
	return "%d:%02d" % [seconds / 60, seconds % 60]
