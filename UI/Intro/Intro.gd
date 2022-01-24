extends Control

onready var anim_tree = $AnimationTree
onready var dialog_iterator = $DialogIterator

const STORY_2_SCREEN_INDEX = 3

func _ready():
	dialog_iterator.start()
	dialog_iterator.connect("screen_end", self, "_next_story")

func _input(event):
	if (event is InputEventJoypadButton or event is InputEventKey) and event.pressed:
		Logger.info("Going to next cutscene")
		dialog_iterator.next()

func _next_story(current_screen):
	if current_screen == STORY_2_SCREEN_INDEX:
		var state_machine = anim_tree["parameters/playback"]
		state_machine.travel("Cutscene 2")
