extends KinematicBody2D

# Constantes para definir a velocidade de movimento, alcance de ataque e dano causado pelo inimigo
const MOVE_SPEED = 150
const ATTACK_RANGE = 300
const DAMAGE = 10
const GRAVITY = 300

# Variáveis para controlar a velocidade e direção do inimigo
var velocity = Vector2.ZERO
var direction = Vector2.LEFT

# Variáveis para controlar a capacidade do inimigo de atacar e receber dano
var canAttack = true
var canHurt = true

# Variável para armazenar a saúde atual do inimigo
var current_health = Global.enemy_health

# Variável para armazenar o nó do jogador
var player = null

# Variável para armazenar a direção atual do inimigo
var facing = "left"

func _ready():
	# Obtém o nó do jogador a partir do pai do inimigo
	player = get_parent().get_node("Player")

func _physics_process(_delta):
	# Inverte a direção do inimigo se colidir com uma parede
	if is_on_wall():
		direction = -direction
		$Sprite.flip_h = not $Sprite.flip_h
		if facing == "left":
			facing = "right"
		else:
			facing = "left"
	
	# Inverte a direção do inimigo se o jogador estiver acima dele e fora de alcance de ataque
	if player.global_position.x - self.global_position.x > 0 and facing == "left" and player.global_position.y > 600:
		direction = -direction
		$Sprite.flip_h = not $Sprite.flip_h
		facing = "right"
	elif player.global_position.x - self.global_position.x < 0 and facing == "right" and player.global_position.y > 600:
		direction = -direction
		$Sprite.flip_h = not $Sprite.flip_h
		facing = "left"
	
	# Ataca o jogador se estiver dentro do alcance de ataque e se a tecla de ataque estiver pressionada
	if is_in_attack_range(player.global_position):
		GUI.midPressable = true
		if GUI.midPress:
			if canAttack:
				$AtkCooldown.start()
				canAttack = false
				take_damage(10)
	else:
		GUI.midPressable = false
	
	# Aplica a gravidade e move o inimigo
	direction.y = GRAVITY
	velocity = move_and_slide(Vector2(direction.x * MOVE_SPEED, direction.y), Vector2.UP)

func _process(_delta):
	# Atualiza a saúde do inimigo na barra de progresso
	if Global.enemy_health != current_health:
		animate_value(current_health, Global.enemy_health)
	current_health = Global.enemy_health

# Anima a barra de progresso de saúde do inimigo
func animate_value(start, end):
	$Tween.interpolate_property($TextureProgress, "value", start, end, 0.5, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$Tween.start()

# Verifica se o jogador está dentro do alcance de detecção do inimigo
func is_in_range(playerpos):
	return abs(playerpos.x - self.global_position.x) < 500

func is_in_attack_range(playerpos):
	# Verifica se o jogador está dentro do alcance de ataque do inimigo
	return abs(playerpos.x - self.global_position.x) < ATTACK_RANGE

# Função que faz o inimigo receber dano
func take_damage(damage):
	$AnimationPlayer.play("damaged")
	player.drain_mana(10)
	
	# Checa se o jogador tem mana suficiente para causar dano
	if Global.player_mana > 10:
		Global.enemy_health -= damage
		
	# Checa se o inimigo morreu
	if Global.enemy_health <= 0:
		# Coloca o item no chão onde o inimigo morreu
		get_parent().get_node("Items/ItemA2").global_position = self.global_position
		GUI.midPressable = false
		queue_free()

# Função que é chamada quando um corpo entra na área do inimigo
func _on_Area2D_body_entered(body):
	# Checa se o corpo que entrou na área é o jogador e se o inimigo pode machucar
	if body == player and canHurt:
		player.take_damage(50)
		canHurt = false
		$HurtCooldown.start()

# Função que é chamada quando o tempo de cooldown de ataque acaba
func _on_AtkCooldown_timeout():
	canAttack = true

# Função que é chamada quando o tempo de cooldown de dano acaba
func _on_HurtCooldown_timeout():
	canHurt = true
