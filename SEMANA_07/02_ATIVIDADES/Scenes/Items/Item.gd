extends Area2D

func _on_Item_area_entered(_area):
	modulate = Color("#6668ff")

func _on_Item_area_exited(_area):
	modulate = Color("#ffffff")
