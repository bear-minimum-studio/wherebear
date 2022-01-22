# Walk.gd
extends State

func enter(_msg := {}) -> void:
	owner.animation_player.play("Walk")

func update(_delta: float) -> void:
	if(owner._roulade):
		state_machine.transition_to("Roulade")
	if(owner._input_vector == Vector2.ZERO):
		state_machine.transition_to("Idle")

func physics_update(_delta: float) -> void:
	owner._velocity = owner.WALK_SPEED * owner._input_vector
