extends Node2D

@export var mana = 1

func _on_body_entered(body):
	if body is Player:
		GameManager.current_mana += mana
		GameManager.added_mana.emit()
		queue_free()
