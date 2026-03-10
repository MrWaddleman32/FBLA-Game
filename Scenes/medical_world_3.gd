extends Node3D

@onready var ui_overlay_manager: Node3D = $UI_Overlay_Manager
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var can_leave = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	animation_player.play("fade in")
	await CutsceneManager.wait(1)
	CutsceneManager.turn_on_UI()
	CutsceneManager.change_text("Thank you so much son you saved my life. I don't know how but I must have eaten\
	 my key with my lunch which caused me to faint")
	await CutsceneManager.wait(4)
	CutsceneManager.change_text("Anyways you have learned enough, go through the door at the end of the hall and use the\
	key")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if can_leave and "Key" in Inventory.inventory and Input.is_action_just_pressed("pick_up_item"):
		get_tree().change_scene_to_file("res://Scenes/science_world.tscn")


func _on_leave_area_body_entered(body: Node3D) -> void:
	can_leave = true
