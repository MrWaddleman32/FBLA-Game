extends CharacterBody3D

# -----------------------
# Player settings
# -----------------------
var SPEED: float = 5.0
const JUMP_VELOCITY: float = 4.5
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

var coyote_time := 0.15
var coyote_counter := 0.0
var respawn_position: Vector3 = Vector3(0, 1, 0)

@onready var dust_trail: GPUParticles3D = $DustTrail
@onready var anim_tree: AnimationTree = $AnimationTree
@onready var state_machine = anim_tree.get("parameters/playback")
@onready var mesh: MeshInstance3D = $MeshInstance3D
@onready var collision_1: CollisionShape3D = $CollisionShape3D

# -----------------------
# Camera settings (assign in inspector)
# -----------------------
@export var camera_pivot: Node3D
@export var camera: Camera3D

@export var camera_speed: float = 2.5
@export var camera_distance: float = -6.0
@export var camera_height: float = 2.0

# Internal camera rotation
var cam_yaw: float = 0.0
var cam_pitch: float = deg_to_rad(-20)

# -----------------------
# Input (mouse rotation removed)
# -----------------------
func _unhandled_input(event):
	pass

# -----------------------
# Player movement & camera
# -----------------------
func _physics_process(delta: float) -> void:
	# Coyote time
	if is_on_floor():
		coyote_counter = coyote_time
	else:
		coyote_counter -= delta

	# -----------------------
	# Camera orbit (Roblox-style)
	# -----------------------
	if camera_pivot and camera:
		var cam_input: Vector2 = Vector2(
			Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
			Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		)

		# Update yaw and pitch
		cam_yaw -= cam_input.x * camera_speed * delta
		cam_pitch = clamp(cam_pitch - cam_input.y * camera_speed * delta, deg_to_rad(-30), deg_to_rad(60))

		# Rotate pivot
		camera_pivot.rotation = Vector3(cam_pitch, cam_yaw, 0)

		# Keep camera at offset behind pivot
		camera.transform.origin = Vector3(0, camera_height, -camera_distance)

	# -----------------------
	# Player movement relative to camera
	# -----------------------
	var input_dir = Input.get_vector("move_left", "move_right", "move_down", "move_up") # Vector2
	var cam_forward = -camera_pivot.global_transform.basis.z
	var cam_right = camera_pivot.global_transform.basis.x

	# Flatten to horizontal plane
	cam_forward.y = 0
	cam_right.y = 0
	cam_forward = cam_forward.normalized()
	cam_right = cam_right.normalized()

	var direction = (cam_forward * input_dir.y + cam_right * input_dir.x).normalized()

	# Rotate mesh to face movement direction (fixed)
	if direction.length() > 0.1:
		var move_angle = atan2(direction.x, direction.z)
		mesh.rotation.y = move_angle

	# -----------------------
	# Sprint
	# -----------------------
	if Input.is_action_pressed("sprint") and direction.length() > 0.1:
		dust_trail.emitting = is_on_floor()
		SPEED = 7.5
	else:
		dust_trail.emitting = false
		SPEED = 5.0

	# -----------------------
	# Apply movement
	# -----------------------
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED

	if not is_on_floor():
		velocity.y -= gravity * delta

	# -----------------------
	# Jump
	# -----------------------
	if Input.is_action_pressed("jump") and coyote_counter > 0:
		velocity.y = JUMP_VELOCITY
		coyote_counter = 0.0

	move_and_slide()

	# -----------------------
	# Animation
	# -----------------------
	var horizontal_velocity: Vector3 = Vector3(velocity.x, 0, velocity.z)
	var moving: bool = horizontal_velocity.length() > 0.1
	anim_tree.set("parameters/conditions/is_moving", moving)
	anim_tree.set("parameters/conditions/is_idle", !moving)

	# -----------------------
	# Respawn
	# -----------------------
	if global_transform.origin.y < -10:
		global_transform.origin = respawn_position
		velocity = Vector3.ZERO

# -----------------------
# Teleports
# -----------------------
func _on_area_3d_body_entered(body: Node3D) -> void:
	if body == self:
		call_deferred("_teleport_to_engineering")

func _teleport_to_engineering():
	get_tree().change_scene_to_file("res://engineering_world.tscn")

func _teleport_to_main():
	get_tree().change_scene_to_file("res://floor.tscn")

func _on_tp_to_main_body_entered(body: Node3D) -> void:
	if body == self:
		call_deferred("_teleport_to_main")
