extends KinematicBody2D

const GRAVITY = 1500
const JUMP_FORCE = -900
const MOVE_SPEED = 400


enum PlayerState {
	IDLE,
	WALK,
	JUMP,
	DEAD,
	ATTACK
}

var velocity = Vector2.ZERO
var state = PlayerState.IDLE

func _physics_process(delta):
	if state != PlayerState.DEAD:
		var input_vector = Vector2.ZERO

		if GUI.leftPress or Input.is_action_pressed("ui_left"):
			input_vector.x = -1
		elif GUI.rightPress or Input.is_action_pressed("ui_right"):
			input_vector.x = +1
		
		velocity.x = input_vector.x * MOVE_SPEED

		if is_on_floor():
			if Input.is_action_pressed("ui_up") or GUI.upPress:
				velocity.y = JUMP_FORCE
				if state != PlayerState.ATTACK:
					state = PlayerState.JUMP
			else:
				velocity.y = 0
				if velocity.x == 0:
					if state != PlayerState.ATTACK:
						state = PlayerState.IDLE
				else:
					if state != PlayerState.ATTACK:
						state = PlayerState.WALK
		else:
			if velocity.y != 0:
				if state != PlayerState.ATTACK:
					state = PlayerState.JUMP
			velocity.y += GRAVITY * delta

		velocity = move_and_slide(velocity, Vector2.UP)

		if input_vector.x < 0:
			$Sprite.flip_h = true
		elif input_vector.x > 0:
			$Sprite.flip_h = false

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

func take_damage(damage):
	$AnimationPlayer.play("damaged")
	Global.player_health -= damage
	if Global.player_health <= 0:
		state = PlayerState.DEAD

func drain_mana(mana):
	if Global.player_mana <= 0:
		take_damage(10)
		$CanvasLayer/Label.text = "Sem MP!"
		yield(get_tree().create_timer(.5), "timeout")
		$CanvasLayer/Label.text = ""
	elif Global.player_mana == 10:
		var oldState = state
		state = PlayerState.ATTACK
		$CanvasLayer/Label.text = "Sem MP!"
		Global.player_mana -= mana
		yield(get_tree().create_timer(.5), "timeout")
		$CanvasLayer/Label.text = ""
		yield(get_tree().create_timer(.5), "timeout")
		state = oldState
	else:
		var oldState = state
		state = PlayerState.ATTACK
		Global.player_mana -= mana
		yield(get_tree().create_timer(.5), "timeout")
		state = oldState
