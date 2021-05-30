extends Label

export(Resource) var score = preload("res://gameplay/gameplay_score.tres")


func _ready() -> void:
	var _err = score.connect("changed", self, "refresh_score")
	refresh_score()


func refresh_score() -> void:
	text = str(score.points)
