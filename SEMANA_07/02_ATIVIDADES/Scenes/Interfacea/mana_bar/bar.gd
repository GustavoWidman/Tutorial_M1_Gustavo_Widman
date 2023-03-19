extends HBoxContainer

var current_mana = Global.player_mana
var maximum = 100

func _process(_delta):
	if Global.player_mana != current_mana:
		animate_value(current_mana, Global.player_mana)
		update_count_text(Global.player_mana)
	current_mana = Global.player_mana

func animate_value(start, end):
	$Tween.interpolate_property($TextureProgress, "value", start, end, 0.5, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$Tween.interpolate_method(self, "update_count_text", start, end, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()
	if end < start:
		$AnimationPlayer.play("shake")

func update_count_text(value):
	$Count/Number.text = str(round(value)) + '/' + str(maximum)

