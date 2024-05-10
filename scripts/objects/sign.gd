extends Node2D

@export var display_text : String
@export var panel_width : int
@onready var interation_area = $InterationArea
@onready var sign_panel = $SignPanel
@onready var sign_text = $SignPanel/SignMargin/SignText

func _ready():
	sign_panel.visible = false
	sign_panel.set_custom_minimum_size(Vector2(panel_width, 0))

func _process(delta):
	var bodies = interation_area.get_overlapping_bodies()
	for body in bodies:
		if body.z_index == 1 and Input.is_action_just_pressed("interact"):
			sign_text.text = display_text
			sign_panel.visible = true
