extends CanvasLayer

class_name OnScreenUI

@onready var tool_slot: OnScreenEquipmentSlot = %ToolSlot
@onready var material_slot: OnScreenEquipmentSlot = %MaterialSlot

@onready var slots_dict = {
	"Tool": tool_slot,
	"Material": material_slot
}

func equip_item(item: InventoryItem, slot_type: String):
	slots_dict[slot_type].set_equipment_texture(item.texture)
	slots_dict[slot_type].set_equipment_count(item.total_count)

func unequip_item(item: InventoryItem):
	slots_dict[item.slot_type].set_equipment_texture(null)
	slots_dict[item.slot_type].set_equipment_count(0)

func add_to_count(slot_type: String, count: int):
	if slots_dict[slot_type].is_slot_set():
		slots_dict[slot_type].set_equipment_count(slots_dict[slot_type].get_equipment_count() + count)
