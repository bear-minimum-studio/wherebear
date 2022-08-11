extends BaseMenu

onready var start_button = $VBoxContainerText/StartButton
onready var settings_button = $VBoxContainerText/SettingsButton
onready var quit_button = $VBoxContainerText/QuitButton
onready var arrow = $FocusArrow

var Intro = preload("res://UI/Intro/Intro.tscn")

onready var arrow_targets = {start_button: start_button,
							 settings_button: settings_button,
							 quit_button: quit_button}

func _ready():
	arrow.track(arrow_targets)

func _default_focus() -> void:
	if _calling_scene is SettingsMenu:
		settings_button.grab_focus()
	else:
		start_button.grab_focus()


func _on_StartButton_pressed():
	get_tree().change_scene_to(Intro)

func _on_SettingsButton_pressed():
	Settings.show_menu_from(self)

func _on_QuitButton_pressed():
	get_tree().quit()
