extends Area2D

# Função chamada quando um corpo entra na área detectada
func _on_Morte_body_entered(body):
	# Verifica se o corpo que entrou é o "Player"
	if str(body).get_slice(":", 0) == "Player":
		# Altera o estado do "Player" para "MORTO"
		get_parent().get_node("Player").state = get_parent().get_node("Player").PlayerState.DEAD
