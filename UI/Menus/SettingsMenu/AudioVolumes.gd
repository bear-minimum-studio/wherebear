extends GridContainer

onready var master_label = $MasterLabel
onready var music_label = $MusicLabel
onready var sfx_label = $SFXLabel

const UI_theme = preload("res://UI/theme.tres")

onready var font_color = UI_theme.get_color("font_color", "Button")
onready var font_color_focused = UI_theme.get_color("font_color_focus", "Button")


func _on_MasterSlider_focus_entered():
	master_label.add_color_override("font_color", font_color_focused)

func _on_MasterSlider_focus_exited():
	master_label.add_color_override("font_color", font_color)


func _on_MusicSlider_focus_entered():
	music_label.add_color_override("font_color", font_color_focused)

func _on_MusicSlider_focus_exited():
	music_label.add_color_override("font_color", font_color)


func _on_SFXSlider_focus_entered():
	sfx_label.add_color_override("font_color", font_color_focused)

func _on_SFXSlider_focus_exited():
	sfx_label.add_color_override("font_color", font_color)
