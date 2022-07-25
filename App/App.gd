extends Control

var config = ConfigFile.new()
var configPath = "user://options.cfg"

var _fullscreen := false

# default values are stored in default_bus_layout
var _master_gain : float
var _music_gain : float
var _sfx_gain : float

func _ready():
	_load_options()

func _save_options() -> void:
	config.save(configPath)

func _load_options() -> void:
	var err = config.load(configPath)
	if err == OK:
		var r = config.get_value("Options", "fullscreen")
		if r != null:
			_fullscreen = r

		r = config.get_value("Options", "master_gain")
		if r != null:
			_master_gain = r
		else:
			_master_gain = get_master_gain()

		r = config.get_value("Options", "music_gain")
		if r != null:
			_music_gain = r
		else:
			_music_gain = get_music_gain()

		r = config.get_value("Options", "sfx_gain")
		if r != null:
			_sfx_gain = r
		else:
			_sfx_gain = get_sfx_gain()

	set_fullscreen(_fullscreen)
	set_master_gain(_master_gain)
	set_music_gain(_music_gain)
	set_sfx_gain(_sfx_gain)

func set_fullscreen(fullscreen: bool) -> void:
	_fullscreen = fullscreen
	OS.set_window_fullscreen(fullscreen)
	config.set_value("Options", "fullscreen", _fullscreen)
	_save_options()

func get_fullscreen() -> bool:
	return _fullscreen

func _toggle_fullscreen() -> void:
	set_fullscreen(not get_fullscreen())

func set_master_gain(gain: float) -> void:
	AudioServer.set_bus_volume_db(0,gain)
	config.set_value("Options", "master_gain", get_master_gain())
	_save_options()

func get_master_gain() -> float:
	return AudioServer.get_bus_volume_db(0)

func set_music_gain(gain: float) -> void:
	AudioServer.set_bus_volume_db(1,gain)
	config.set_value("Options", "music_gain", get_music_gain())
	_save_options()

func get_music_gain() -> float:
	return AudioServer.get_bus_volume_db(1)

func set_sfx_gain(gain: float) -> void:
	AudioServer.set_bus_volume_db(2,gain)
	config.set_value("Options", "sfx_gain", get_sfx_gain())
	_save_options()

func get_sfx_gain() -> float:
	return AudioServer.get_bus_volume_db(2)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_fullscreen"):
		_toggle_fullscreen()
