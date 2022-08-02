extends Control
class_name SettingsMenu

onready var fullscreen_checkbutton = $VBoxContainer/FullscreenCheckButton
onready var master_slider = $VBoxContainer/AudioVolumes/MasterSlider
onready var music_slider = $VBoxContainer/AudioVolumes/MusicSlider
onready var sfx_slider = $VBoxContainer/AudioVolumes/SFXSlider

var _calling_scene = null

func show_from(calling_scene):
	visible = true
	calling_scene.visible = false
	self._calling_scene = calling_scene

func _show_calling_menu() -> void:
	visible = false
	if _calling_scene != null:
		_calling_scene.show_from(self)




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
	Settings.set_master_gain(value)

func _on_MusicSlider_value_changed(value):
	Settings.set_music_gain(value)

func _on_SFXSlider_value_changed(value):
	Settings.set_sfx_gain(value)

func _on_Return_pressed():
	_show_calling_menu()

func _on_SettingsMenu_visibility_changed():
	if visible:
		fullscreen_checkbutton.grab_focus()
		fullscreen_checkbutton.pressed = Settings.get_fullscreen()
		master_slider.value = Settings.get_master_gain()
		music_slider.value = Settings.get_music_gain()
		sfx_slider.value = Settings.get_sfx_gain()
