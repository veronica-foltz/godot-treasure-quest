extends Area2D

func _process(delta):
	rotation += 1.5 * delta

func _on_body_entered(body):
	if body.has_method("collect_gem"):
		body.collect_gem()
		visible = false
		$CollisionShape2D.set_deferred("disabled", true)
		$GemSound.play()
		await $GemSound.finished
		queue_free()
