extends Control

func _on_button_pressed():
	Globals.coins = 0
	Globals.gems = 0
	Globals.player_health = 3
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")

func _ready():
	$LeaderboardLabel.text = "Score: " + str(Globals.final_score)

func _on_save_score_button_pressed():
	var player_name = $NameInput.text
	if player_name == "":
		player_name = "Player"
	
	Globals.leaderboard.append({
		"name": player_name,
		"score": Globals.final_score
	})
	
	Globals.leaderboard.sort_custom(func(a, b): return a["score"] > b["score"])
	
	var text = "LEADERBOARD\n\n"
	
	for i in range(min(5, Globals.leaderboard.size())):
		text += str(i + 1) + ". " + Globals.leaderboard[i]["name"] + " - " + str(Globals.leaderboard[i]["score"]) + "\n"
	
	$LeaderboardLabel.text = text
