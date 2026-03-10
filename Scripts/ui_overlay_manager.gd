extends Node3D

@onready var instruction : Panel = $CanvasLayer/Panel
@onready var instruction_text: Label = $CanvasLayer/Panel/Label

@onready var hint_text_panel: Panel = $CanvasLayer/Panel2
@onready var hint_text: Label = $"CanvasLayer/Panel2/hint text 2"

@onready var options_panel: TextureRect = $"CanvasLayer/Options Panel"
@onready var menu_panel: TextureRect = $"CanvasLayer/Menu Panel"

var pausemenu_on = false


func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS


func turn_on_hint_text():
	hint_text_panel.visible = true
	
func turn_off_hint_text():
	hint_text_panel.visible = false
	
func turn_on_instruction_text():
	instruction.visible = true
	
func turn_off_instruction_text():
	instruction.visible = false
	
func change_hint_text(new_text):
	hint_text.text = new_text
		
func change_instruction_text(new_text):
	instruction_text.text = new_text


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		pausemenu_on = !pausemenu_on
		get_tree().paused = pausemenu_on
		menu_panel.visible = pausemenu_on


func _on_options_btn_pressed() -> void:
	options_panel.visible = true


func _on_play_btn_pressed() -> void:
	menu_panel.visible = false
	get_tree().paused = false
	pausemenu_on = false


func _on_texture_button_pressed() -> void:
	options_panel.visible = false


func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, value/5 - 20)


func _on_quit_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
