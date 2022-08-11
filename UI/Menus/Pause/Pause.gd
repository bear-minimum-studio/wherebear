extends BaseMenu

onready var resume_button = $VBoxContainerText/ResumeButton
onready var settings_button = $VBoxContainerText/SettingsButton
onready var quit_button = $VBoxContainerText/QuitButton
onready var arrow = $FocusArrow

onready var arrow_targets = {resume_button: resume_button,
							 settings_button: settings_button,
							 quit_button: quit_button}

var _paused := false


func _ready():
	arrow.track(arrow_targets)

func _toggle_pause() -> void:
	_paused = not _paused
	get_tree().paused = _paused
	if self.visible:
		self.hide()
	else:
		self.show_from(self)


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
