extends Label

export(Resource) var score = preload("res://gameplay/gameplay_score.tres")


func _ready() -> void:
	var _err = score.connect("changed", self, "refresh_timer")
	refresh_timer()


func refresh_timer() -> void:
	text = score.get_seconds_as_text()
