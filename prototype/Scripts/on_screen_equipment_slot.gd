extends VBoxContainer

class_name OnScreenEquipmentSlot

@onready var slot_label: Label = $SlotLabel
@onready var texture_rect: TextureRect = %TextureRect
@onready var count_label: Label = $NinePatchRect/CountLabel

@export var slot_name: String

func _ready() -> void:
	slot_label.text = slot_name

func set_equipment_texture(texture: Texture):
	texture_rect.texture = texture

func set_equipment_count(count: int):
	count_label.text = "" if count <= 1 else str(count)

func get_equipment_count() -> int:
	return int(count_label.text)

func is_slot_set() -> bool:
	return texture_rect.texture != null
