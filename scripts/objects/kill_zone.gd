extends Area2D

@export var kill_player = false

func _on_body_entered(body):
	if body is Player:
		if not kill_player:
			GameManager.damaged_player.emit()
		else:
			GameManager.transition_scene("res://scenes/menus/start_menu.tscn")
