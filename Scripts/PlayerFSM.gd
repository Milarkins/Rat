extends KinematicBody2D

#States
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

var fliped = false
onready var anim = $AnimationPlayer

var current_state = IDLE

func _process(delta):
	other()

	if current_state != JUMPING:
		if velocity != Vector2.ZERO:
			set_state(MOVING)
		else:
			set_state(IDLE)
		if Input.is_action_pressed("jump"):
			set_state(JUMPING)
		if Input.is_action_just_pressed("attack_L"):
			set_state(LIGHT_ATTACK)
		if Input.is_action_just_pressed("attack_H"):
			set_state(HEAVY_ATTACK)
	else:
		if Input.is_action_just_pressed("attack_L"):
			set_state(LIGHT_AIR_ATTACK)
		if Input.is_action_just_pressed("attack_H"):
			set_state(HEAVY_AIR_ATTACK)

func _physics_process(delta):
	match current_state:
		IDLE:
			anim.play("Idle")
		JUMPING:
			anim.play("Jump")
			move()
		MOVING:
			anim.play("Move")
			move()
		LIGHT_ATTACK:
			pass
		HEAVY_ATTACK:
			pass
		LIGHT_AIR_ATTACK:
			pass
		HEAVY_AIR_ATTACK:
			pass

func set_state(state):
	current_state = state

#non-state machine
func jump():
	pass

func move():
	move_and_slide(velocity.normalized() * speed)
	if(velocity.x > 0 and fliped == false):
		fliped = true
	elif(velocity.x < 0 and fliped != false):
		fliped = false

func other():
	velocity.x = Input.get_action_raw_strength("right") - Input.get_action_raw_strength("left")
	velocity.y = Input.get_action_raw_strength("down") - Input.get_action_raw_strength("up")
	position.y = clamp(position.y, 1080 * 0.6, 1080 * 0.93)
	$Sprite.flip_h = fliped
