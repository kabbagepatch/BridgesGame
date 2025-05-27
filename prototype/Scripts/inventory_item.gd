extends Resource

class_name InventoryItem

var count = 1

@export_enum("Tool", "Material", "NotEquipable")
var slot_type: String = "NotEquipable"

@export var ground_collision_shape: RectangleShape2D
@export var name: String = ""
@export var texture: Texture2D;
@export var side_texture: Texture2D;
@export var max_count : int
@export var total_count : int = 0
@export var tool_item: ToolItem
@export var equipped: bool = false
