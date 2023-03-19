extends CanvasLayer

func change_scene(target):
	self.visible = true
	$AnimationPlayer.play("flash")
	yield($AnimationPlayer, "animation_finished")
	
	if get_tree().change_scene(target) != OK:
		print("ERRO AO MUDAR DE CENA ", target)
	
	$AnimationPlayer.play_backwards("flash")
	yield($AnimationPlayer, "animation_finished")
	self.visible = false
