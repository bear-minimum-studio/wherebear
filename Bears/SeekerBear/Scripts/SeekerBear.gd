class_name SeekerBear
extends GenericBear

onready var _torch_light_handle := $TorchLightHandle

func _ready() -> void:
	player_id = 0

	Events.connect("day_starts", self, "_on_day_start")
	Events.connect("night_starts", self, "_on_night_start")

func _update(_delta) -> void:
	if (_torch_light_handle):
		_torch_light_handle.set_direction(_input_vector)
	._update(_delta)

# Virtual function to override
# Used to handle all inputs/actions
func _parse_inputs() -> void:
	._parse_inputs()
	if(Input.is_action_just_pressed("p%d_primary_action" % player_id)):
		_catch()

func _catch() -> void:
	var overlapping_areas = hit_box.get_overlapping_areas()
	for overlapping_area in overlapping_areas:
		if(overlapping_area is HurtBox && overlapping_area.owner is WhereBear):
			overlapping_area.owner.catch()
			break

func _on_day_start():
	_torch_light_handle.visible = false

func _on_night_start():
	_torch_light_handle.visible = true
