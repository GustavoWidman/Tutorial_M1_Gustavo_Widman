extends KinematicBody2D

const GRAVITY = 1500
const JUMP_FORCE = -900
const MOVE_SPEED = 400

# Define um enum para os estados do jogador
enum PlayerState {
	IDLE,
	WALK,
	JUMP,
	DEAD,
	ATTACK
}

# Inicializa as variáveis de velocidade e estado do jogador
var velocity = Vector2.ZERO
var state = PlayerState.IDLE

# Método chamado a cada quadro para atualizar a física do jogador
func _physics_process(delta):
	if state != PlayerState.DEAD:
		# Define um vetor de entrada para receber as ações do jogador
		var input_vector = Vector2.ZERO

		# Verifica se o jogador está pressionando a tecla esquerda ou direita
		if GUI.leftPress or Input.is_action_pressed("ui_left"):
			input_vector.x = -1
		elif GUI.rightPress or Input.is_action_pressed("ui_right"):
			input_vector.x = +1
		
		# Atualiza a velocidade horizontal do jogador com base no vetor de entrada
		velocity.x = input_vector.x * MOVE_SPEED

		# Verifica se o jogador está no chão
		if is_on_floor():
			# Verifica se o jogador está pressionando a tecla de pulo
			if Input.is_action_pressed("ui_up") or GUI.upPress:
				# Aplica uma força vertical para o pulo e muda o estado do jogador para JUMP
				velocity.y = JUMP_FORCE
				if state != PlayerState.ATTACK:
					state = PlayerState.JUMP
			else:
				# Define a velocidade vertical como zero e muda o estado do jogador para IDLE ou WALK
				velocity.y = 0
				if velocity.x == 0:
					if state != PlayerState.ATTACK:
						state = PlayerState.IDLE
				else:
					if state != PlayerState.ATTACK:
						state = PlayerState.WALK
		else:
			# Se o jogador não está no chão, aplica a gravidade
			if velocity.y != 0:
				if state != PlayerState.ATTACK:
					state = PlayerState.JUMP
			velocity.y += GRAVITY * delta

		# Move o jogador e colide com os objetos do cenário
		velocity = move_and_slide(velocity, Vector2.UP)

		# Vira o sprite do jogador para a esquerda ou direita
		if input_vector.x < 0:
			$Sprite.flip_h = true
		elif input_vector.x > 0:
			$Sprite.flip_h = false

		# Seleciona a animação a ser reproduzida com base no estado atual do jogador
		match state:
			PlayerState.IDLE:
				$Sprite.play("idle")
			PlayerState.WALK:
				$Sprite.play("walk")
			PlayerState.JUMP:
				$Sprite.play("jump")
			PlayerState.DEAD:
				$Sprite.play("dead")
			PlayerState.ATTACK:
				$Sprite.play("attack")

# Método chamado quando o jogador recebe dano
func take_damage(damage):
	# Toca a animação de dano, diminui a saúde do jogador e muda o estado para DEAD se a saúde chegar a zero
	$AnimationPlayer.play("damaged")
	Global.player_health -= damage
	if Global.player_health <= 0:
		state = PlayerState.DEAD

# Método chamado para gastar mana e ativar o estado de ataque
func drain_mana(mana):
	 # Se o jogador não tem mana suficiente para realizar a ação
	if Global.player_mana <= 0:
		# O jogador recebe dano
		take_damage(10)
		# Define o texto da label para "Sem MP!"
		$CanvasLayer/Label.text = "Sem MP!"
		# Espera por 0,5 segundos
		yield(get_tree().create_timer(.5), "timeout")
		# Define o texto da label para uma string vazia
		$CanvasLayer/Label.text = ""
	 # Se o jogador tem exatamente 10 de mana
	elif Global.player_mana == 10:
		var oldState = state
		# Muda o estado do jogador para "ataque"
		state = PlayerState.ATTACK
		# Define o texto da label para "Sem MP!"
		$CanvasLayer/Label.text = "Sem MP!"
		# Reduz o mana do jogador pelo valor do argumento passado para a função
		Global.player_mana -= mana
		# Espera por 0,5 segundos
		yield(get_tree().create_timer(.5), "timeout")
		# Define o texto da label para uma string vazia
		$CanvasLayer/Label.text = ""
		# Espera por mais 0,5 segundos
		yield(get_tree().create_timer(.5), "timeout")
		# Retorna o estado do jogador ao estado anterior
		state = oldState
	# Se o jogador tem mana suficiente para realizar a ação
	else:
		var oldState = state
		# Muda o estado do jogador para "ataque"
		state = PlayerState.ATTACK
		# Reduz o mana do jogador pelo valor do argumento passado para a função
		Global.player_mana -= mana
		# Espera por 0,5 segundos
		yield(get_tree().create_timer(.5), "timeout")
		# Retorna o estado do jogador ao estado anterior
		state = oldState
