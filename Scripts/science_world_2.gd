extends Node3D
@onready var ui_overlay_manager: Node3D = $UI_Overlay_Manager
@onready var player: CharacterBody3D = $Player
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var babyboo_door_vox: MeshInstance3D = $BabybooDoor_vox

var is_exploded = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ui_overlay_manager.turn_on_instruction_text()
	ui_overlay_manager.turn_off_hint_text()
	player.can_move = false
	player.rotation = Vector3(0,0,0)
	ui_overlay_manager.change_instruction_text("Go blow up the door")
	CutsceneManager.turn_on_UI()
	CutsceneManager.change_text("Now you can go to the door and explode the door open")
	await CutsceneManager.wait(3)
	player.can_move = true
	Inventory.turn_on_inventory()
	CutsceneManager.turn_off_UI()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_explosion_zone_body_entered(body: Node3D) -> void:
	if body == player and not is_exploded:	
		is_exploded = true
		animation_player.play("throw acid")
		Inventory.subtract("Explosive Acid")
