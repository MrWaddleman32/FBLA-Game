extends Node3D

@onready var player: CharacterBody3D = $Player
const old_man_sprite = preload("uid://bju1qnrhtrtgs")
@onready var teacher: CharacterBody3D = $Path3D/PathFollow3D/Teacher
@onready var animation_player: AnimationPlayer = $Path3D/PathFollow3D/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await CutsceneManager.wait(2)
	CutsceneManager.turn_on_UI()
	CutsceneManager.change_sprite(old_man_sprite)
	player.can_move = false
	#CutsceneManager.change_sprite(null)
	CutsceneManager.change_text("This is a construction site for if you want to become an engineer")
	await CutsceneManager.wait(2)
	CutsceneManager.change_text("Follow me")
	await CutsceneManager.wait(2)
	animation_player.play("Follow Path")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
