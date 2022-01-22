# Healthy.gd
extends State

export var _sprite : Texture

func enter(_msg := {}) -> void:
	print('Untransformed')
	owner._set_sprite(_sprite)


func update(_delta: float) -> void:
	if(owner._health_state_machine.state.get_name() == 'Healthy'):
		pass
		
	# TODO Implement real state transition conditions based on night
	if(owner.get_position().x > 512):
		state_machine.transition_to('Transformed')
