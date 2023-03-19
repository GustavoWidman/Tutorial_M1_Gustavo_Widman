extends Node2D

var deadbolt = true


func _ready():
	Global.player_health = 100
	Global.player_mana = 100
	Global.enemy_health = 100
	GUI.leftPress = false
	GUI.rightPress = false
	GUI.upPress = false
	GUI.midPress = false


func _process(_delta):
	if $Player.state == $Player.PlayerState.DEAD:
		$GUI.visible = false
		$InterfaceLayer.visible = false
		$GameOver.visible = true
		if Input.is_action_pressed("interact"):
			if get_tree().change_scene("res://Scenes/Title Screen/Title Screen.tscn") != OK:
				print("ERRO AO TROCAR DE CENA")
	if get_node("InterfaceLayer/Interface/Items/ItemA1").visible == true and get_node("InterfaceLayer/Interface/Items/ItemA2").visible == true and get_node("InterfaceLayer/Interface/Items/ItemA3").visible == true and deadbolt:
		deadbolt = false
		$Prompt.visible = true
		$Prompt/CanvasLayer.visible =true
		$Prompt/CanvasLayer/Label.text = "Você coletou as três runas. Elas pulsam em sua mão e parecem estar pedindo para serem usadas. Agora, ache a porta de madeira e volte para o seu altar."
		
func _on_PromptButton_pressed():
	$Prompt.visible = false
	$Prompt/CanvasLayer.visible = false
