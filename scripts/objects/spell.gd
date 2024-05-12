extends Node2D

const speed = 15
var moving_right = true

func _physics_process(delta):
	var direction = -1 if not moving_right else 1
	transform = Transform2D(0, Vector2(direction, 1), 0, Vector2(transform.get_origin().x + (direction * speed), 
		transform.get_origin().y))

func _on_body_entered(body):
	if body is TileMap:
		queue_free()

func _on_spell_screen_exited():
	queue_free()
