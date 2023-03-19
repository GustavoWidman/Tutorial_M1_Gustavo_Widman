extends Node

var counter = 0

func _process(_delta):
	if player_mana != 100:
		if counter == 500:
			counter = 0
			player_mana +=10
		else:
			counter = counter + 1
		



var player_health = 100
var player_mana = 100

var enemy_health = 100
