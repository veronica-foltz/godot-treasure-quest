extends Area2D

@export var speed = 60
@export var distance = 120

var start_position
var direction = -1

func _ready():
	start_position = position
	$AnimatedSprite2D.flip_h = direction > 0

func _process(delta):
	position.x += speed * direction * delta
	if abs(position.x - start_position.x) >= distance:
		direction *= -1
		$AnimatedSprite2D.flip_h = direction > 0
		
func _on_body_entered(body):

	if body.has_method("take_damage"):
		body.take_damage(global_position)
