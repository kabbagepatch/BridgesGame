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
