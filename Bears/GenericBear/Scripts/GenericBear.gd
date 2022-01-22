class_name GenericBear
extends KinematicBody2D

const MOOVEMENT_SPEED := 150.0

###########
# PRIVATE #
###########

onready var _sprite = $Sprite

var _velocity := Vector2.ZERO
var _input_vector := Vector2.ZERO

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

func _update_velocity() -> void:
	_velocity = MOOVEMENT_SPEED * _input_vector
	_velocity = move_and_slide(_velocity)

func _physics_process(_delta) -> void:
	_parse_inputs()
	_update_velocity()
	
	_sprite.set_orientation(_velocity.x)

func _roulade() -> void:
	# TODO implement real roulade mekanixXxXXx
	print('roulade')

func _set_sprite(texture: Texture) -> void:
	_sprite.set_texture(texture)

##########
# PUBLIC #
##########

func kill():
	queue_free()
