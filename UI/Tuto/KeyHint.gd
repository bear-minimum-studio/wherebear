tool
extends HBoxContainer

export(String, "A", "B", "X", "Y") var button = "A" setget _set_button
export(String) var label = "default" setget _set_label

const TEXTURE_MAPPING = {
	"A": preload("res://UI/Tuto/Resources/A.png"),
	"B": preload("res://UI/Tuto/Resources/B.png"),
	"X": preload("res://UI/Tuto/Resources/X.png"),
	"Y": preload("res://UI/Tuto/Resources/Y.png"),
}

func _set_button(new_button):
	button = new_button
	$KeyImage.texture = TEXTURE_MAPPING[new_button]
	
func _set_label(new_label):
	label = new_label
	$Action.text = label
