extends Control

var config = ConfigFile.new()
var configPath = "user://options.cfg"

var _fullscreen := false

func _ready():
	_load_options()

func _save_options() -> void:
	config.save(configPath)

func _load_options() -> void:
	var err = config.load(configPath)
	if err == OK:
		_fullscreen = config.get_value("Options", "fullscreen")
	set_fullscreen(_fullscreen)

func set_fullscreen(fullscreen: bool) -> void:
	_fullscreen = fullscreen
	OS.set_window_fullscreen(fullscreen)
	config.set_value("Options", "fullscreen", _fullscreen)
	_save_options()

func get_fullscreen() -> bool:
	return _fullscreen

func _toggle_fullscreen() -> void:
	set_fullscreen(not get_fullscreen())

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_fullscreen"):
		_toggle_fullscreen()
