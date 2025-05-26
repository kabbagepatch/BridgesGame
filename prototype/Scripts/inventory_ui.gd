extends CanvasLayer

class_name InventoryUI

signal equip_item(ind: int, slot_type_to_equip: String)
@onready var grid_container: GridContainer = %GridContainer
const INVENTORY_SLOT_SCENE = preload("res://Scenes/UI/inventory_slot.tscn")

@export var size = 8
@export var columns = 4

func _ready() -> void:
	grid_container.columns = columns
	
	for i in size:
		var inventory_slot = INVENTORY_SLOT_SCENE.instantiate()
		grid_container.add_child(inventory_slot)
		
		inventory_slot.equip_item.connect(func(slot_type_to_equip: String): equip_item.emit(i, slot_type_to_equip))

func toggle():
	visible = !visible

func add_item(item: InventoryItem):
	var slots = grid_container.get_children().filter(func (slot): return slot.is_empty)
	var first_empty_slot = slots.front() as InventorySlot
	first_empty_slot.add_item(item)

func update_count_at(slot_index: int, count: int):
	if slot_index == -1:
		return
	
	var inventory_slot: InventorySlot = grid_container.get_child(slot_index)
	inventory_slot.count_label.text = str(count)
