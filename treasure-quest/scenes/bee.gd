extends Area2D

@export var speed = 2.0
@export var height = 50

var start_y
var time = 0.0

func _ready():
	start_y = position.y

func _process(delta):
	time += delta
	position.y = start_y + sin(time * speed) * height

func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(global_position)

func _on_bee_2_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(global_position)

func _on_bee_3_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(global_position)
