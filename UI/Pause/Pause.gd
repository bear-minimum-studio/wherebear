extends Control

onready var resume_button = $CenterContainer/VBoxContainer/ResumeButton
onready var settings_button = $CenterContainer/VBoxContainer/SettingsButton

var _paused := false
var _calling_scene

func _ready():
	pass

func _toggle_pause() -> void:
	_paused = not _paused
	get_tree().paused = _paused
	if self.visible:
		self.hide()
	else:
		self.show_from(self)

func show_from(calling_scene):
	self._calling_scene = calling_scene
	self.visible = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		_toggle_pause()

func _default_focus():
	if _calling_scene is SettingsMenu:
		settings_button.grab_focus()
	else:
		resume_button.grab_focus()

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_ResumeButton_pressed():
	_toggle_pause()

func _on_SettingsButton_pressed():
	Settings.show_menu_from(self)

func _on_PauseMenu_visibility_changed():
	if visible:
		_default_focus()
