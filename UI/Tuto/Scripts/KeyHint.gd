tool
extends HBoxContainer

export(String, "A_button", "B_button", "X_button", "Y_button") var joy_button = "A_button" setget _set_button
export(String, "X", "C", "V", "T", "Y", "U") var keymap = "X" setget _set_key
export(String) var label = "default" setget _set_label

const JOY_TEXTURE_MAPPING = {
	"A_button": preload("res://UI/Tuto/Resources/A_button.png"),
	"B_button": preload("res://UI/Tuto/Resources/B_button.png"),
	"X_button": preload("res://UI/Tuto/Resources/X_button.png"),
	"Y_button": preload("res://UI/Tuto/Resources/Y_button.png"),
}

const KEYBOARD_TEXTURE_MAPPING = {
	"X": preload("res://UI/Tuto/Resources/X.png"),
	"C": preload("res://UI/Tuto/Resources/C.png"),
	"V": preload("res://UI/Tuto/Resources/V.png"),
	"T": preload("res://UI/Tuto/Resources/T.png"),
	"Y": preload("res://UI/Tuto/Resources/Y.png"),
	"U": preload("res://UI/Tuto/Resources/U.png"),
}

func _set_button(new_button):
	if not is_inside_tree():
		yield(self, "ready")

	joy_button = new_button
	$JoyButtonImage.texture = JOY_TEXTURE_MAPPING[new_button]

func _set_key(new_key):
	if not is_inside_tree():
		yield(self, "ready")

	keymap = new_key
	$KeyImage.texture = KEYBOARD_TEXTURE_MAPPING[new_key]

func _set_label(new_label):
	if not is_inside_tree():
		yield(self, "ready")

	label = new_label
	$Action.text = label
