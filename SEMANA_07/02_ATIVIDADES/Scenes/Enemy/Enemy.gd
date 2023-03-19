extends KinematicBody2D

const MOVE_SPEED = 150
const ATTACK_RANGE = 300
const DAMAGE = 10
const GRAVITY = 300

var velocity = Vector2.ZERO
var direction = Vector2.LEFT

var canAttack = true
var canHurt = true

var current_health = Global.enemy_health

var player = null

var facing = "left"

func _ready():
	player = get_parent().get_node("Player")

func _physics_process(_delta):
	if is_on_wall():
		direction = -direction
		$Sprite.flip_h = not $Sprite.flip_h
		if facing == "left":
			facing = "right"
		else:
			facing = "left"

	if player.global_position.x - self.global_position.x > 0 and facing == "left" and player.global_position.y > 600:
		direction = -direction
		$Sprite.flip_h = not $Sprite.flip_h
		facing = "right"
	elif player.global_position.x - self.global_position.x < 0 and facing == "right" and player.global_position.y > 600:
		direction = -direction
		$Sprite.flip_h = not $Sprite.flip_h
		facing = "left"
	
	if is_in_attack_range(player.global_position):
		# is in attack range
		GUI.midPressable = true
		if GUI.midPress:
			if canAttack:
				$AtkCooldown.start()
				canAttack = false
				take_damage(10)
	else:
		GUI.midPressable = false
	
	
	direction.y = GRAVITY
	velocity = move_and_slide(Vector2(direction.x * MOVE_SPEED, direction.y), Vector2.UP)

func _process(_delta):
	if Global.enemy_health != current_health:
		animate_value(current_health, Global.enemy_health)
		#update_count_text(Global.enemy_health)
	current_health = Global.enemy_health

func animate_value(start, end):
	$Tween.interpolate_property($TextureProgress, "value", start, end, 0.5, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	#$Tween.interpolate_method(self, "update_count_text", start, end, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()
	#if end < start:
		#$AnimationPlayer.play("shake")

func is_in_range(playerpos):
	return abs(playerpos.x - self.global_position.x) < 500

func is_in_attack_range(playerpos):
	return abs(playerpos.x - self.global_position.x) < ATTACK_RANGE

func take_damage(damage):
	$AnimationPlayer.play("damaged")
	player.drain_mana(10)
	if Global.player_mana > 10:
		Global.enemy_health -= damage
	if Global.enemy_health <= 0:
		get_parent().get_node("Items/ItemA2").global_position = self.global_position
		GUI.midPressable = false
		queue_free()

func _on_Area2D_body_entered(body):
	if body == player and canHurt:
		player.take_damage(50)
		canHurt = false
		$HurtCooldown.start()
		

func _on_AtkCooldown_timeout():
	canAttack = true

func _on_HurtCooldown_timeout():
	canHurt = true
