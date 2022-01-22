class_name GenericBear
extends KinematicBody2D

const WALK_SPEED := 40.0
const ROULADE_SPEED := 80.0

###########
# PRIVATE #
###########

onready var _sprite := $Sprite
onready var move_state_machine := $MoveStateMachine

var _velocity := Vector2.ZERO
var _input_vector := Vector2.ZERO
var _roulade := false

func _ready() -> void:
	pass

# Virtual function to override
# Used to get direction of movement
func _update_input_vector() -> void:
	pass

# Virtual function to override
# Used to handle all inputs/actions
func _parse_inputs() -> void:
	_update_input_vector()

# Virtual function to override
# Used to handle logic of the bear
func _update() -> void:
	pass

func _update_velocity() -> void:
	_velocity = move_and_slide(_velocity)
	_sprite.set_orientation(_velocity)

func _physics_process(_delta) -> void:
	_parse_inputs()
	_update_velocity()
	_update()

func _set_sprite(texture: Texture) -> void:
	_sprite.set_texture(texture)

##########
# PUBLIC #
##########

func kill():
	queue_free()
