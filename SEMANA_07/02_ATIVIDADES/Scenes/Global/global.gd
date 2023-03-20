extends Node

var counter = 0  # variável de controle do contador

func _process(_delta):
	# Se a mana do jogador não estiver cheia, vamos verificar o contador
	if player_mana != 100:
		# Se o contador for igual a 500, adicionamos 10 pontos de mana e resetamos o contador
		if counter == 500:
			counter = 0
			player_mana += 10
		# Caso contrário, apenas incrementamos o contador em 1
		else:
			counter += 1

# Variáveis de estado do jogador e do inimigo
var player_health = 100
var player_mana = 100
var enemy_health = 100
