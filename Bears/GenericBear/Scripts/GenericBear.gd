class_name GenericBear
extends KinematicBody2D

const WALK_SPEED := 70.0
const ROULADE_SPEED := 140.0

###########
# PRIVATE #
###########

onready var _sprite := $Sprite
onready var hurt_box := $HurtBox
onready var hit_box := $HitBox
onready var move_state_machine := $MoveStateMachine
onready var animation_player := $AnimationPlayer

export var _unmetamorphosed_sprite : Texture
export var _metamorphosed_sprite : Texture

var _velocity := Vector2.ZERO
var _input_vector := Vector2.ZERO
var _roulade := false
var player_id := -1

var contaminated := false
var metamorphosed := false

func _ready() -> void:
	Events.connect("day_starts", self, "_on_day_starts")
	Events.connect("day_ends", self, "_on_day_ends")

# Virtual function to override
# Used to get direction of movement
func _update_input_vector() -> void:
	_input_vector = Vector2.ZERO
	
	if (Input.is_action_pressed("p%d_move_left" % player_id)):
		_input_vector += Vector2.LEFT
	if (Input.is_action_pressed("p%d_move_right" % player_id)):
		_input_vector += Vector2.RIGHT
	if (Input.is_action_pressed("p%d_move_up" % player_id)):
		_input_vector += Vector2.UP
	if (Input.is_action_pressed("p%d_move_down" % player_id)):
		_input_vector += Vector2.DOWN
	
	_input_vector = _input_vector.normalized()

# Virtual function to override
# Used to handle all inputs/actions
func _parse_inputs() -> void:
	_update_input_vector()
	
	if (Input.is_action_pressed("p%d_roll" % player_id)):
		_roulade = true
	else:
		_roulade = false


# Virtual function to override
# Used to handle logic of the bear
func _update(_delta) -> void:
	pass

func _update_velocity() -> void:
	_velocity = move_and_slide(_velocity)
	_sprite.set_orientation(_velocity)

func _physics_process(delta) -> void:
	_parse_inputs()
	_update_velocity()
	_update(delta)

func _on_day_starts() -> void:
	unmetamorphose()

func _on_day_ends() -> void:
	metamorphose()

##########
# PUBLIC #
##########

func kill() -> void:
	queue_free()


func metamorphose() -> void:
	if(metamorphosed || !contaminated):
		return
		
	metamorphosed = true
	_sprite.set_texture(_metamorphosed_sprite)
	Logger.debug('Metamorphosed')

func unmetamorphose() -> void:
	if(!metamorphosed):
		return
	
	metamorphosed = false
	_sprite.set_texture(_unmetamorphosed_sprite)
	Logger.debug('Unmetamorphosed')
