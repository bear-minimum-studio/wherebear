# Healthy.gd
extends State

func enter(_msg := {}) -> void:
	print('Contaminated')


func update(_delta: float) -> void:
	# TODO Implement real state transition conditions
	if(owner.get_position().y < 300):
		state_machine.transition_to('Healthy')
	if(owner.get_position().y > 550):
		state_machine.transition_to('Dead')
