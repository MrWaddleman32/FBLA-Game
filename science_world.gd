extends Node3D

@onready var player: CharacterBody3D = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	player.can_move = false
	CutsceneManager.change_text("Finally we will be learning about a day in the life of a scientist")
	CutsceneManager.wait(3)
	CutsceneManager.change_text("That door at the end is locked and the only way to open it\
	is to explode it open using chemical reactions")
	CutsceneManager.wait(3)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
