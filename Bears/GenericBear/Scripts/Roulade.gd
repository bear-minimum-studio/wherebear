# Roulade.gd
extends State

const ROULADE_TIME := 0.3

onready var _roulade_timer := $RouladeTimer

var roulade_direction := Vector2.ZERO

func enter(_msg := {}) -> void:
	_roulade_timer.start(ROULADE_TIME)
	_update_roulade_vector()
	.enter()

func physics_update(delta: float) -> void:
	owner._velocity = owner.ROULADE_SPEED * roulade_direction

func _update_roulade_vector() ->  void:
	if(owner._input_vector != Vector2.ZERO):
		roulade_direction = owner._input_vector.normalized()
	elif(owner._velocity != Vector2.ZERO):
		roulade_direction = owner._velocity.normalized()
	else:
		state_machine.transition_to("Idle")

func _on_RouladeTimer_timeout():
	if(owner._input_vector == Vector2.ZERO):
		state_machine.transition_to("Idle")
	if(owner._input_vector != Vector2.ZERO):
		state_machine.transition_to("Walk")
