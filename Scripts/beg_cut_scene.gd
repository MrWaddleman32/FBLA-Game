extends Node3D

@onready var camera: Camera3D = $Camera3D
@onready var animationPlayer: AnimationPlayer = get_node_or_null("AnimationPlayer")
@onready var player: CharacterBody3D = $CharacterBody3D2
@onready var old_man: CharacterBody3D = $CharacterBody3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

const OLD_MAN_IDLE_PIXEL_256_TRANSPARENT = preload("uid://bju1qnrhtrtgs")
const player_sprite = preload("uid://ctj6nexb0sv5v")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#animationPlayer.play("cutscene")
	player.can_move = false
	CutsceneManager.turn_off_UI()
	await wait(2)
	CutsceneManager.turn_on_UI()
	CutsceneManager.change_sprite(player_sprite)
	CutsceneManager.change_text("Hi sir, I am growing up very quickly and I do not know what I want to do yet. Can you help me?")
	await CutsceneManager.wait(4)
	CutsceneManager.change_sprite(OLD_MAN_IDLE_PIXEL_256_TRANSPARENT)
	CutsceneManager.change_text("Yes son, I shall show you what it is like as every profession")
	await CutsceneManager.wait(3)
	animation_player.play("fade out")
	await CutsceneManager.wait(1)
	get_tree().change_scene_to_file("res://Scenes/engineering_world.tscn")



func wait(seconds):
	return get_tree().create_timer(seconds).timeout
