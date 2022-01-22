extends Node2D

func set_direction(direction: Vector2):
	if direction == Vector2.ZERO:
		return

	self.rotation = direction.angle()
