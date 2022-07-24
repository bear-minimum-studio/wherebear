extends Control

var Game = preload("res://Game/Game.tscn")

func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene_to(Game)
