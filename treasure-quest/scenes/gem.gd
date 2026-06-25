extends Area2D

func _process(delta):
	rotation += 1.5 * delta

func _on_body_entered(body):

	print("Gem touched by:", body.name)
	if body.has_method("collect_gem"):
		body.collect_gem()
		queue_free()
