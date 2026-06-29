extends CharacterBody2D

const SPEED = 200
const JUMP_VELOCITY = -400
const GRAVITY = 900

@onready var anim = $AnimatedSprite2D

@onready var heart1 = get_tree().current_scene.get_node("CanvasLayer/Heart1")
@onready var heart2 = get_tree().current_scene.get_node("CanvasLayer/Heart2")
@onready var heart3 = get_tree().current_scene.get_node("CanvasLayer/Heart3")

@onready var coin_label = get_tree().current_scene.get_node("CanvasLayer/CoinLabel")
@onready var gem_label = get_tree().current_scene.get_node("CanvasLayer/GemLabel")

var health = Globals.player_health
var start_position = Vector2(100, 300)
var can_take_damage = true
var is_hurt = false
var facing_direction = 1

var coins = 0
var gems = 0

var mobile_left = false
var mobile_right = false
var mobile_jump = false
var mobile_crouch = false

var mobile_jump_pressed = false

func _ready():
	health = Globals.player_health
	coin_label.text = "x " + str(Globals.coins)
	gem_label.text = "x " + str(Globals.gems)
	update_hearts()

func _physics_process(delta):

	var direction = Input.get_axis("left", "right")

	if mobile_left:
		direction = -1
	elif mobile_right:
		direction = 1
	
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	if (Input.is_action_just_pressed("jump") or mobile_jump_pressed) and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$JumpSound.play()
	
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
	elif Input.is_action_pressed("crouch") or mobile_crouch:
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
	Globals.player_health = health
	update_hearts()
	print("Health:", health)
	can_take_damage = false
	is_hurt = true
	
	$HurtSound.play()
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
		Globals.player_health = 3
		update_hearts()
	await get_tree().create_timer(0.5).timeout
	is_hurt = false
	await get_tree().create_timer(0.5).timeout
	can_take_damage = true


func _on_fall_2_body_entered(body: Node2D):
	if body.has_method("take_damage"):
		body.take_damage(global_position)
		
func collect_coin():
	Globals.coins += 1
	coin_label.text = "x " + str(Globals.coins)

func collect_gem():
	Globals.gems += 1
	gem_label.text = "x " + str(Globals.gems)
	
func update_hearts():
	heart1.visible = health >= 1
	heart2.visible = health >= 2
	heart3.visible = health >= 3

func _on_settings_button_pressed():
	get_tree().change_scene_to_file("res://scenes/settings_screen.tscn")
	

func _on_left_button_button_down():
	mobile_left = true

func _on_left_button_button_up():
	mobile_left = false

func _on_right_button_button_down():
	mobile_right = true

func _on_right_button_button_up():
	mobile_right = false
	
func _on_jump_button_pressed():
	mobile_jump_pressed = true

func _on_crouch_button_button_down():
	mobile_crouch = true

func _on_crouch_button_button_up():
	mobile_crouch = false

func do_mobile_jump():
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
		$JumpSound.play()
