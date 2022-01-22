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

var _velocity := Vector2.ZERO
var _input_vector := Vector2.ZERO
var _roulade := false

func _ready() -> void:
	pass

# Virtual function to override
# Used to get direction of movement
func _update_input_vector() -> void:
	_input_vector = Vector2.ZERO
	
	if (Input.is_action_pressed("p1_move_left")):
		_input_vector += Vector2.LEFT
	if (Input.is_action_pressed("p1_move_right")):
		_input_vector += Vector2.RIGHT
	if (Input.is_action_pressed("p1_move_up")):
		_input_vector += Vector2.UP
	if (Input.is_action_pressed("p1_move_down")):
		_input_vector += Vector2.DOWN
	
	_input_vector = _input_vector.normalized()

# Virtual function to override
# Used to handle all inputs/actions
func _parse_inputs() -> void:
	_update_input_vector()
	
	if (Input.is_action_pressed("p1_roll")):
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

func _set_sprite(texture: Texture) -> void:
	_sprite.set_texture(texture)

##########
# PUBLIC #
##########

func kill():
	queue_free()
