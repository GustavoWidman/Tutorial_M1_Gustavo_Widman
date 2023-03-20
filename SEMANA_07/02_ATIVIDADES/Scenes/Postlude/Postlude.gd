extends Control

# Função que será chamada quando o botão for clicado
func _on_TextureRect_pressed():
	# Chama a função "change_scene" do objeto "SceneTransition" passando como parâmetro a cena a ser carregada
	SceneTransition.change_scene("res://Scenes/Title Screen/Title Screen.tscn")
