extends Node2D

var non_playable_bear_scene = preload("res://Bears/NonPlayableBear/NonPlayableBear.tscn")

func _ready():
	Logger.info('begin game')
	var toto = non_playable_bear_scene.instance()
	toto.position.x = 500
	toto.position.x = 200
	self.add_child(toto)
