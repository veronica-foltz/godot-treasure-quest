extends Area2D

func _on_body_entered(body):

	print("TOUCHED:", name)
	body.position = Vector2(100, 300)


func _on_bee_3_body_entered(body: Node2D):
	print("TOUCHED:", name)

	body.position = Vector2(100, 300)


func _on_bee_2_body_entered(body: Node2D):
	print("TOUCHED:", name)

	body.position = Vector2(100, 300)
