extends HBoxContainer

# Variáveis globais para a vida atual do jogador e a quantidade máxima de vida.
var current_health = Global.player_health
var maximum = 100

# Esta função é chamada a cada quadro do jogo e atualiza a barra de progresso e o texto da contagem.
func _process(_delta):
	# Verifica se houve alterações na vida do jogador.
	if Global.player_health != current_health:
		# Se houver alterações, executa a função de animação.
		animate_value(current_health, Global.player_health)
		# Em seguida, atualiza o texto da contagem de vida.
		update_count_text(Global.player_health)
		# Define a vida atual como a nova vida do jogador.
		current_health = Global.player_health

# Esta função anima a barra de progresso e o texto da contagem de vida.
func animate_value(start, end):
	# Interpola a propriedade "value" da barra de progresso, de modo que ela passe de "start" para "end" em 0,5 segundos,
	# utilizando uma animação elástica e uma curva de aceleração suave.
	$Tween.interpolate_property($TextureProgress, "value", start, end, 0.5, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	# Interpola o método "update_count_text", de modo que ele atualize o texto da contagem de vida, passando de "start" para "end" em 0,5 segundos,
	# utilizando uma animação linear e uma curva de aceleração suave.
	$Tween.interpolate_method(self, "update_count_text", start, end, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	# Inicia a animação.
	$Tween.start()
	# Se o valor final for menor que o valor inicial, toca a animação "shake" no AnimationPlayer.
	if end < start:
		$AnimationPlayer.play("shake")

# Esta função atualiza o texto da contagem de vida.
func update_count_text(value):
	# Define o texto da contagem de vida como a string que contém o valor arredondado da vida atual, seguida de uma barra e do valor máximo de vida.
	$Count/Number.text = str(round(value)) + '/' + str(maximum)
