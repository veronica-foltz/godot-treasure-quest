extends Area2D

func _on_body_entered(body):

	if body.has_method("take_damage"):
		body.take_damage(global_position)

func _on_bee_2_body_entered(body):

	if body.has_method("take_damage"):
		body.take_damage(global_position)

func _on_bee_3_body_entered(body):

	if body.has_method("take_damage"):
		body.take_damage(global_position)
