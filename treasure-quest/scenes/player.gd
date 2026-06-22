extends CharacterBody2D

const SPEED = 200

const JUMP_VELOCITY = -400

const GRAVITY = 900

@onready var anim = $AnimatedSprite2D

func _physics_process(delta):

	var direction = Input.get_axis("left", "right")
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if direction != 0:
		velocity.x = direction * SPEED
		anim.flip_h = direction < 0
	else:
		velocity.x = 0
	move_and_slide()
	if not is_on_floor():
		anim.play("jump")
	elif Input.is_action_pressed("crouch"):
		anim.play("crouch")
	elif direction != 0:
		anim.play("walk")
	else:
		anim.play("idle")
		
func _on_bee_body_entered(body):
	if body.name == "Player":
		body.position = Vector2(100, 300)


func _on_fall_body_entered(body: Node2D):
	if body.name == "Player":
		body.position = Vector2(100, 100)
