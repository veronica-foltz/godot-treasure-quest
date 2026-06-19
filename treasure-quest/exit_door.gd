extends Area2D

@export var next_level = "res://scenes/level_3.tscn"

func _ready():

	$AnimatedSprite2D.frame = 0

func _on_body_entered(body):

	if body.name == "Player":
		print("DOOR TOUCHED:", body.name)
		$AnimatedSprite2D.frame = 1
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file(next_level)
