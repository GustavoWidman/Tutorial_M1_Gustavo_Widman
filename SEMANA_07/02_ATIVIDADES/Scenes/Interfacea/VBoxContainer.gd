extends HBoxContainer


func _on_CollectArea_item_collected(item):
	if item == "ItemA1":
		$ItemA1.visible = true
	elif item == "ItemA2":
		$ItemA2.visible = true
	elif item == "ItemA3":
		$ItemA3.visible = true
