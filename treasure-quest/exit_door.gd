extends Area2D

@export var next_level = "res://scenes/level_2.tscn"

func _ready():

	$AnimatedSprite2D.play("closed")

func _on_body_entered(body):

	if body.name == "Player":
		$AnimatedSprite2D.play("open")
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file(next_level)
