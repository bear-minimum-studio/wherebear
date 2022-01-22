# Walk.gd
extends State

func update(delta: float) -> void:
	if(owner._roulade):
		state_machine.transition_to("Roulade")
	if(owner._input_vector == Vector2.ZERO):
		state_machine.transition_to("Idle")

func physics_update(delta: float) -> void:
	owner._velocity = owner.WALK_SPEED * owner._input_vector
