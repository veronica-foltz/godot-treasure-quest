extends Area2D

func _ready():

	print("BEE SCRIPT IS RUNNING")

func _process(delta):

	print("moving")
	position.x += 100 * delta
