extends Node2D

func _on_settings_button_pressed():
	Globals.previous_scene = "res://scenes/level_3.tscn"
	get_tree().change_scene_to_file("res://scenes/settings_screen.tscn")
