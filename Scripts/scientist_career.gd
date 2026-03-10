extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player: CharacterBody3D = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CutsceneManager.turn_off_UI()
	Inventory.turn_off_inventory()
	player.can_move = false
	animation_player.play("new_animation")
	await CutsceneManager.wait(2)
	get_tree().change_scene_to_file("res://Scenes/final_text_scientist.tscn")
