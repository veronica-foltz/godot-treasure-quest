extends Control

var music_on = true
var sound_on = true

func _ready():
	update_buttons()

func update_buttons():
	if music_on:
		$MusicButton.text = "Music: ON"
	else:
		$MusicButton.text = "Music: OFF"
	if sound_on:
		$SoundButton.text = "Sound: ON"
	else:
		$SoundButton.text = "Sound: OFF"

func _on_music_button_pressed():
	music_on = !music_on
	var bus_index = AudioServer.get_bus_index("Music")
	print("Music bus index:", bus_index)
	AudioServer.set_bus_mute(bus_index, not music_on)
	print("Music muted:", AudioServer.is_bus_mute(bus_index))
	update_buttons()

func _on_sound_button_pressed():
	sound_on = !sound_on
	var bus_index = AudioServer.get_bus_index("SFX")
	print("SFX bus index:", bus_index)
	AudioServer.set_bus_mute(bus_index, not sound_on)
	print("SFX muted:", AudioServer.is_bus_mute(bus_index))
	update_buttons()

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
