extends CanvasLayer

# Método para mudar de cena com animação de flash
func change_scene(target):
	# Torna este objeto visível e executa a animação de flash
	self.visible = true
	$AnimationPlayer.play("flash")
	# Espera até que a animação termine antes de continuar
	yield($AnimationPlayer, "animation_finished")
	
	# Tenta mudar de cena para a cena alvo
	if get_tree().change_scene(target) != OK:
		# Se houver um erro, imprime uma mensagem de erro
		print("ERRO AO MUDAR DE CENA ", target)
	
	# Executa a animação de flash novamente em sentido reverso
	$AnimationPlayer.play_backwards("flash")
	# Espera até que a animação termine antes de continuar
	yield($AnimationPlayer, "animation_finished")
	# Torna este objeto invisível novamente
	self.visible = false
