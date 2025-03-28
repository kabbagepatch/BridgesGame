extends Node

class_name Inventory

@onready var inventory_ui: InventoryUI = $"../InventoryUI"

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("toggle_inventory"):
		inventory_ui.toggle()
