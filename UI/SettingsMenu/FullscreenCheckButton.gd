extends CheckButton

onready var font_color = self.get_color("font_color")
onready var font_color_focused = self.get_color("font_color_focus")


# by default, pressed state theme takes precedence over focused state theme
# here we want the opposite as the checked button show the focus/normal font only 
# /!\ dirty ?
func _on_FullscreenCheckButton_focus_exited():
	self.add_color_override("font_color_pressed", font_color)

func _on_FullscreenCheckButton_focus_entered():
	self.add_color_override("font_color_pressed", font_color_focused)
