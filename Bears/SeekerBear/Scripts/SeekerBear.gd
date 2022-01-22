class_name SeekerBear
extends GenericBear

onready var _torch_light_handle := $TorchLightHandle

func _update(_delta) -> void:
	if (_torch_light_handle):
		_torch_light_handle.set_direction(_input_vector)
	._update(_delta)
