extends Control

func _ready():
	$DialogIterator.start()

func _input(event):
	if (event is InputEventJoypadButton or event is InputEventKey) and event.pressed:
		Logger.info("Going to next cutscene")
