class_name NonPlayableBear
extends GenericBear

const POSSIBLE_DIRECTIONS := [
	Vector2.UP,
	Vector2(0.7, 0.7),
	Vector2.RIGHT,
	Vector2(-0.7, 0.7),
	Vector2.DOWN,
	Vector2(-0.7, -0.7),
	Vector2.LEFT,
	Vector2(0.7, -0.7)
]

const POSSIBLE_ACTIONS := [
	{
		"name" : "Idle",
		"possible_directions": [Vector2.ZERO],
		"min_duration": 3.0,
		"max_duration": 6.0,
		"roulade": false
	},
	{
		"name" : "Walk",
		"possible_directions": POSSIBLE_DIRECTIONS,
		"min_duration": 0.5,
		"max_duration": 3.0,
		"roulade": false
	},
	{
		"name" : "Roulade",
		"possible_directions": POSSIBLE_DIRECTIONS,
		"min_duration": 1.0,
		"max_duration": 1.0,
		"roulade": true
	}
]

onready var _action_timer := $ActionTimer
onready var _talk_reaction_timer := $TalkReactionTimer

func _ready() -> void:
	# warning-ignore:return_value_discarded
	Events.connect("seekerbear_talked", self, "_start_talk_reaction")
	
	randomize()
	_on_ActionTimer_timeout()

func _update_input_vector() -> void:
	pass

func _parse_inputs() -> void:
	pass

func _start_action_timer(min_duration: float, max_duration: float) -> void:
	_action_timer.start(min_duration + randf() * (max_duration - min_duration))

func _on_ActionTimer_timeout() -> void:
	var action = POSSIBLE_ACTIONS[randi() % POSSIBLE_ACTIONS.size()]
	_input_vector = action.possible_directions[randi() % action.possible_directions.size()]
	_roulade = action.roulade
	_start_action_timer(action.min_duration, action.max_duration)
	
func _on_TalkReactionTimer_timeout():
	_talk()

func _start_talk_reaction() -> void:
	var reaction_time = MIN_TALK_REACTION_TIME + randf() * MAX_TALK_REACTION_TIME
	_talk_reaction_timer.start(reaction_time)

func catch() -> void:
	if(contaminated):
		Events.emit_signal("contaminated_non_playable_bear_caught")
		Logger.debug("Caught")
		kill()
	else:
		Events.emit_signal("uncontaminated_non_playable_bear_caught")
		Logger.debug("Catch fail")

func contaminate() -> void:
	if(contaminated):
		return
	
	contaminated = true
	Events.emit_signal("non_playable_bear_contaminated")
	Logger.debug('Contaminated')
	metamorphose()

func decontaminate() -> void:
	if(!contaminated):
		return
	
	contaminated = false
	Logger.debug('Decontaminated')
	unmetamorphose()
