extends CharacterBody2D

const SPEED = 200
const JUMP_VELOCITY = -400
const GRAVITY = 900

@onready var anim = $AnimatedSprite2D
@onready var health_bar = get_tree().current_scene.get_node("CanvasLayer/HealthBar")

@onready var coin_label = get_tree().current_scene.get_node("CanvasLayer/CoinLabel")
@onready var gem_label = get_tree().current_scene.get_node("CanvasLayer/GemLabel")

var health = 3
var start_position = Vector2(100, 300)
var can_take_damage = true
var is_hurt = false
var facing_direction = 1

var coins = 0
var gems = 0

func _physics_process(delta):

	var direction = Input.get_axis("left", "right")
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if is_hurt:
		move_and_slide()
		return
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
		
func take_damage(enemy_position):
	
	if can_take_damage == false:
		return
	health -= 1
	health_bar.value = health
	print("Health:", health)
	can_take_damage = false
	is_hurt = true
# Knockback away from enemy

	if enemy_position.x < global_position.x:
		velocity.x = 200
	else:
		velocity.x = -200
	velocity.y = -250
	# Play hurt animation
	$AnimatedSprite2D.play("hurt")
	# Update health bar
	#health_bar.value = health
	# Check if dead
	if health <= 0:
		position = Vector2(100, 300)
		health = 3
		health_bar.value = health
	await get_tree().create_timer(0.5).timeout
	is_hurt = false
	await get_tree().create_timer(0.5).timeout
	can_take_damage = true


func _on_fall_2_body_entered(body: Node2D):
	if body.has_method("take_damage"):
		body.take_damage(global_position)
		
func collect_coin():
	coins += 1
	print("Coins:", coins)
	coin_label.text = "Coins: " + str(coins)

func collect_gem():
	gems += 1
	print("Gems:", gems)
	gem_label.text = "Gems: " + str(gems)
