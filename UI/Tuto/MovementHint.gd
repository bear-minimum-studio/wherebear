tool
extends HBoxContainer

export(String, "p0", "p1") var player = "p0" setget _set_player_id

onready var up_key = $KeyContainer/KeyUp
onready var left_key = $KeyContainer/KeySubContainer/KeyLeft
onready var down_key = $KeyContainer/KeySubContainer/KeyDown
onready var right_key = $KeyContainer/KeySubContainer/KeyRight

const PLAYER_0_KEYS = {
	"up": preload("res://UI/Tuto/Resources/W.png"),
	"left": preload("res://UI/Tuto/Resources/A.png"),
	"down": preload("res://UI/Tuto/Resources/S.png"),
	"right": preload("res://UI/Tuto/Resources/D.png"),
}

const PLAYER_1_KEYS = {
	"up": preload("res://UI/Tuto/Resources/I.png"),
	"left": preload("res://UI/Tuto/Resources/J.png"),
	"down": preload("res://UI/Tuto/Resources/K.png"),
	"right": preload("res://UI/Tuto/Resources/L.png"),
}

func _set_player_id(new_player_id):
	player = new_player_id
	_set_keys()

func _set_keys():
	var keys = PLAYER_0_KEYS if player == "p0" else PLAYER_1_KEYS
	
	if not is_inside_tree():
		yield(self, "ready")

	up_key.texture = keys["up"]
	left_key.texture = keys["left"]
	down_key.texture = keys["down"]
	right_key.texture = keys["right"]
