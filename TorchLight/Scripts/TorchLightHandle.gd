extends Node2D

onready var _torch_light_cone = $TorchLightCone

func set_direction(direction: Vector2):
	if direction == Vector2.ZERO:
		return

	_torch_light_cone.set_rotation(direction.angle())
