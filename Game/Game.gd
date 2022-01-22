extends Node2D

const NUMBER_OF_BEARS = 3

onready var spawn_zone_area = $SpawnZone/SpawnZoneShape
onready var spawn_zone = $SpawnZone
onready var canvas_modulate = $CanvasModulate

var non_playable_bear_scene = preload("res://Bears/NonPlayableBear/NonPlayableBear.tscn")

func _ready():
	Events.emit_signal("day_starts")

	randomize()

	var square_extents = spawn_zone_area.shape.extents
	var spawn_zone_top_left_absolute_coordinates_x = (spawn_zone_area.global_position.x - square_extents.x)
	var spawn_zone_top_left_absolute_coordinates_y = (spawn_zone_area.global_position.y - square_extents.y)

	Logger.info("Spawning bears")
	for _i in range(NUMBER_OF_BEARS):
		var x = rand_range(0, square_extents.x * 2)
		var y = rand_range(0, square_extents.y * 2)

		var new_bear = non_playable_bear_scene.instance()
		new_bear.position.x = x + spawn_zone_top_left_absolute_coordinates_x
		new_bear.position.y = y + spawn_zone_top_left_absolute_coordinates_y
		self.add_child(new_bear)

func trigger_night():
	Events.emit_signal("night_starts")
	canvas_modulate.visible = true

func trigger_day():
	Events.emit_signal("day_starts")
	canvas_modulate.visible = false

func _input(event):
	if event.is_action_pressed("debug_1"):
		trigger_night()
	if event.is_action_pressed("debug_2"):
		trigger_day()
	pass
