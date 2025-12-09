extends CharacterBody3D


var SPEED = 5.0
const JUMP_VELOCITY = 4.5
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var coyote_time := 0.15
var coyote_counter := 0.0
var respawn_position = Vector3(0,1,0)
@onready var dust_trail := $DustTrail
@onready var anim_tree = $AnimationTree
@onready var state_machine = anim_tree.get("parameters/playback")
@onready var mesh = $MeshInstance3D

func _physics_process(delta: float) -> void:
	if is_on_floor():
		coyote_counter = coyote_time
	else:
		coyote_counter -= delta

	var direction = Vector3()
	if Input.is_action_pressed("move_left"):
		direction.x = -1
		mesh.rotation_degrees.y = 270
	if Input.is_action_pressed("move_right"):
		direction.x = 1
		mesh.rotation_degrees.y = 90
	if Input.is_action_pressed("move_up"):
		direction.z = -1
		mesh.rotation_degrees.y = 180
	if Input.is_action_pressed("move_down"):
		direction.z = 1
		mesh.rotation_degrees.y = 0
	
	var horizontal_velocity = Vector3(velocity.x, 0, velocity.z)
	var moving = horizontal_velocity.length() > 0.1
	print(moving)
	anim_tree.set("parameters/conditions/is_moving", moving)
	anim_tree.set("parameters/conditions/is_idle", !moving)
	
	direction = direction.normalized()
	
	
	if Input.is_action_pressed("sprint"):
		dust_trail.emitting = true
		SPEED = 7.5
		if not is_on_floor():
			dust_trail.emitting = false
	else:
		dust_trail.emitting = false
		SPEED = 5.0
	
	if global_transform.origin.y < -10:
		global_transform.origin = respawn_position
		velocity = Vector3.ZERO
	
	
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	if Input.is_action_pressed("jump") and coyote_counter > 0:
		velocity.y = JUMP_VELOCITY
		coyote_counter = 0.0
		
	move_and_slide()
	
	


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body == self:
		call_deferred("_teleport_to_engineering")

func _teleport_to_engineering():
	get_tree().change_scene_to_file("res://engineering_world.tscn")
	
func _teleport_to_main():
	get_tree().change_scene_to_file("res://floor.tscn")


func _on_tp_to_main_body_entered(body: Node3D) -> void:
	if body == self:
		call_deferred("_teleport_to_main") # Replace with function body.
