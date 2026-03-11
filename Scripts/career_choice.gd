extends Control




func _on_engineer_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/engineering_career.tscn")


func _on_medical_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/medical_career.tscn")
	


func _on_scientist_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/scientist_career.tscn")
