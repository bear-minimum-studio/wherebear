extends Control

var Game = preload("res://Game/Game.tscn")

func _input(event):
	if (event is InputEventJoypadButton or event is InputEventKey) and event.pressed:
		get_tree().change_scene_to(Game)
