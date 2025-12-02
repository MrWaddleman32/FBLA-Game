extends CharacterBody3D


var SPEED = 5.0
const JUMP_VELOCITY = 4.5
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var dust_trail := $DustTrail

func _physics_process(delta: float) -> void:
	
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
	if is_on_floor() and Input.is_action_pressed("jump"):
		velocity.y = JUMP_VELOCITY
		
	move_and_slide()
	
		
