# Idle.gd
extends State

func enter(_msg := {}) -> void:
	owner._velocity = Vector2.ZERO
	.enter()

func update(delta: float) -> void:
	if(owner._roulade):
		state_machine.transition_to("Roulade")
	if(owner._input_vector != Vector2.ZERO):
		state_machine.transition_to("Walk")
