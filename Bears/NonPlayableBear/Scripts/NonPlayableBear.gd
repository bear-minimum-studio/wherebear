class_name NonPlayableBear
extends GenericBear

const POSSIBLE_ACTIONS := [
	"Idle",
	"Walk",
	"Roulade"
]

const POSSIBLE_WALK_DIRECTIONS := [
	Vector2.UP,
	Vector2(0.7, 0.7),
	Vector2.RIGHT,
	Vector2(-0.7, 0.7),
	Vector2.DOWN,
	Vector2(-0.7, -0.7),
	Vector2.LEFT,
	Vector2(0.7, -0.7)
]

const MAX_ACTION_TIME := 1.5
const MIN_ACTION_TIME := 0.5

onready var _action_timer := $ActionTimer

func _ready() -> void:
	randomize()
	_start_action_timer()

func _update_input_vector() -> void:
	pass

func _parse_inputs() -> void:
	pass


func _start_action_timer() -> void:
	_action_timer.start(MIN_ACTION_TIME + randf() * (MAX_ACTION_TIME - MIN_ACTION_TIME))

func _on_ActionTimer_timeout() -> void:
	var action : String = POSSIBLE_ACTIONS[randi() % POSSIBLE_ACTIONS.size()]
	match action:
		"Idle":
			_input_vector = Vector2.ZERO
			_roulade = false
		"Walk":
			_input_vector = POSSIBLE_WALK_DIRECTIONS[randi() % POSSIBLE_WALK_DIRECTIONS.size()]
			_roulade = false
		"Roulade":
			_input_vector = POSSIBLE_WALK_DIRECTIONS[randi() % POSSIBLE_WALK_DIRECTIONS.size()]
			_roulade = true
	_start_action_timer()

func catch() -> void:
	if(contaminated):
		Logger.debug("Caught")
		kill()
	else:
		Logger.debug("Catch fail")

func contaminate() -> void:
	if(contaminated):
		return
	
	contaminated = true
	Events.emit_signal("good_bear_bitten")
	Logger.debug('Contaminated')
	metamorphose()

func decontaminate() -> void:
	if(!contaminated):
		return
	
	contaminated = false
	Logger.debug('Decontaminated')
	unmetamorphose()
