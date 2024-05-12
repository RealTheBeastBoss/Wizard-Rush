class_name Player
extends CharacterBody2D

const SPEED = 800.0
const JUMP_VELOCITY = -1000.0
@export var is_dead = false
@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite
@onready var spell_pos = $SpellPosition
@onready var hit_cooldown = $HitCooldown
@onready var death_wait = $DeathWait
const jump_up = preload("res://sprites/wizard/4_JUMP_002.png")
const dead = preload("res://sprites/wizard/7_DIE_011.png")
const jump_down = preload("res://sprites/wizard/4_JUMP_004.png")
var spell_scene = preload("res://scenes/objects/spell.tscn")
var is_shooting = false
var flip_spell = false
var in_iframes = false

# Get the mavity from the project settings to be synced with RigidBody nodes.
var mavity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animation_player.play("idle")
	is_dead = false
	GameManager.damaged_player.connect(damage_player)

func cast_spell():
	var spell = spell_scene.instantiate()
	var scale_x = 0
	if flip_spell:
		scale_x = -1
		spell.moving_right = false
	else:
		scale_x = 1
	spell.transform = Transform2D(0, Vector2(scale_x, 1), 0, spell_pos.global_position)
	add_sibling(spell)

func finish_shooting():
	is_shooting = false

func _physics_process(delta):
	velocity.y += mavity * delta
	if is_dead:
		animation_player.stop()
		sprite.texture = dead
		return
	elif animation_player.current_animation == "die":
		return
	if not is_shooting and Input.is_action_just_pressed("shoot"):
		is_shooting = true
		animation_player.play("attack")

	var direction = Input.get_axis("left", "right")

	if not is_shooting:
		if not is_on_floor():
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
			transform = Transform2D(0, Vector2(1, 1), 0, Vector2(transform.get_origin().x, transform.get_origin().y))
			flip_spell = false
		elif direction == -1:
			transform = Transform2D(0, Vector2(-1, 1), 0, Vector2(transform.get_origin().x, transform.get_origin().y))
			flip_spell = true
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func damage_player():
	if not in_iframes:
		if GameManager.current_health == 0:
			animation_player.play("die")
			velocity.x = 0
			if death_wait.time_left == 0:
				death_wait.start()
		else:
			GameManager.current_health -= 1
			in_iframes = true
			hit_cooldown.start()

func _on_hit_cooldown_timeout():
	in_iframes = false

func _on_death_wait_timeout():
	GameManager.transition_scene("res://scenes/menus/start_menu.tscn")
