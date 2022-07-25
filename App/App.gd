extends Control

var config = ConfigFile.new()
var configPath = "user://settings.cfg"

var _fullscreen := false

# default values are stored in default_bus_layout
var _master_gain := AudioServer.get_bus_volume_db(0)
var _music_gain := AudioServer.get_bus_volume_db(1)
var _sfx_gain := AudioServer.get_bus_volume_db(2)

func _ready():
	_load_settings()

func _save_settings() -> void:
	config.save(configPath)

func _load_settings() -> void:
	var err = config.load(configPath)
	if err == OK:
		var r = config.get_value("Settings", "fullscreen")
		if r != null:
			_fullscreen = r

		r = config.get_value("Settings", "master_gain")
		if r != null:
			_master_gain = r

		r = config.get_value("Settings", "music_gain")
		if r != null:
			_music_gain = r

		r = config.get_value("Settings", "sfx_gain")
		if r != null:
			_sfx_gain = r

	set_fullscreen(_fullscreen)
	set_master_gain(_master_gain)
	set_music_gain(_music_gain)
	set_sfx_gain(_sfx_gain)

func set_fullscreen(fullscreen: bool) -> void:
	_fullscreen = fullscreen
	OS.set_window_fullscreen(fullscreen)
	config.set_value("Settings", "fullscreen", _fullscreen)
	_save_settings()

func get_fullscreen() -> bool:
	return _fullscreen

func _toggle_fullscreen() -> void:
	set_fullscreen(not get_fullscreen())

func set_master_gain(gain: float) -> void:
	AudioServer.set_bus_volume_db(0,gain)
	config.set_value("Settings", "master_gain", get_master_gain())
	_save_settings()

func get_master_gain() -> float:
	return AudioServer.get_bus_volume_db(0)

func set_music_gain(gain: float) -> void:
	AudioServer.set_bus_volume_db(1,gain)
	config.set_value("Settings", "music_gain", get_music_gain())
	_save_settings()

func get_music_gain() -> float:
	return AudioServer.get_bus_volume_db(1)

func set_sfx_gain(gain: float) -> void:
	AudioServer.set_bus_volume_db(2,gain)
	config.set_value("Settings", "sfx_gain", get_sfx_gain())
	_save_settings()

func get_sfx_gain() -> float:
	return AudioServer.get_bus_volume_db(2)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_fullscreen"):
		_toggle_fullscreen()
