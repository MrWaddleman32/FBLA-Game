extends CharacterBody3D


var SPEED = 5.0
const JUMP_VELOCITY = 4.5
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var coyote_time := 0.15
var coyote_counter := 0.0
@onready var dust_trail := $DustTrail

func _physics_process(delta: float) -> void:
	
	if is_on_floor():
		coyote_counter = coyote_time
	else:
		coyote_counter -= delta

	var direction = Vector3()
	if Input.is_action_pressed("move_left"):
		direction.x = -1
	if Input.is_action_pressed("move_right"):
		direction.x = 1
	if Input.is_action_pressed("move_up"):
		direction.z = -1
	if Input.is_action_pressed("move_down"):
		direction.z = 1
	
	direction = direction.normalized()
	
	if Input.is_action_pressed("sprint"):
		dust_trail.emitting = true
		SPEED = 7.5
		if not is_on_floor():
			dust_trail.emitting = false
	else:
		dust_trail.emitting = false
		SPEED = 5.0
	
	
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	if Input.is_action_pressed("jump") and coyote_counter > 0:
		velocity.y = JUMP_VELOCITY
		coyote_counter = 0.0
		
	move_and_slide()
	
		
