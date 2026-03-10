extends Control

func _ready() -> void:
	await CutsceneManager.wait(10)
	get_tree().change_scene_to_file("res://Scenes/thanks_screen.tscn")
