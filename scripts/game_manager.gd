extends Node2D

@onready var animation_player = $AnimationPlayer
var next_scene = null

func change_scene():
	get_tree().change_scene_to_file(next_scene)

# Global Variables:
var signs_read = 0
var current_mana = 0
var current_health = 1

# Signals:
signal added_mana
signal damaged_player

# Functions:
func transition_scene(scene):
	next_scene = scene
	animation_player.play("slide")
