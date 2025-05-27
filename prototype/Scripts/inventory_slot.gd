extends VBoxContainer

class_name InventorySlot

signal equip_item

var is_empty = true
var is_selected = false

@export var single_button_press = false
@export var starting_texture: Texture
@export var start_label: String

@onready var texture_rect: TextureRect = $NinePatchRect/MenuButton/CenterContainer/TextureRect
@onready var name_label: Label = $NameLabel
@onready var count_label: Label = $NinePatchRect/CountLabel
@onready var on_click_button: Button = $NinePatchRect/OnClickButton
@onready var menu_button: MenuButton = $NinePatchRect/MenuButton

var slot_type_to_equip = "NotEquipable"

func _ready() -> void:
	if starting_texture != null:
		texture_rect.texture = starting_texture

	if start_label != null:
		name_label.text = start_label

	menu_button.disabled = single_button_press
	on_click_button.disabled = !single_button_press
	on_click_button.visible = single_button_press
	
	var popup_menu = menu_button.get_popup()
	popup_menu.id_pressed.connect(on_popup_menu_item_pressed)

func on_popup_menu_item_pressed(id: int):
	var pressed_menu_item = menu_button.get_popup().get_item_text(id)
	
	if pressed_menu_item.contains("Equip") and slot_type_to_equip != "NotEquipable":
		equip_item.emit(slot_type_to_equip)

func add_item(item: InventoryItem):
	var popup_menu: PopupMenu = menu_button.get_popup()
	if item.slot_type != "NotEquipable":
		slot_type_to_equip = item.slot_type
		popup_menu.set_item_text(0, "Equip " + slot_type_to_equip)
	else:
		popup_menu.remove_item(0)
	
	is_empty = false
	menu_button.disabled = false
	texture_rect.texture = item.texture
	name_label.text = item.name
	if item.count < 2: 
		return
	count_label.text = str(item.count)
