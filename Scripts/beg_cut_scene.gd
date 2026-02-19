extends Node3D

@onready var camera: Camera3D = $Camera3D
@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
@onready var player: CharacterBody3D = $CharacterBody3D2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animationPlayer.play("cutscene")
	await get_tree().create_timer(10.0).timeout
	camera.current = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
