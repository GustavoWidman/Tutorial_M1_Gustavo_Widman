extends Area2D

func _on_Morte_body_entered(body):
	if str(body).get_slice(":", 0) == "Player":
		get_parent().get_node("Player").state = get_parent().get_node("Player").PlayerState.DEAD	  
