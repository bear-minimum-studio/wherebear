# Idle.gd
extends State

func enter(_msg := {}) -> void:
	owner._velocity = Vector2.ZERO

func update(_delta: float) -> void:
	if(owner._input_vector == Vector2.ZERO):
		return

	if(owner._roulade):
		state_machine.transition_to("Roulade")
	else:
		state_machine.transition_to("Walk")
