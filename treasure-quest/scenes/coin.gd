extends Area2D

func _on_body_entered(body):
	if body.has_method("collect_coin"):
		body.collect_coin()
		$AnimatedSprite2D.visible = false
		$CollisionShape2D.disabled = true
		$CoinSound.play()
		await $CoinSound.finished
		queue_free()
