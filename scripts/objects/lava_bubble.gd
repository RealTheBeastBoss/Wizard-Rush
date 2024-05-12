extends Node2D

@export var speed = 5
@onready var animation_player = $AnimationPlayer
@onready var timer = $Timer
@onready var sprite = $Sprite
@onready var screen = $Screen
var is_paused = false
@export var moving_down = false

func _ready():
	var random = RandomNumberGenerator.new()
	random.randomize()
	sprite.visible = false
	timer.wait_time = randi_range(1, 3)
	timer.start()

func _physics_process(delta):
	if timer.paused and screen.is_on_screen():
		timer.paused = false
		if is_paused:
			animation_player.play()
	if not screen.is_on_screen() and not timer.paused:
		timer.paused = true
		if animation_player.is_playing(): 
			animation_player.pause()
			is_paused = true
	
	if not timer.paused:
		if animation_player.current_animation == "lava_up":
			transform = Transform2D(0, Vector2(4, 4), 0, Vector2(transform.get_origin().x, 
				transform.get_origin().y - speed))
		elif moving_down:
			transform = Transform2D(0, Vector2(4, 4), 0, Vector2(transform.get_origin().x, 
				transform.get_origin().y + speed))

func drop_lava():
	animation_player.play("lava_down")

func lava_end():
	animation_player.stop()
	timer.start()
	sprite.frame = 37
	sprite.visible = false

func _on_cooldown_finish():
	sprite.visible = true
	animation_player.play("lava_up")
