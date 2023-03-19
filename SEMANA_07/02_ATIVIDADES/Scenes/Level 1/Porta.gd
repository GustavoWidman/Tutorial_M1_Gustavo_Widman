extends Area2D



func _on_Porta_body_entered(body):
	if str(body).get_slice(":", 0) == "Player":
		if get_parent().get_node("InterfaceLayer/Interface/Items/ItemA1").visible == true and get_parent().get_node("InterfaceLayer/Interface/Items/ItemA2").visible == true and get_parent().get_node("InterfaceLayer/Interface/Items/ItemA3").visible == true:
			if get_tree().change_scene("res://Scenes/Altar/Altar.tscn") != OK:
				print("ERRO AO TROCAR DE CENA")
