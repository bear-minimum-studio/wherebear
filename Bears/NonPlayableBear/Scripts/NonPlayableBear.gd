extends "res://Bears/GenericBear/Scripts/GenericBear.gd"




# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

func _update_input_vector():
	if(randf() < 0.05):
		_input_vector.x = randf() - 0.5
		_input_vector.y = randf() - 0.5

func _parse_inputs():
	if(randf() < 0.01):
		_roulade()
	._parse_inputs()
