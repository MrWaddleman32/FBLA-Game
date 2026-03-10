extends Node3D

@onready var player: CharacterBody3D = $Player
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var in_lab_station = false
@onready var ui_overlay_manager: Node3D = $UI_Overlay_Manager
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	ui_overlay_manager.turn_off_instruction_text()
	ui_overlay_manager.turn_off_hint_text()
	Inventory.inventory.clear()
	player.can_move = false
	CutsceneManager.turn_off_UI()
	await CutsceneManager.wait(2)
	CutsceneManager.turn_on_UI()
	CutsceneManager.change_text("Finally we will be learning about a day in the life of a scientist")
	await CutsceneManager.wait(3)
	CutsceneManager.change_text("That door at the end is locked and the only way to open it\
	 is to explode it open using chemical reactions")
	await CutsceneManager.wait(3)
	CutsceneManager.change_text("Follow me")
	await CutsceneManager.wait(2)
	player.can_move = true
	animation_player.play("Follow path")
	ui_overlay_manager.turn_on_instruction_text()
	ui_overlay_manager.change_instruction_text("Follow Old Man")
	ui_overlay_manager.turn_off_hint_text()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if in_lab_station and Input.is_action_just_pressed("pick_up_item"):
		open_mixing_station()


func _on_lab_station_body_entered(body: Node3D) -> void:
	if body == player:
		in_lab_station = true
		ui_overlay_manager.turn_on_hint_text()
		ui_overlay_manager.change_hint_text("Press E or Top Button to enter the mixing station")
		
func open_mixing_station():
	get_tree().change_scene_to_file("res://Scenes/mixing_station.tscn")
