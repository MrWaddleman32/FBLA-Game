extends Node3D

@onready var player: CharacterBody3D = $Player
@onready var animation_player: AnimationPlayer = $Path3D/PathFollow3D/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	Inventory.inventory.clear()
	player.can_move = false
	CutsceneManager.turn_on_UI()
	CutsceneManager.change_text("Now we will learn about the medical field")
	await CutsceneManager.wait(3)
	CutsceneManager.change_text("Follow me")
	animation_player.play("Follow Path")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
