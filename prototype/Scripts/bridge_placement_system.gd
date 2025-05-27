extends Node

class_name BridgePlacementSystem 

const BRIDGE_PLANK_SCENE = preload("res://Scenes/bridge_plank.tscn")

const TILE_SIZE = 16
var player: Player = null
@export var active_material: InventoryItem

func _ready() -> void:
	player = get_parent()

func place_plank():	
	var inventory = player.inventory
	if !active_material || active_material.total_count <= 0:
		set_active_material(null)
		return
	var plank = BRIDGE_PLANK_SCENE.instantiate()
	var player_position = player.position
	var plank_position = Vector2(round(player_position.x / TILE_SIZE) * TILE_SIZE , \
		round(player_position.y / TILE_SIZE) * TILE_SIZE)
	var player_direction = player.direction
	match player_direction:
		"left": plank_position.x -= TILE_SIZE
		"right": plank_position.x += TILE_SIZE
		"up": plank_position.y -= TILE_SIZE
		"down": plank_position.y += TILE_SIZE
	
	plank.position = plank_position
	get_tree().root.get_child(0).add_child(plank)
	get_tree().root.get_child(0).move_child(plank, 1)
	inventory.remove_item_from_stack(active_material)

func set_active_material(material: InventoryItem):
	active_material = material
