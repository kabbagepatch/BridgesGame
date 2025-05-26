extends Node2D

class_name ToolUsageSystem

@onready var animated_sprite_2d: AnimationController = $"../AnimatedSprite2D"
@onready var active_tool_sprite: Sprite2D = $ToolSprite
@onready var active_tool_collision_shape_2d: CollisionShape2D = $ToolSprite/Area2D/CollisionShape2D

@export var active_tool: ToolItem

var can_use = true

func _ready() -> void:
	animated_sprite_2d.tool_use_animation_finished.connect(on_tool_use_animation_finished)

func _input(event):
	if Input.is_action_just_pressed("use_tool_action"):
		if !can_use:
			return
		can_use = false
		animated_sprite_2d.play_use_tool_animation()
		
		if active_tool == null:
			return
		var use_direction = animated_sprite_2d.use_tool_direciton
		var use_data = active_tool.get_data_for_direction(use_direction)
		active_tool_sprite.position = use_data.get("attachment_position")
		active_tool_sprite.rotation_degrees = use_data.get("rotation")
		active_tool_sprite.z_index = use_data.get("z_index")
		active_tool_collision_shape_2d.disabled = false
		active_tool_sprite.show()
	elif Input.is_anything_pressed():
		on_tool_use_animation_finished()

func set_active_tool(tool: ToolItem):
	if tool.collision_shape != null:
		active_tool_collision_shape_2d.shape = tool.collision_shape

	active_tool_sprite.texture = tool.in_hand_texture
	active_tool = tool

func on_tool_use_animation_finished():
	can_use = true
	active_tool_sprite.hide()
	active_tool_collision_shape_2d.disabled = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_node("HealthSystem"):
		(body.find_child("HealthSystem") as HealthSystem).apply_damage(active_tool.damage)
