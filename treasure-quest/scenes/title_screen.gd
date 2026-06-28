extends Control

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_settings_button_pressed():
	get_tree().change_scene_to_file("res://scenes/settings_screen.tscn")
