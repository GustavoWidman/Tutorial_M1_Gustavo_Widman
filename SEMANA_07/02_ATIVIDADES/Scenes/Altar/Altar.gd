extends Node2D

var Rune1Placed = false
var Rune2Placed = false
var Rune3Placed = false

onready var current_dragging_item = null
onready var current_item = null

func _ready():
	$AnimationPlayer.play("RESET")

func on_drag_item(item: Node) -> void:
	if Input.is_action_just_pressed("interact"):
		# Get the position of the item being dragged
		var item_position = item.get_global_position()
		
		# Remove the item from the HBoxContainer
		item.visible = false
		
		# Create a new node to represent the item being dragged
		var dragged_item = TextureRect.new()
		add_child(dragged_item)
		dragged_item.texture = item.texture_normal
		
		# Set the position of the new node to the position of the item being dragged
		dragged_item.set_global_position(item_position)
		
		current_dragging_item = dragged_item
		current_item = item
	
func _process(_delta):
	if Input.is_action_pressed("interact"):
		# DRAG
		if current_item != null:
			var mouse_pos = get_viewport().get_mouse_position()
			current_dragging_item.set_position(Vector2(mouse_pos.x-50, mouse_pos.y-50))
	else:
		if current_item != null:
			if not dropped_item(current_item, current_dragging_item):
				current_item.visible = true
				remove_child(current_dragging_item)
			current_item = null
			
	if Rune1Placed and Rune2Placed and Rune3Placed:
		Rune1Placed = false
		Rune2Placed = false
		Rune3Placed = false
		ritual_finished()
		
func ritual_finished():
	$AnimationPlayer.play("ritual_finished")
	$CanvasLayer.visible = true
	yield($AnimationPlayer, "animation_finished")
	yield(get_tree().create_timer(1), "timeout")
	SceneTransition.change_scene("res://Scenes/Postlude/Postlude.tscn")

func dropped_item(item, drag_item):
	if str(item).get_slice(":", 0) == "Rune1":
		var drag_item_pos = drag_item.get_global_position()
		if drag_item_pos.distance_to($Rune1Nestle.global_position) < 250:
			drag_item.set_global_position(Vector2($Rune1Nestle.global_position.x-45, $Rune1Nestle.global_position.y-46))
			Rune1Placed = true
			return true
	if str(item).get_slice(":", 0) == "Rune2":
		var drag_item_pos = drag_item.get_global_position()
		if drag_item_pos.distance_to($Rune2Nestle.global_position) < 200:
			drag_item.set_global_position(Vector2($Rune2Nestle.global_position.x-50, $Rune1Nestle.global_position.y))
			Rune2Placed = true
			return true
	if str(item).get_slice(":", 0) == "Rune3":
		var drag_item_pos = drag_item.get_global_position()
		if drag_item_pos.distance_to($Rune3Nestle.global_position) < 200:
			drag_item.set_global_position(Vector2($Rune3Nestle.global_position.x-50, $Rune1Nestle.global_position.y+12))
			Rune3Placed = true
			return true
	else:
		return false


func _on_PromptButton_pressed():
	$Prompt.visible = false
	$Prompt/CanvasLayer.visible = false
