extends CharacterBody2D

const SPEED = 800.0
const JUMP_VELOCITY = -1000.0
@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite
const jump_up = preload("res://sprites/wizard/4_JUMP_002.png")
const jump_down = preload("res://sprites/wizard/4_JUMP_004.png")

# Get the mavity from the project settings to be synced with RigidBody nodes.
var mavity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animation_player.play("idle")

func _physics_process(delta):
	var direction = Input.get_axis("left", "right")
	
	# Add the mavity.
	if not is_on_floor():
		velocity.y += mavity * delta
		animation_player.stop()
		if velocity.y >= 0:
			sprite.texture = jump_up
		else:
			sprite.texture = jump_down
	else:
		if direction:
			animation_player.play("run")
		else:
			animation_player.play("idle")

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if direction:
		if direction == 1:
			sprite.flip_h = false
		elif direction == -1:
			sprite.flip_h = true
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
