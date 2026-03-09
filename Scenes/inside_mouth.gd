extends Node2D

@onready var crumbs_btn: TextureButton = $CanvasLayer/CrumbsBTN
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var ui_overlay_manager: Node3D = $UI_Overlay_Manager
@onready var chewed_gum_btn: TextureButton = $CanvasLayer/ChewedGumBTN
@onready var old_key_btn: TextureButton = $CanvasLayer/OldKeyBTN

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CutsceneManager.turn_on_UI()
	animation_player.play("fade in")
	ui_overlay_manager.change_instruction_text("Remove all of the obstacles to heal the old man")
	ui_overlay_manager.turn_on_instruction_text()
	ui_overlay_manager.turn_off_hint_text()
	crumbs_btn.disabled = true
	crumbs_btn.visible = false
	chewed_gum_btn.disabled = true
	chewed_gum_btn.visible = false
	old_key_btn.disabled = true
	old_key_btn.visible = false
	await CutsceneManager.wait(3)
	crumbs_btn.disabled = false
	crumbs_btn.visible = true



func _on_crumbs_btn_pressed() -> void:
	ui_overlay_manager.change_hint_text("Good Job, you removed crumbs")
	ui_overlay_manager.turn_on_hint_text()
	crumbs_btn.queue_free()
	await CutsceneManager.wait(2)
	ui_overlay_manager.turn_off_hint_text()
	await CutsceneManager.wait(3.5)
	chewed_gum_btn.disabled = false
	chewed_gum_btn.visible = true
	


func _on_chewed_gum_btn_pressed() -> void:
	ui_overlay_manager.change_hint_text("Good Job, you removed chewed gum")
	ui_overlay_manager.turn_on_hint_text()
	chewed_gum_btn.queue_free()
	await CutsceneManager.wait(2)
	ui_overlay_manager.turn_off_hint_text()
	await CutsceneManager.wait(3.5)
	old_key_btn.disabled = false
	old_key_btn.visible = true




func _on_old_key_btn_pressed() -> void:
	ui_overlay_manager.change_hint_text("Good Job, you removed an... old key?")
	ui_overlay_manager.turn_on_hint_text()
	old_key_btn.queue_free()
	await CutsceneManager.wait(2)
	ui_overlay_manager.turn_off_hint_text()
	await CutsceneManager.wait(3.5)
	animation_player.play("fade in", -1, -1, true)
	await CutsceneManager.wait(1)
	Inventory.add("Key")
	get_tree().change_scene_to_file("res://Scenes/medical_world_3.tscn")
