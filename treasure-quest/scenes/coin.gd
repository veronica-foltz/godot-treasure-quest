extends Area2D

func _on_body_entered(body):
	print("Coin touched by:", body.name)
	if body.has_method("collect_coin"):
		body.collect_coin()
		queue_free()
