extends Node

class_name Inventory

@onready var inventory_ui: InventoryUI = $"../InventoryUI"
@onready var on_screen_ui: OnScreenUI = $"../OnScreenUI"
@onready var tool_usage_system: ToolUsageSystem = $"../ToolUsageSystem"
@onready var material_slot: OnScreenEquipmentSlot = $"MarginContainer/HBoxContainer/MaterialSlot"
@onready var bridge_placement_system: BridgePlacementSystem = $"../BridgePlacementSystem"

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
		item.total_count = 1
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
			inventory_item.total_count += count
			items[item_index] = inventory_item
			inventory_ui.update_count_at(item_index, inventory_item.count)
			on_screen_ui.add_to_count(inventory_item.slot_type, count)
		else:
			var count_diff = inventory_item.count + count - item.max_count
			inventory_item.count = item.max_count
			inventory_item.total_count += count
			items[item_index] = inventory_item
			inventory_ui.update_count_at(item_index, item.max_count)
			var additional_item = inventory_item.duplicate(true)
			additional_item.count = count_diff
			items.append(additional_item)
			inventory_ui.add_item(additional_item)
			on_screen_ui.add_to_count(inventory_item.slot_type, count)
	else:
		item.count = count
		item.total_count = count
		items.append(item)
		inventory_ui.add_item(item)

func remove_item_from_stack(item: InventoryItem):
	var item_index = -1
	for i in items.size():
		if items[i] != null and items[i].name == item.name:
			item_index = i
	
	if item_index == -1:
		return
	var inventory_item = items[item_index]
	inventory_item.count -= 1
	inventory_item.total_count -= 1
	if inventory_item.total_count > 0:
		items[item_index] = inventory_item
		inventory_ui.update_count_at(item_index, inventory_item.count)
		on_screen_ui.add_to_count(inventory_item.slot_type, -1)
	else:
		items.remove_at(item_index)
		inventory_ui.clear_slot_at_index(item_index)
		on_screen_ui.unequip_item(inventory_item)
		bridge_placement_system.set_active_material(null)

func on_item_equipped(ind: int, slot_type_to_equip: String):
	var item_to_equip = items[ind]
	items[ind].equipped = true
	on_screen_ui.equip_item(item_to_equip, slot_type_to_equip)
	if slot_type_to_equip == "Tool":
		tool_usage_system.set_active_tool(item_to_equip.tool_item)
	else:
		bridge_placement_system.set_active_material(item_to_equip)
