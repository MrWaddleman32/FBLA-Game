extends Node3D

@onready var camera: Camera3D = $Camera3D
@onready var animationPlayer: AnimationPlayer = get_node_or_null("AnimationPlayer")
@onready var player: CharacterBody3D = $CharacterBody3D2
@onready var old_man: CharacterBody3D = $CharacterBody3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#animationPlayer.play("cutscene")
	player.can_move = false
	CutsceneManager.turn_off_UI()
	await wait(2)
	CutsceneManager.turn_on_UI()
	await wait(2)
	CutsceneManager.change_text("Today I will teach you all about your future")
	await wait(5)
	player.can_move = true
	camera.current = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func wait(seconds):
	return get_tree().create_timer(seconds).timeout
