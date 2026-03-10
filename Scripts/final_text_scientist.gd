extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await CutsceneManager.wait(10)
	get_tree().change_scene_to_file("res://Scenes/thanks_screen.tscn")
