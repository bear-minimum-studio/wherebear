class_name GenericBear
extends KinematicBody2D

const MIN_TALK_REACTION_TIME := 0.05
const MAX_TALK_REACTION_TIME := 1.25
var WALK_SPEED := 70.0
var ROULADE_SPEED := 140.0
var DIALOG_TEXTS := [
	"Graou",
	"Coucou",
	"Youpi",
	"Hahaha",
	"Chouette",
	"Grompf",
	"Grrrrr",
	"Roar"
]

###########
# PRIVATE #
###########

onready var _sprite := $Sprite
onready var hurt_box := $HurtBox
onready var hit_box := $HitBox
onready var move_state_machine := $MoveStateMachine
onready var animation_player := $AnimationPlayer
onready var dialog_displayer := $DialogDisplayer

export var _unmetamorphosed_sprite : Texture
export var _metamorphosed_sprite : Texture

var _velocity := Vector2.ZERO
var _input_vector := Vector2.ZERO
var _roulade := false
var _is_day := true
var player_id := -1

var contaminated := false
var metamorphosed := false

func _ready() -> void:
	# warning-ignore:return_value_discarded
	Events.connect("day_starts", self, "_on_day_starts")
	# warning-ignore:return_value_discarded
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
	if Input.is_action_just_pressed("debug_2"):
		_talk()
	pass

func _update_velocity() -> void:
	_velocity = move_and_slide(_velocity)
	_sprite.set_orientation(_velocity)

func _physics_process(delta) -> void:
	_parse_inputs()
	_update_velocity()
	_update(delta)

func _on_day_starts() -> void:
	_is_day = true
	unmetamorphose()

func _on_day_ends() -> void:
	_is_day = false
	metamorphose()

func _talk() -> void:
	var picked_text = DIALOG_TEXTS[randi() % DIALOG_TEXTS.size()]
	dialog_displayer.display_text(picked_text, 4.0)

##########
# PUBLIC #
##########

func kill() -> void:
	queue_free()

func catch() -> void:
	pass

func metamorphose() -> void:
	if(metamorphosed || !contaminated || _is_day):
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

