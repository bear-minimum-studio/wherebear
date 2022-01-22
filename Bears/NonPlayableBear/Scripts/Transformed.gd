# Healthy.gd
extends State

export var _sprite : Texture

func enter(_msg := {}) -> void:
	print('Transformed')
	owner._set_sprite(_sprite)


func update(_delta: float) -> void:		
	# TODO Implement real state transition conditions based on day
	if(owner.get_position().x < 512):
		state_machine.transition_to('Untransformed')
