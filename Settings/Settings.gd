extends Control

onready var settings_menu = $UICanvas/SettingsMenu

var config = ConfigFile.new()
var configPath = "user://settings.cfg"

var _fullscreen := false

# default values are stored in default_bus_layout
var buses_dict = {
	MusicPlayer.MASTER_BUS: {
		"label": "master",
		"properties": {
			"gain": AudioServer.get_bus_volume_db(MusicPlayer.MASTER_BUS),
			"muted": AudioServer.is_bus_mute(MusicPlayer.MASTER_BUS)
		}
	},
	MusicPlayer.MUSIC_BUS: {
		"label": "music",
		"properties": {
			"gain": AudioServer.get_bus_volume_db(MusicPlayer.MUSIC_BUS),
			"muted": AudioServer.is_bus_mute(MusicPlayer.MUSIC_BUS)
		}
	},
	MusicPlayer.SFX_BUS: {
		"label": "sfx",
		"properties": {
			"gain": AudioServer.get_bus_volume_db(MusicPlayer.SFX_BUS),
			"muted": AudioServer.is_bus_mute(MusicPlayer.SFX_BUS)
		}
	},	
}

func _ready():
	_load_settings()

func _save_settings() -> void:
	config.save(configPath)

func _load_settings() -> void:
	var err = config.load(configPath)
	if err == OK:
		var value = config.get_value("Settings", "fullscreen")
		if value != null:
			_fullscreen = value
		_load_buses_settings()

	set_fullscreen(_fullscreen)
	_set_buses_settings()

func _load_buses_settings() -> void:
	for bus_idx in buses_dict.keys():
		var bus = buses_dict[bus_idx]
		for property in bus.properties.keys():
			var property_label = _get_bus_property_label(bus_idx, property)
			var value = config.get_value("Settings", property_label)
			if value != null:
				bus.properties[property] = value

func _get_bus_property_label(bus_idx: int, property: String) -> String:
	return buses_dict[bus_idx].label + "_" + property

func _set_buses_settings() -> void:
	for bus_idx in buses_dict.keys():
		set_bus_gain(bus_idx, buses_dict[bus_idx].properties.gain)
		mute_bus(bus_idx, buses_dict[bus_idx].properties.muted)


func set_fullscreen(fullscreen: bool) -> void:
	_fullscreen = fullscreen
	OS.set_window_fullscreen(fullscreen)
	config.set_value("Settings", "fullscreen", _fullscreen)
	_save_settings()

func get_fullscreen() -> bool:
	return _fullscreen

func _toggle_fullscreen() -> void:
	set_fullscreen(not get_fullscreen())

func set_bus_gain(bus_idx: int, gain: float) -> void:
	AudioServer.set_bus_volume_db(bus_idx,gain)
	var property_label = _get_bus_property_label(bus_idx, "gain")
	config.set_value("Settings", property_label, get_bus_gain(bus_idx))
	_save_settings()

func get_bus_gain(bus_idx: int) -> float:
	return AudioServer.get_bus_volume_db(bus_idx)

func mute_bus(bus_idx: int, enable: bool) -> void:
	AudioServer.set_bus_mute(bus_idx, enable)
	var property_label = _get_bus_property_label(bus_idx, "muted")
	config.set_value("Settings", property_label, enable)
	_save_settings()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_fullscreen"):
		_toggle_fullscreen()

func show_menu_from(calling_scene):
	settings_menu.show_from(calling_scene)
