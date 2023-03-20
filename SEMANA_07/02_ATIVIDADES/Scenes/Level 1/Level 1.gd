# Início do código
extends Node2D

# Variável global "deadbolt" é inicializada como "true"
var deadbolt = true

# Função executada quando o nó é adicionado à cena
func _ready():
	# As variáveis globais para a saúde e mana do jogador e inimigo são inicializadas
	Global.player_health = 100
	Global.player_mana = 100
	Global.enemy_health = 100
	# As variáveis de controle para as teclas pressionadas são inicializadas como "false"
	GUI.leftPress = false
	GUI.rightPress = false
	GUI.upPress = false
	GUI.midPress = false

# Função executada a cada quadro
func _process(_delta):
	# Se o estado do jogador for "morto"
	if $Player.state == $Player.PlayerState.DEAD:
		# A GUI é desativada e a tela de "Game Over" é ativada
		$GUI.visible = false
		$InterfaceLayer.visible = false
		$GameOver.visible = true
		# Se a tecla de "interagir" for pressionada
		if Input.is_action_pressed("interact"):
			# Espera antes de mudar de cena
			yield(get_tree().create_timer(.3), "timeout")
			# A cena é trocada para a tela de título
			if get_tree().change_scene("res://Scenes/Title Screen/Title Screen.tscn") != OK:
				# Mensagem de erro é exibida caso a cena não possa ser trocada
				print("ERRO AO TROCAR DE CENA")

	# Se as três runas já foram coletadas e a porta ainda não foi aberta
	if get_node("InterfaceLayer/Interface/Items/ItemA1").visible == true and get_node("InterfaceLayer/Interface/Items/ItemA2").visible == true and get_node("InterfaceLayer/Interface/Items/ItemA3").visible == true and deadbolt:
		# Variável "deadbolt" é mudada para "false" e a mensagem de prompt é exibida
		deadbolt = false
		$Prompt.visible = true
		$Prompt/CanvasLayer.visible =true
		$Prompt/CanvasLayer/Label.text = "Você coletou as três runas. Elas pulsam em sua mão e parecem estar pedindo para serem usadas. Agora, ache a porta de madeira e volte para o seu altar."

# Função executada quando o botão do prompt é pressionado
func _on_PromptButton_pressed():
	# O prompt é desativado
	$Prompt.visible = false
	$Prompt/CanvasLayer.visible = false
