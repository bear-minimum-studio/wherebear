extends Control

onready var anim_tree = $AnimationTree
onready var dialog_iterator = $DialogIterator
onready var next_fx = $NextFX

var Tuto = preload("res://UI/Tuto/Tuto.tscn")

const STORY_1_SCREEN_INDEX = 1
const STORY_2_SCREEN_INDEX = 3

var _final_animation_complete = false
var _dialog_iterator_ended = false

func _ready():
	dialog_iterator.start()
	dialog_iterator.connect("screen_end", self, "_next_story")

func _try_to_finish_intro():
	if _final_animation_complete and _dialog_iterator_ended:
		Logger.info("Intro is finished! Starting game...")
		get_tree().change_scene_to(Tuto)

func _force_finish_intro():
	Logger.info("Intro has been skipped! Starting game...")
	get_tree().change_scene_to(Tuto)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_skip_intro"):
		_force_finish_intro()
	elif event.is_action_pressed("ui_accept"):
		Logger.debug("Going to next dialog")
		dialog_iterator.next()
		_try_to_finish_intro()


func _next_story(current_screen):
	var state_machine = anim_tree["parameters/playback"]
	next_fx.play()
	
	if current_screen == STORY_1_SCREEN_INDEX:
		state_machine.travel("Cutscene 1")
	
	if current_screen == STORY_2_SCREEN_INDEX:
		state_machine.travel("Cutscene 2")

func _on_AnimationPlayer_animation_finished():
	Logger.debug("Last animation complete")
	_final_animation_complete = true
	_try_to_finish_intro()

func _on_DialogIterator_end():
	_dialog_iterator_ended = true
	_try_to_finish_intro()

