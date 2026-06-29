extends Control

func _on_button_pressed():
	Globals.player_health = 3
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_settings_button_pressed():
	Globals.previous_scene = "res://scenes/title_screen.tscn"
	get_tree().change_scene_to_file("res://scenes/settings_screen.tscn")
