tool
extends HBoxContainer

export(String, "A_button", "B_button", "X_button", "Y_button") var button = "A_button" setget _set_button
export(String, "X", "C", "V", "T", "Y", "U") var keymap = "X" setget _set_key
export(String) var label = "default" setget _set_label

const TEXTURE_MAPPING = {
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
	button = new_button
	$JoyButtonImage.texture = TEXTURE_MAPPING[new_button]

func _set_key(new_key):
	print(new_key)
	keymap = new_key
	$KeyImage.texture = KEYBOARD_TEXTURE_MAPPING[new_key]
	print(keymap)

func _set_label(new_label):
	label = new_label
	$Action.text = label


