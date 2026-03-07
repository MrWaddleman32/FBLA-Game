extends Node3D

@onready var player: CharacterBody3D = $Player
const old_man_sprite = preload("uid://bju1qnrhtrtgs")
@onready var teacher: CharacterBody3D = $Path3D/PathFollow3D/Teacher
@onready var animation_player: AnimationPlayer = $Path3D/PathFollow3D/AnimationPlayer
@onready var ui_overlay_manager: Node3D = $UI_Overlay_Manager
@onready var CutScene_pt2: Area3D = $Area3D
var cutscene_played = false
@onready var second_cam: Camera3D = $Camera3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ui_overlay_manager.turn_off_hint_text()
	player.can_move = false
	CutsceneManager.turn_off_UI()
	await CutsceneManager.wait(2)
	CutsceneManager.turn_on_UI()
	CutsceneManager.change_sprite(old_man_sprite)
	#CutsceneManager.change_sprite(null)
	CutsceneManager.change_text("This is a construction site for if you want to become an engineer")
	await CutsceneManager.wait(4)
	CutsceneManager.change_text("Follow me")
	await CutsceneManager.wait(2)
	player.can_move = true
	animation_player.play("Follow Path")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func engineering_cs_pt2(body: Node3D) -> void:
	if cutscene_played:
		return
	if body == player:
		second_cam.current = true
		
		var dx = teacher.global_position.x - player.global_position.x
		var dz = teacher.global_position.z - player.global_position.z
		teacher.rotation.y = atan(dx/dz)
		player.rotation.y = atan(dx/dz) + PI
		
		set_deferred("monitorable", false)
		set_deferred("monitoring", false)
		player.can_move = false
		player.velocity = Vector3(0,0,0)
		CutsceneManager.turn_on_UI()
		CutsceneManager.change_text("Engineers are typically tasked with designing and building new things but \
		thats not all they do. They also know how to think on their own")
		await CutsceneManager.wait(7)
		CutsceneManager.change_text("You will now have to build something for your test")
		await CutsceneManager.wait(3)
		CutsceneManager.change_text("To be able to leave the world you will have to \
		build a ladder to get to the door at the top")
		await CutsceneManager.wait(6)
		CutsceneManager.change_text("You will be given the steps on how to \
		build the ladder")
		await CutsceneManager.wait(5)
		CutsceneManager.change_text("Goodluck I will be here if you need me")
		await CutsceneManager.wait(3)
		ui_overlay_manager.turn_on_instruction_text()
		ui_overlay_manager.change_instruction_text("Go collect some wood")
		cutscene_played = true
		CutsceneManager.turn_off_UI()
		player.can_move = true
		second_cam.current = false
		player.rotation.y = 0


func _on_wood_place_body_entered(body: Node3D) -> void:
	ui_overlay_manager.visibility_changed_hint_text("Press E or Top Btn to pick up wood")
