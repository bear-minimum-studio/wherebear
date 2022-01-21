extends KinematicBody2D

onready var sprite = $Sprite

var velocity := Vector2.ZERO
var input_vector := Vector2.ZERO

const MOOVEMENT_SPEED := 50.0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

func _update_input_vector():
	input_vector.x = randf() - 0.5
	input_vector.y = randf() - 0.5
	input_vector = input_vector.normalized()

func _physics_process(_delta):
	_update_input_vector()
	print(input_vector)
	
	velocity = MOOVEMENT_SPEED * input_vector
	velocity = move_and_slide(velocity)
	
	sprite.set_orientation(velocity.x)
