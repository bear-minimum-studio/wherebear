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

export var _untransformed_sprite : Texture
export var _transformed_sprite : Texture

onready var _action_timer := $ActionTimer

var contaminated := false
var metamorphosed := false

func _ready() -> void:
	randomize()
	_start_action_timer()
	_set_sprite(_untransformed_sprite)

func _update_input_vector() -> void:
	pass

func _parse_inputs() -> void:
	pass

func _update(_delta) -> void:
	# TODO Implement real conditions
	if(get_position().y < 50 || get_position().y > 550):
		pass
#		kill()
	if(get_position().y < 300):
		decontaminate()
	if(get_position().y > 300):
		contaminate()
	if(get_position().x > 512):
		metamorphose()
	if(get_position().x < 512):
		unmetamorphose()


func contaminate() -> void:
	if(contaminated):
		return
	
	contaminated = true
	Logger.debug('Contaminated')
	
func decontaminate() -> void:
	if(!contaminated):
		return
	
	contaminated = false
	Logger.debug('Decontaminated')
	unmetamorphose()


func metamorphose() -> void:
	if(metamorphosed || !contaminated):
		return
		
	metamorphosed = true
#	_set_sprite(_transformed_sprite)
	Logger.debug('Metamorphosed')

func unmetamorphose() -> void:
	if(!metamorphosed):
		return
	
	metamorphosed = false
#	_set_sprite(_untransformed_sprite)
	Logger.debug('Unmetamorphosed')

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
