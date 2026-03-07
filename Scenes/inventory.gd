extends Node3D
@onready var canvas_layer: CanvasLayer = $CanvasLayer
const TREE_LOG = preload("uid://db2l70uxvrprh")
@onready var item_1: TextureRect = $CanvasLayer/GridContainer/Item1
@onready var item_2: TextureRect = $CanvasLayer/GridContainer/Item2
@onready var item_3: TextureRect = $CanvasLayer/GridContainer/Item3
@onready var item_4: TextureRect = $CanvasLayer/GridContainer/Item4
@onready var item_5: TextureRect = $CanvasLayer/GridContainer/Item5

var inventory = {}
var items = {"Wood": TREE_LOG}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if inventory:
		pass
	
func add(item):
	if item in inventory:
		inventory[item] = inventory[item] + 1
	else:
		inventory[item] = 0
	

func turn_off_inventory():
	canvas_layer.visible = false
	
func turn_on_inventory():
	canvas_layer.visible = true
