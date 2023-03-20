extends HBoxContainer

# Variáveis de controle da barra de mana
var current_mana = Global.player_mana # Quantidade atual de mana do jogador
var maximum = 100 # Quantidade máxima de mana do jogador

# Função chamada a cada quadro de animação
func _process(_delta):
	# Verifica se a quantidade atual de mana do jogador mudou desde a última atualização
	if Global.player_mana != current_mana:
		# Anima a mudança na quantidade de mana e atualiza o texto exibido na tela
		animate_value(current_mana, Global.player_mana)
		update_count_text(Global.player_mana)
	# Atualiza a quantidade atual de mana do jogador
	current_mana = Global.player_mana

# Anima a mudança na quantidade de mana do jogador e executa uma animação de tremor se a quantidade diminuir
func animate_value(start, end):
	# Anima a mudança na barra de progresso
	$Tween.interpolate_property($TextureProgress, "value", start, end, 0.5, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	# Anima a mudança no texto exibido na tela
	$Tween.interpolate_method(self, "update_count_text", start, end, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	# Inicia a animação
	$Tween.start()
	# Executa uma animação de tremor se a quantidade de mana diminuir
	if end < start:
		$AnimationPlayer.play("shake")

# Atualiza o texto exibido na tela com a quantidade atual de mana do jogador
func update_count_text(value):
	$Count/Number.text = str(round(value)) + '/' + str(maximum)
