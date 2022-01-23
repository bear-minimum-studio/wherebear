extends Node2D

const NUMBER_OF_BEARS := 3

const DAY_CYCLE_HALF_PERIOD := 5.0
const DAY_CYCLE_FADE_DURATION := 1.0
const DAY_CYCLE_DAY_DURATION := DAY_CYCLE_HALF_PERIOD - 2 * DAY_CYCLE_FADE_DURATION
const DAY_CANVAS_COLOR := Color(1, 1, 1)
const NIGHT_CANVAS_COLOR := Color(0, 0, 0)
const DAY_CYCLE_PHASES = [
	{
		# Dawn
		"name": "Dawn",
		"fade_to_color": DAY_CANVAS_COLOR,
		"duration": DAY_CYCLE_FADE_DURATION,
		"signal": "day_starts" },
	{
		# Day
		"name": "Day",
		"fade_to_color": null,
		"duration": DAY_CYCLE_DAY_DURATION,
		"signal": "dawn_ends"
	},
	{
		# Dusk
		"name": "Dusk",
		"fade_to_color": NIGHT_CANVAS_COLOR,
		"duration": DAY_CYCLE_FADE_DURATION,
		"signal": "dusk_starts"
	},
	{
		# Night
		"name": "Night",
		"fade_to_color": null,
		"duration": DAY_CYCLE_HALF_PERIOD,
		"signal": "day_ends"
	},
]

onready var spawn_zone_area = $SpawnZone/SpawnZoneShape
onready var spawn_zone = $SpawnZone
onready var canvas_modulate = $CanvasModulate
onready var day_cycle_tween = $CanvasModulate/DayCycleTween
onready var characters_container = $CharactersContainer

var non_playable_bear_scene = preload("res://Bears/NonPlayableBear/NonPlayableBear.tscn")

var _day_cycle_phase_idx := -1
var _day_cycle_phase : Dictionary = DAY_CYCLE_PHASES[_day_cycle_phase_idx]

func _ready():
	canvas_modulate.set_visible(true)
	canvas_modulate.set_color(DAY_CANVAS_COLOR)
	_next_day_cycle_phase()

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
		characters_container.add_child(new_bear)

func _fade_light(to_color: Color, duration: float) -> void:
	day_cycle_tween.interpolate_property(canvas_modulate, "color",
		canvas_modulate.get_color(), to_color, duration,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	day_cycle_tween.start()
	
func _next_day_cycle_phase() -> void:
	_day_cycle_phase_idx = (_day_cycle_phase_idx + 1) % DAY_CYCLE_PHASES.size()
	_day_cycle_phase = DAY_CYCLE_PHASES[_day_cycle_phase_idx]

	Logger.debug(_day_cycle_phase.name)
	Events.emit_signal(_day_cycle_phase.signal)
	if _day_cycle_phase.fade_to_color != null:
		_fade_light(_day_cycle_phase.fade_to_color, _day_cycle_phase.duration)
	else:
		_fade_light(canvas_modulate.get_color(), _day_cycle_phase.duration)

func _input(event) -> void:
	if event.is_action_pressed("debug_1"):
		_next_day_cycle_phase()

func _on_DayCycleTween_tween_completed(_object, _key) -> void:
	_next_day_cycle_phase()
