extends CanvasLayer

var midPressableLocal = false

var pressing = false

func _on_LeftButton_button_down():
	GUI.leftPress = true

func _on_LeftButton_button_up():
	GUI.leftPress = false

func _on_RightPress_button_down():
	GUI.rightPress = true

func _on_RightPress_button_up():
	GUI.rightPress = false

func _on_UpButton_button_down():
	GUI.upPress = true

func _on_UpButton_button_up():
	GUI.upPress = false

func _process(_delta):
	$Joystick/LeftPress.visible = GUI.leftPress
	$Joystick/RightPress.visible = GUI.rightPress
	$JoystickUp/UpPress.visible = GUI.upPress
	
	if GUI.midPressable and midPressableLocal:
		$MidButton.value = 100
		$MidButton/MidButton.visible = true
		midPressableLocal = false
	if GUI.midPressable == false and midPressableLocal == false:
		midPressableLocal = true
		$MidButton.value = 0
		$MidButton/MidButton.visible = false

func _on_MidButton_button_down():
	if pressing == false:
		pressing = true
		GUI.midPress = true
		$MidButton/MidButton.visible = false
		$Tween.interpolate_property($MidButton, "value", 0, 100, 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		$Tween.start()
		yield(get_tree().create_timer(.5), "timeout")
		GUI.midPress = false
		yield(get_tree().create_timer(.5), "timeout")
		$MidButton/MidButton.visible = true
		midPressableLocal = false
		pressing = false
		GUI.midPress = false
