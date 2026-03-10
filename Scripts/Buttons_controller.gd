extends Control
@onready var ui_overlay_manager: Node3D = $UI_Overlay_Manager


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ui_overlay_manager.turn_off_hint_text()
	ui_overlay_manager.turn_off_instruction_text()




func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/begCutScene.tscn")


func _on_quit_btn_pressed() -> void:
	get_tree().quit(0)
