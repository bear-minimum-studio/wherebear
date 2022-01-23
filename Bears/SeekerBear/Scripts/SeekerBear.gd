class_name SeekerBear
extends GenericBear

onready var _torch_light_handle := $TorchLightHandle

func _ready() -> void:
	player_id = 0
	Events.connect("dawn_ends", self, "_switch_off_torch_light_handle")
	Events.connect("dusk_starts", self, "_switch_on_torch_light_handle")

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

func _switch_off_torch_light_handle() -> void:
	_torch_light_handle.set_visible(false)

func _switch_on_torch_light_handle() -> void:
	_torch_light_handle.set_visible(true)


func contaminate() -> void:
	pass

func decontaminate() -> void:
	pass


func metamorphose() -> void:
	pass

func unmetamorphose() -> void:
	pass
