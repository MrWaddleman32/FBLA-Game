extends Node3D

@onready var camera_3d: Camera3D = $Camera3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	camera_3d.current = true
	CutsceneManager.turn_off_UI()
	animation_player.play("fade in")
	await CutsceneManager.wait(2)
	animation_player.play("camera close in")
	await CutsceneManager.wait(1.5)
	animation_player.play("fade in", -1, -1, true)
	await CutsceneManager.wait(1)
	get_tree().change_scene_to_file("res://Scenes/inside_mouth.tscn")
