extends Control

export(PackedScene) var mob_prefab: PackedScene

onready var _timer = $Timer


func _on_Timer_timeout() -> void:
	spawn_mob()


func spawn_mob() -> void:
	var mob: Node2D = mob_prefab.instance()
	mob.position = Vector2(rand_range(0, rect_size.x), rand_range(0, rect_size.y))
	add_child(mob)
