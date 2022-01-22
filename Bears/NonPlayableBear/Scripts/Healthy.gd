# Healthy.gd
extends State

func enter(_msg := {}) -> void:
	print('Healthy')
	owner._werebear_state_machine.transition_to('Untransformed')


func update(_delta: float) -> void:
	# TODO Implement real state transition conditions
	if(owner.get_position().y > 300):
		state_machine.transition_to('Contaminated')
	if(owner.get_position().y < 50):
		state_machine.transition_to('Dead')
