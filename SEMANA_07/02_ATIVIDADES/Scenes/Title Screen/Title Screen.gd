extends Control

# Função que será chamada quando o botão de "Start" for clicado
func _on_StartButton_pressed():
	# Chama a função "change_scene" do objeto "SceneTransition" passando como parâmetro a cena a ser carregada
	SceneTransition.change_scene("res://Scenes/Prelude/Prelude.tscn")

# Função que será chamada quando o botão de "Start" for clicado
func _on_QuitButton_pressed():
	# Fecha o jogo
	get_tree().quit()
