extends CanvasLayer

# Variável para controle local da possibilidade de pressionar o botão do meio
var midPressableLocal = false

# Variável para verificar se um botão está sendo pressionado
var pressing = false

# Função chamada quando o botão esquerdo do joystick é pressionado
func _on_LeftButton_button_down():
	GUI.leftPress = true

# Função chamada quando o botão esquerdo do joystick é solto
func _on_LeftButton_button_up():
	GUI.leftPress = false

# Função chamada quando o botão direito do joystick é pressionado
func _on_RightPress_button_down():
	GUI.rightPress = true

# Função chamada quando o botão direito do joystick é solto
func _on_RightPress_button_up():
	GUI.rightPress = false

# Função chamada quando o botão de cima do joystick é pressionado
func _on_UpButton_button_down():
	GUI.upPress = true

# Função chamada quando o botão de cima do joystick é solto
func _on_UpButton_button_up():
	GUI.upPress = false

# Função principal do script, executada a cada quadro
func _process(_delta):
	# Define a visibilidade dos botões do joystick de acordo com os estados dos botões
	$Joystick/LeftPress.visible = GUI.leftPress
	$Joystick/RightPress.visible = GUI.rightPress
	$JoystickUp/UpPress.visible = GUI.upPress
	
	# Verifica se é possível pressionar o botão do meio e se a variável local permite isso
	if GUI.midPressable and midPressableLocal:
		# Define o valor do botão do meio como 100 e torna-o visível
		$MidButton.value = 100
		$MidButton/MidButton.visible = true
		# Altera a variável local para impedir que o botão do meio seja pressionado novamente
		midPressableLocal = false
	
	# Verifica se não é possível pressionar o botão do meio e se a variável local permite isso
	if GUI.midPressable == false and midPressableLocal == false:
		# Altera a variável local para permitir que o botão do meio seja pressionado novamente
		midPressableLocal = true
		# Define o valor do botão do meio como 0 e torna-o invisível
		$MidButton.value = 0
		$MidButton/MidButton.visible = false

func _on_MidButton_button_down():
	# Se não estiver pressionando o botão do meio
	if pressing == false:
		# Define que está pressionando o botão do meio
		pressing = true
		# Define que o botão do meio está pressionado
		GUI.midPress = true
		# Esconde o botão do meio
		$MidButton/MidButton.visible = false
		# Inicia a interpolação da propriedade 'value' do botão do meio
		# O valor da propriedade vai de 0 a 100 em 1 segundo com a interpolação linear e a aceleração gradual
		$Tween.interpolate_property($MidButton, "value", 0, 100, 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		$Tween.start()
		# Aguarda meio segundo antes de continuar a execução do código
		yield(get_tree().create_timer(.5), "timeout")
		# Define que o botão do meio não está mais pressionado
		GUI.midPress = false
		# Aguarda mais meio segundo antes de continuar a execução do código
		yield(get_tree().create_timer(.5), "timeout")
		# Exibe novamente o botão do meio
		$MidButton/MidButton.visible = true
		# Define que o botão do meio pode ser pressionado novamente
		midPressableLocal = false
		# Define que não está mais pressionando o botão do meio
		pressing = false
		# Define que o botão do meio não está mais pressionado
		GUI.midPress = false
