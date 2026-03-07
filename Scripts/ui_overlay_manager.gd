extends Node3D

@onready var instruction : Panel = $CanvasLayer/Panel
@onready var instruction_text: Label = $CanvasLayer/Panel/Label

@onready var hint_text_panel: Panel = $CanvasLayer/Panel2
@onready var hint_text: Label = $"CanvasLayer/Panel2/hint text 2"


func turn_on_hint_text():
	hint_text_panel.visible = true
	
func turn_off_hint_text():
	hint_text_panel.visible = false
	
func turn_on_instruction_text():
	hint_text_panel.visible = true
	
func turn_off_instruction_text():
	instruction.visible = false
	
func change_hint_text(new_text):
	hint_text.text = new_text
		
func change_instruction_text(new_text):
	instruction_text.text = new_text
