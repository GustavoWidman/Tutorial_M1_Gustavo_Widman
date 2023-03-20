extends TextureButton

# Função que será chamada quando o botão for clicado
func _on_Rune_button_down():
	# Chama a função on_drag_item() do elemento pai do pai deste botão, levando como argumento qual objeto chamou essa função.
	get_parent().get_parent().on_drag_item(self)
