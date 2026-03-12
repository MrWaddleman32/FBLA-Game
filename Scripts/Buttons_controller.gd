extends Control
@onready var ui_overlay_manager: Node3D = $UI_Overlay_Manager

var btns = ["Play", "Options", "Quit"]
var btn_index = 0
var selected_btn = btns[btn_index]
@onready var play_marker_1: ColorRect = $PlayButton/PlayMarker1
@onready var play_marker_2: ColorRect = $PlayButton/PlayMarker2
@onready var options_marker_1: ColorRect = $OptionsBTN/OptionsMarker1
@onready var options_marker_2: ColorRect = $OptionsBTN/OptionsMarker2
@onready var quit_marker_1: ColorRect = $QuitBTN/QuitMarker1
@onready var quit_marker_2: ColorRect = $QuitBTN/QuitMarker2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ui_overlay_manager.turn_off_hint_text()
	ui_overlay_manager.turn_off_instruction_text()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("move_down"):
		btn_index += 1
		if btn_index >= len(btns):
			btn_index = 0
	elif Input.is_action_just_pressed("move_up"):
		btn_index -= 1
		if btn_index < 0:
			btn_index = len(btns) - 1
	
	selected_btn = btns[btn_index]
	
	if selected_btn == "Play":
		play_marker_1.visible = true
		play_marker_2.visible = true
		options_marker_1.visible = false
		options_marker_2.visible = false
		quit_marker_1.visible = false
		quit_marker_2.visible = false
		
	elif selected_btn == "Options":
		play_marker_1.visible = false
		play_marker_2.visible = false
		options_marker_1.visible = true
		options_marker_2.visible = true
		quit_marker_1.visible = false
		quit_marker_2.visible = false
		
	elif selected_btn == "Quit":
		play_marker_1.visible = false
		play_marker_2.visible = false
		options_marker_1.visible = false
		options_marker_2.visible = false
		quit_marker_1.visible = true
		quit_marker_2.visible = true
	
	if Input.is_action_just_pressed("jump"):
		if selected_btn == "Play":
			_on_play_button_pressed()
		elif selected_btn == "Options":
			ui_overlay_manager._on_options_btn_pressed()
		elif selected_btn == "Quit":
			_on_quit_btn_pressed()


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/begCutScene.tscn")


func _on_quit_btn_pressed() -> void:
	get_tree().quit(0)
