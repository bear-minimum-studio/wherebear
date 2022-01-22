extends KinematicBody2D

const MOOVEMENT_SPEED := 150.0

###########
# PRIVATE #
###########

onready var _sprite = $Sprite

var _velocity := Vector2.ZERO
var _input_vector := Vector2.ZERO

func _ready():
	pass

func _update_input_vector():
	pass

func _parse_inputs():
	_update_input_vector()
	pass

func _update_velocity():
	_velocity = MOOVEMENT_SPEED * _input_vector
	_velocity = move_and_slide(_velocity)

func _physics_process(_delta):
	_parse_inputs()
	_update_velocity()
	
	_sprite.set_orientation(_velocity.x)

func _roulade():
	print('roulade')

##########
# PUBLIC #
##########

func kill():
	queue_free()
