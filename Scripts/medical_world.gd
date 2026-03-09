extends Node3D

@onready var player: CharacterBody3D = $Player
@onready var animation_player: AnimationPlayer = $Path3D/PathFollow3D/AnimationPlayer
@onready var ui_overlay_manager: Node3D = $UI_Overlay_Manager
@onready var old_man: CharacterBody3D = $Path3D/PathFollow3D/OldMan
var cutscene_played = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	Inventory.inventory.clear()
	player.can_move = false
	CutsceneManager.turn_on_UI()
	CutsceneManager.change_text("Now we will learn about the medical field")
	await CutsceneManager.wait(3)
	CutsceneManager.change_text("Follow me")
	player.can_move = true
	animation_player.play("Follow Path")
	CutsceneManager.turn_off_UI()
	ui_overlay_manager.change_instruction_text("Follow the old man")
	ui_overlay_manager.turn_on_instruction_text()
	
	




func _on_old_man_falling_zone_body_entered(body: Node3D) -> void:
	if body == player and !cutscene_played:
		cutscene_played = true
		player.can_move = false
		player.velocity = Vector3(0,0,0)
		player.look_at(old_man.position)
		CutsceneManager.change_text("Oh no, I don't feel so good")
		CutsceneManager.turn_on_UI()
		await CutsceneManager.wait(3)
		animation_player.play("Falling Down")
		await CutsceneManager.wait(3)
		animation_player.play("fade out")
		CutsceneManager.wait(1)
		get_tree().change_scene_to_file("res://Scenes/medical_world_2.tscn")
