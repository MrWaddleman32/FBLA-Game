extends Node3D
@onready var canvas_layer: CanvasLayer = $CanvasLayer


const TREE_LOG = preload("uid://db2l70uxvrprh")
const WOOD_PREVIEW_2 = preload("uid://bqwr0i4232hdn")
const STICK = preload("uid://d2jg5r04sheeu")
const LADDER = preload("uid://blv3wb5fjx5xa")
const KEY = preload("uid://v1f0twmh8875")


@onready var item_1: TextureRect = $CanvasLayer/GridContainer/Item1
@onready var item_2: TextureRect = $CanvasLayer/GridContainer/Item2
@onready var item_3: TextureRect = $CanvasLayer/GridContainer/Item3
@onready var item_4: TextureRect = $CanvasLayer/GridContainer/Item4
@onready var item_5: TextureRect = $CanvasLayer/GridContainer/Item5

@onready var count_1: Label = $CanvasLayer/GridContainer/Item1/number
@onready var count_2: Label = $CanvasLayer/GridContainer/Item2/number
@onready var count_3: Label = $CanvasLayer/GridContainer/Item3/number
@onready var count_4: Label = $CanvasLayer/GridContainer/Item4/number
@onready var count_5: Label = $CanvasLayer/GridContainer/Item5/number

var item_img = []
var count_lbl = []

var inventory = []
var items = {"Wood": TREE_LOG, "Planks": WOOD_PREVIEW_2, "Stick": STICK, "Ladder" : LADDER, "Key" : KEY}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	item_img = [item_1, item_2, item_3, item_4, item_5]
	count_lbl = [count_1, count_2, count_3, count_4, count_5]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func add(item):
	inventory.append(item)
	update_items_and_count()
	

func subtract(item):
	inventory.erase(item)
	update_items_and_count()

func turn_off_inventory():
	canvas_layer.visible = false
	
func turn_on_inventory():
	canvas_layer.visible = true
	
func update_items_and_count():
	var item_and_count = {}
	for i in range(len(inventory)):
		if inventory[i] in item_and_count:
			item_and_count[inventory[i]] += 1
		else:
			item_and_count[inventory[i]] = 1
	print(inventory)
	print(item_and_count)
	CutsceneManager.turn_off_UI()
	for i in range(len(items.keys())):
		if i < len(item_and_count.keys()):
			item_img[i].texture = items[item_and_count.keys()[i]]
			count_lbl[i].text = str(item_and_count[item_and_count.keys()[i]])
		else:
			item_img[i].texture = null
			count_lbl[i].text = ""
