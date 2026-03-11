extends Node2D

@onready var item_list: ItemList = $CanvasLayer/TextureRect/ItemList
@onready var reactant_1: TextureButton = $"CanvasLayer/TextureRect/Reactant 1"
@onready var reactant_2: TextureButton = $"CanvasLayer/TextureRect/Reactant 2"
@onready var solution: TextureButton = $CanvasLayer/TextureRect/Solution

const BEAKER_1 = preload("uid://bh2qn1kx8kiur")
const BEAKER_2 = preload("uid://wmxqcmrivuko")
const BEAKER_3 = preload("uid://2rbt4pfuttf5")
const BEAKER_4 = preload("uid://bh1cdj56got6h")
const BEAKER_5 = preload("uid://bixav4d84lr7")

var dragged_texture: Texture2D = null
var drag_icon: TextureRect = null
var dragging := false
@onready var ui_overlay_manager: Node3D = $UI_Overlay_Manager



func _ready() -> void:
	item_list.add_item("Nitric Acid", BEAKER_1)
	item_list.add_item("Hydrochloric Acid", BEAKER_2)
	item_list.add_item("Sulfuric Acid", BEAKER_3)
	item_list.add_item("Baking Soda", BEAKER_4)
	ui_overlay_manager.turn_on_hint_text()
	ui_overlay_manager.turn_off_instruction_text()
	ui_overlay_manager.change_hint_text("H2SO4 + HNO3")


func _process(delta: float) -> void:
	if dragging and drag_icon:
		drag_icon.global_position = get_viewport().get_mouse_position() - drag_icon.size / 2
	if reactant_1.texture_normal == BEAKER_1 and reactant_2.texture_normal == BEAKER_3:
		solution.texture_normal = BEAKER_5
		
		
	
func _on_item_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	if mouse_button_index == MOUSE_BUTTON_LEFT:

		dragged_texture = item_list.get_item_icon(index)

		drag_icon = TextureRect.new()
		drag_icon.texture = dragged_texture
		drag_icon.size = Vector2(64, 64)
		drag_icon.mouse_filter = Control.MOUSE_FILTER_IGNORE

		get_tree().root.add_child(drag_icon)

		dragging = true


func _on_reactant_1_pressed() -> void:

	# placing item
	if dragging:
		reactant_1.texture_normal = dragged_texture
		stop_drag()

	# removing item
	elif reactant_1.texture_normal != null:
		reactant_1.texture_normal = null


func _on_reactant_2_pressed() -> void:
	# placing item
	if dragging:
		reactant_2.texture_normal = dragged_texture
		stop_drag()

	# removing item
	elif reactant_2.texture_normal != null:
		reactant_2.texture_normal = null


func stop_drag():
	if drag_icon:
		drag_icon.queue_free()
		drag_icon = null

	dragging = false
	dragged_texture = null


func _on_solution_pressed() -> void:
	if solution.texture_normal == BEAKER_5:
		Inventory.add("Explosive Acid")
		CutsceneManager.wait(2)
		get_tree().change_scene_to_file("res://Scenes/science_world_2.tscn")
