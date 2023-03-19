extends TextureButton

func _on_Rune_button_down():
	get_parent().get_parent().on_drag_item(self)
