extends CharacterBody2D

class_name Player

@onready var animated_sprite_2d: AnimationController = $AnimatedSprite2D
@onready var inventory: Inventory = $Inventory
@onready var bridge_placement_system: BridgePlacementSystem = $BridgePlacementSystem

const SPEED = 5000.0
@export var direction: String

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")

	if direction:
		velocity = direction * SPEED * delta
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * delta)
		velocity.y = move_toward(velocity.y, 0, SPEED * delta)

	if velocity != Vector2.ZERO:
		animated_sprite_2d.play_movement_animation(velocity)
	else:
		animated_sprite_2d.play_idle_animation()

	move_and_slide()

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("right"):
		direction = "right"
	elif Input.is_action_pressed("left"):
		direction = "left"
	elif Input.is_action_pressed("up"):
		direction = "up"
	elif Input.is_action_pressed("down"):
		direction = "down"
	
	if Input.is_action_just_pressed("place_bridge"):
		bridge_placement_system.place_plank()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is PickUpItem:
		inventory.add_item(area.inventory_item, area.count)
		area.queue_free()
