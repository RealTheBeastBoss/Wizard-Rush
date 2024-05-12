extends TextureProgressBar

@export var icon_texture = preload("res://sprites/objects/mana.png")
@onready var icon = $Icon
@onready var value_text = $Value

func _ready():
	icon.texture = icon_texture
	value_text.text = str(value) + " / " + str(max_value)

func _on_value_changed(value):
	value_text.text = str(value) + " / " + str(max_value)
