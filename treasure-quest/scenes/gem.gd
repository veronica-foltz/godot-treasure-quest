extends Area2D

func _on_body_entered(body):

	print("Gem touched by:", body.name)
	if body.has_method("collect_gem"):
		body.collect_gem()
		queue_free()
