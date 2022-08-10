extends BaseMenu
class_name SettingsMenu

const MASTER_BUS = MusicPlayer.MASTER_BUS
const MUSIC_BUS = MusicPlayer.MUSIC_BUS
const SFX_BUS = MusicPlayer.SFX_BUS

onready var fullscreen_checkbutton = $VBoxContainer/FullscreenCheckButton

onready var master_slider = $VBoxContainer/AudioVolumes/MasterSlider
onready var master_label = $VBoxContainer/AudioVolumes/MasterLabel

onready var music_slider = $VBoxContainer/AudioVolumes/MusicSlider
onready var music_label = $VBoxContainer/AudioVolumes/MusicLabel

onready var sfx_slider = $VBoxContainer/AudioVolumes/SFXSlider
onready var sfx_label = $VBoxContainer/AudioVolumes/SFXLabel

# using HboxContainer so that arrow can be close to return text
onready var return_button = $VBoxContainer/HBoxContainer/Return

onready var arrow = $FocusArrow

func _default_focus() -> void:
	fullscreen_checkbutton.grab_focus()

# If I understand correctly, "pause" event is not part of the control node, 
# therefore it cannot be processed by _gui_input()
# In order to stop the event from beeing processed by Pause.gd when the settings
# menu is displayed, it has to be stopped from propagating here in _input()
func _input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("pause"):
		accept_event()
	if visible and event.is_action_pressed("ui_cancel"):
		accept_event()
		_show_calling_menu()


func _on_FullscreenCheckButton_toggled(button_pressed):
	Settings.set_fullscreen(button_pressed)

func _on_MasterSlider_value_changed(value):
	if value == master_slider.min_value:
		Settings.mute_bus(MASTER_BUS,true)
	else:
		Settings.mute_bus(MASTER_BUS,false)
	Settings.set_bus_gain(MASTER_BUS,value)

func _on_MusicSlider_value_changed(value):
	if value == music_slider.min_value:
		Settings.mute_bus(MUSIC_BUS,true)
	else:
		Settings.mute_bus(MUSIC_BUS,false)
	Settings.set_bus_gain(MUSIC_BUS,value)

func _on_SFXSlider_value_changed(value):
	if value == sfx_slider.min_value:
		Settings.mute_bus(SFX_BUS,true)
	else:
		Settings.mute_bus(SFX_BUS,false)
	Settings.set_bus_gain(SFX_BUS,value)

func _on_Return_pressed():
	_show_calling_menu()

func _on_SettingsMenu_visibility_changed():
	if visible:
		_default_focus()
		fullscreen_checkbutton.pressed = Settings.get_fullscreen()
		master_slider.value = Settings.get_bus_gain(MASTER_BUS)
		music_slider.value = Settings.get_bus_gain(MUSIC_BUS)
		sfx_slider.value = Settings.get_bus_gain(SFX_BUS)


func _on_FullscreenCheckButton_focus_entered():
	arrow.focus(fullscreen_checkbutton)

func _on_MasterSlider_focus_entered():
	arrow.focus(master_label)

func _on_MusicSlider_focus_entered():
	arrow.focus(music_label)

func _on_SFXSlider_focus_entered():
	arrow.focus(sfx_label)

func _on_Return_focus_entered():
	arrow.focus(return_button)
