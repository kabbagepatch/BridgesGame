extends Area2D

class_name PickUpItem

@export var inventory_item: InventoryItem

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var label: Label = $Label

@export var count: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d.texture = inventory_item.texture
	collision_shape_2d.shape = inventory_item.ground_collision_shape
	label.text = str(count) if count > 1 else ""
