extends Area2D

# Esta função é chamada quando uma área entra na área do item
func _on_Item_area_entered(_area):
	modulate = Color("#6668ff")

# Esta função é chamada quando uma área sai da área do item
func _on_Item_area_exited(_area):
	modulate = Color("#ffffff")
