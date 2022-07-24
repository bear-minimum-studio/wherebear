extends Control

var fullscreen := false

func _ready():
	pass

func _toggle_fullscreen() -> void:
	fullscreen = not fullscreen
	OS.set_window_fullscreen(fullscreen)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_fullscreen"):
		_toggle_fullscreen()
