extends Area2D

# Função que é chamada quando um corpo entra na área 2D da porta.
func _on_Porta_body_entered(body):
	# Verifica se o corpo que entrou na área é um objeto do tipo "Player".
	if str(body).get_slice(":", 0) == "Player":
		# Verifica se os três itens necessários para abrir a porta estão visíveis na interface do usuário.
		if get_parent().get_node("InterfaceLayer/Interface/Items/ItemA1").visible == true and get_parent().get_node("InterfaceLayer/Interface/Items/ItemA2").visible == true and get_parent().get_node("InterfaceLayer/Interface/Items/ItemA3").visible == true:
			# Muda para a cena do altar.
			SceneTransition.change_scene("res://Scenes/Altar/Altar.tscn")

