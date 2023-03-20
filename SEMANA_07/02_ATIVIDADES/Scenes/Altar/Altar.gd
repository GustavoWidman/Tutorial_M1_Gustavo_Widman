extends Node2D

# Variáveis que controlam se as runas foram colocadas em seus lugares
var Rune1Placed = false
var Rune2Placed = false
var Rune3Placed = false

# Variáveis que controlam o item sendo arrastado e o item atual
onready var current_dragging_item = null
onready var current_item = null

func _ready():
	# Inicia a animação de RESET
	$AnimationPlayer.play("RESET")

# Função que é chamada quando um item é arrastado
func on_drag_item(item: Node) -> void:
	if Input.is_action_just_pressed("interact"):
		# Obtém a posição do item sendo arrastado
		var item_position = item.get_global_position()
		
		# Remove o item do HBoxContainer
		item.visible = false
		
		# Cria um novo nó para representar o item sendo arrastado
		var dragged_item = TextureRect.new()
		add_child(dragged_item)
		dragged_item.texture = item.texture_normal
		
		# Define a posição do novo nó para a posição do item sendo arrastado
		dragged_item.set_global_position(item_position)
		
		# Atualiza as variáveis de controle do item sendo arrastado e do item atual
		current_dragging_item = dragged_item
		current_item = item
	
func _process(_delta):
	if Input.is_action_pressed("interact"):
		# DRAG
		if current_item != null:
			# Obtém a posição do mouse
			var mouse_pos = get_viewport().get_mouse_position()
			
			# Define a posição do nó do item sendo arrastado para a posição do mouse
			current_dragging_item.set_position(Vector2(mouse_pos.x-50, mouse_pos.y-50))
	else:
		if current_item != null:
			# Verifica se o item foi solto no local correto
			if not dropped_item(current_item, current_dragging_item):
				# Caso contrário, torna o item visível novamente e remove o nó do item sendo arrastado
				current_item.visible = true
				remove_child(current_dragging_item)
				
			# Atualiza as variáveis de controle do item sendo arrastado e do item atual
			current_item = null
			
	# Verifica se todas as runas foram colocadas em seus lugares
	if Rune1Placed and Rune2Placed and Rune3Placed:
		# Reseta as variáveis de controle e executa a animação de finalização do ritual
		Rune1Placed = false
		Rune2Placed = false
		Rune3Placed = false
		ritual_finished()

# Função que executa a animação de finalização do ritual
func ritual_finished():
	# Executa a animação de finalização e torna o CanvasLayer visível
	$AnimationPlayer.play("ritual_finished")
	$CanvasLayer.visible = true
	
	# Aguarda o término da animação e um intervalo de 1 segundo antes de mudar para a cena de pós-lúdio
	yield($AnimationPlayer, "animation_finished")
	yield(get_tree().create_timer(1), "timeout")
	SceneTransition.change_scene("res://Scenes/Postlude/Postlude.tscn")

# Função que verifica se o item foi solto no local correto
func dropped_item(item, drag_item):
	if str(item).get_slice(":", 0) == "Rune1":
		# Verificamos se a posição do item arrastado está dentro de uma distância de 250 pixels do $Rune1Nestle
		var drag_item_pos = drag_item.get_global_position()
		if drag_item_pos.distance_to($Rune1Nestle.global_position) < 250:
			# Reposicionamos o item arrastado no local correto
			drag_item.set_global_position(Vector2($Rune1Nestle.global_position.x-45, $Rune1Nestle.global_position.y-46))
			# Marcamos que a Rune1 foi colocada no local correto
			Rune1Placed = true
			return true
	if str(item).get_slice(":", 0) == "Rune2":
		# Verificamos se a posição do item arrastado está dentro de uma distância de 200 pixels do $Rune2Nestle
		var drag_item_pos = drag_item.get_global_position()
		if drag_item_pos.distance_to($Rune2Nestle.global_position) < 200:
			# Reposicionamos o item arrastado no local correto
			drag_item.set_global_position(Vector2($Rune2Nestle.global_position.x-50, $Rune1Nestle.global_position.y))
			# Marcamos que a Rune2 foi colocada no local correto
			Rune2Placed = true
			return true
	if str(item).get_slice(":", 0) == "Rune3":
		# Verificamos se a posição do item arrastado está dentro de uma distância de 200 pixels do $Rune3Nestle
		var drag_item_pos = drag_item.get_global_position()
		if drag_item_pos.distance_to($Rune3Nestle.global_position) < 200:
			# Reposicionamos o item arrastado no local correto
			drag_item.set_global_position(Vector2($Rune3Nestle.global_position.x-50, $Rune1Nestle.global_position.y+12))
			# Marcamos que a Rune3 foi colocada no local correto
			Rune3Placed = true
			return true
	else:
		return false

# Função que é chamada quando o botão de Prompt é pressionado
func _on_PromptButton_pressed():
	# Escondemos a janela de Prompt
	$Prompt.visible = false
	$Prompt/CanvasLayer.visible = false
