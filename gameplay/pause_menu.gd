extends PanelContainer


func _on_meta_clicked(meta) -> void:
	var _err = OS.shell_open(meta)
