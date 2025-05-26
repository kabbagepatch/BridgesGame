extends Node

class_name Inventory

@onready var inventory_ui: InventoryUI = $"../InventoryUI"
@onready var on_screen_ui: OnScreenUI = $"../OnScreenUI"

@export var items: Array[InventoryItem] = []

func _ready() -> void:
	inventory_ui.equip_item.connect(on_item_equipped)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("toggle_inventory"):
		inventory_ui.toggle()

func add_item(item: InventoryItem, count: int):
	if count && item.max_count > 1:
		add_stackable_item_to_inventory(item, count)
	else:
		items.append(item)
		inventory_ui.add_item(item)

func add_stackable_item_to_inventory(item: InventoryItem, count: int):
	var item_index = -1
	for i in items.size():
		if items[i] != null and items[i].name == item.name:
			item_index = i
	
	if item_index != -1:
		var inventory_item = items[item_index]
		if inventory_item.count + count <= item.max_count:
			inventory_item.count += count
			items[item_index] = inventory_item
			inventory_ui.update_count_at(item_index, inventory_item.count)
		else:
			var count_diff = inventory_item.count + count - item.max_count
			inventory_item.count = item.max_count
			items[item_index] = inventory_item
			inventory_ui.update_count_at(item_index, item.max_count)
			var additional_item = inventory_item.duplicate(true)
			additional_item.count = count_diff
			items.append(additional_item)
			inventory_ui.add_item(additional_item)
	else:
		item.count = count
		items.append(item)
		inventory_ui.add_item(item)

func on_item_equipped(ind: int, slot_type_to_equip: String):
	var item_to_equip = items[ind]
	on_screen_ui.equip_item(item_to_equip, slot_type_to_equip)
