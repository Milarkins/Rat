extends KinematicBody2D
class_name player

#State Machine
func set_state(state): current_state = state
var current_state = IDLE
enum {
#movement
	IDLE,
	MOVING,
	JUMPING,
#attacks
	LIGHT_ATTACK,
	HEAVY_ATTACK,
	LIGHT_AIR_ATTACK,
	HEAVY_AIR_ATTACK 
}

const speed = 450
var velocity = Vector2.ZERO

func _process(delta):
	velocity = Vector2(
		Input.get_action_raw_strength("right") - Input.get_action_raw_strength("left"),
		Input.get_action_raw_strength("down") - Input.get_action_raw_strength("up")
	).normalized()

	if current_state != JUMPING:
		if velocity != Vector2.ZERO:
			set_state(MOVING)
		if velocity == Vector2.ZERO:
			set_state(IDLE)
	if Input.is_action_pressed("jump"):
		set_state(JUMPING)

#Data Matching
func _physics_process(delta):
	match current_state:
		IDLE:
			pass
		JUMPING:
			move_and_slide(velocity * (speed/2))
		MOVING:
			move_and_slide(velocity * speed)
		LIGHT_ATTACK:
			pass
		HEAVY_ATTACK:
			pass
		LIGHT_AIR_ATTACK:
			pass
		HEAVY_AIR_ATTACK:
			pass
