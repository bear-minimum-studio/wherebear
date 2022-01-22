extends GenericBear

onready var _health_state_machine = $HealthStateMachine
onready var _werebear_state_machine = $WerebearStateMachine

func _ready() -> void:
	randomize()

func _update_input_vector() -> void:
	if(randf() < 0.05):
		_input_vector.x = randf() - 0.5
		_input_vector.y = randf() - 0.5

func _parse_inputs() -> void:
	if(randf() < 0.01):
		_roulade()
	._parse_inputs()
