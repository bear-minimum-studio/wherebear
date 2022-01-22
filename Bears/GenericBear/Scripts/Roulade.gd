# Roulade.gd
extends State

const ROULADE_DURATION := 0.3
const ROULADE_COOLDOWN := 1.0

onready var _roulade_duration_timer := $RouladeDurationTimer
onready var _roulade_cooldown_timer := $RouladeCooldownTimer

onready var _owner_orignal_scale : Vector2 = owner.get_scale()

var _roulade_direction := Vector2.ZERO
var _roulade_on_cooldown := false

func enter(_msg := {}) -> void:
	if(_roulade_on_cooldown):
		_transition_to_next_state()
		return
	
	_roulade_on_cooldown = true
	_roulade_duration_timer.start(ROULADE_DURATION)
	_update_roulade_vector()
	owner.set_scale(Vector2(1.0, 0.5))

func physics_update(_delta: float) -> void:
	owner._velocity = owner.ROULADE_SPEED * _roulade_direction

func exit() -> void:
	owner.set_scale(_owner_orignal_scale)

func _update_roulade_vector() ->  void:
	if(owner._input_vector != Vector2.ZERO):
		_roulade_direction = owner._input_vector.normalized()
	elif(owner._velocity != Vector2.ZERO):
		_roulade_direction = owner._velocity.normalized()
	else:
		state_machine.transition_to("Idle")

func _transition_to_next_state() -> void:
	if(owner._input_vector == Vector2.ZERO):
		state_machine.transition_to("Idle")
	if(owner._input_vector != Vector2.ZERO):
		state_machine.transition_to("Walk")

func _on_RouladeDurationTimer_timeout() -> void:
	_roulade_cooldown_timer.start(ROULADE_COOLDOWN)
	_transition_to_next_state()

func _on_RouladeCooldownTimer_timeout():
	_roulade_on_cooldown = false
