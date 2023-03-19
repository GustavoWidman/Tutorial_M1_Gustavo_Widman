extends Control

func _on_StartButton_pressed():
	SceneTransition.change_scene("res://Scenes/Prelude/Prelude.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()
