extends StaticBody2D

class_name TreeStump

@export var health: int = 50
@export var item_to_drop: InventoryItem
@export var loot_count = 10

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var health_system: HealthSystem = $HealthSystem
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var area_collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

const PICKUP_ITEM_SCENE = preload("res://Scenes/pickup_item.tscn")

func _ready() -> void:
	health_system.init(health)
	progress_bar.max_value = health
	progress_bar.value = health
	
	health_system.destroyed.connect(on_destroyed)

func apply_damage(damage: int):
	health_system.apply_damage(damage)

func on_destroyed() -> void:
	sprite_2d.hide()
	collision_shape_2d.set_deferred("disabled", true)
	area_collision_shape_2d.set_deferred("disabled", true)
	var loot_drop = PICKUP_ITEM_SCENE.instantiate() as PickUpItem
	loot_drop.inventory_item = item_to_drop
	loot_drop.count = loot_count
	
	get_tree().root.add_child(loot_drop)
	loot_drop.global_position = position
	progress_bar.visible = false
