extends Node3D

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var panel: PanelContainer = $CanvasLayer/PanelContainer
@onready var sprite: TextureRect = $CanvasLayer/PanelContainer/HBoxContainer/sprite
@onready var text: Label = $CanvasLayer/PanelContainer/HBoxContainer/text

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(get_viewport().size)



func change_sprite(texture):
	sprite.texture = texture

func change_text(new_text):
	text.text = new_text

func turn_off_UI():
	canvas_layer.visible = false

func turn_on_UI():
	canvas_layer.visible = true
	
func wait(seconds):
	return get_tree().create_timer(seconds).timeout
	
