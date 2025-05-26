extends AnimatedSprite2D

class_name AnimationController

signal tool_use_animation_finished

const MOVEMENT_TO_IDLE = {
	"back_walk": "back_idle",
	"front_walk": "front_idle",
	"right_walk": "right_idle",
	"left_walk": "left_idle"
}

const DIRECTION_TO_USE_TOOL_VECTOR = {
	"back": Vector2(0, -1),
	"front": Vector2(0, 1),
	"right": Vector2(1, 0),
	"left": Vector2(-1, 0)
}

var use_tool_direciton = null

func play_movement_animation(velocity: Vector2):
	if velocity.x > 0:
		play("right_walk")
	elif velocity.x < 0:
		play("left_walk")
	else:
		if velocity.y > 0:
			play("front_walk")
		elif velocity.y < 0:
			play("back_walk")

func play_idle_animation():
	if MOVEMENT_TO_IDLE.keys().has(animation):
		play(MOVEMENT_TO_IDLE[animation])

func play_use_tool_animation():
	var direction = animation.split("_")[0]
	use_tool_direciton = direction
	play(use_tool_direciton + "_use_tool")

func _on_animation_finished() -> void:
	var animation_string = String(animation)
	if animation_string.contains("_use_tool"):
		var direction = animation_string.split("_")[0]
		play(direction + "_idle")
		use_tool_direciton = null
		tool_use_animation_finished.emit()
