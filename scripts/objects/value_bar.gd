extends TextureProgressBar

@export var icon_texture = preload("res://sprites/objects/mana.png")
@export var label_text = ""
@onready var icon = $Icon
@onready var label = $Text/Label
@onready var value_text = $Text/Value

func _ready():
	icon.texture = icon_texture
	label.text = label_text
	value_text.text = str(value) + " / " + str(max_value)

func _on_value_changed(value):
	value_text.text = str(value) + " / " + str(max_value)
