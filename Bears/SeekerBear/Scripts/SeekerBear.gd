class_name SeekerBear
extends GenericBear

onready var _torch_light_handle := $TorchLightHandle

func _ready() -> void:
	player_id = 0
	_torch_light_handle.set_visible(false)
	WALK_SPEED = 100.0
	ROULADE_SPEED = 200.0
	DIALOG_TEXTS = ["What's up bears"]
	# warning-ignore:return_value_discarded
	Events.connect("dawn_ends", self, "_switch_off_torch_light_handle")
	# warning-ignore:return_value_discarded
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
	if(Input.is_action_just_pressed("p%d_secondary_action" % player_id)):
		_talk()

func _catch() -> void:
	var overlapping_areas = hit_box.get_overlapping_areas()
	if overlapping_areas == null || overlapping_areas.size() < 1:
		return
	overlapping_areas.sort_custom(self, "_catch_compare")
	var overlapping_area = overlapping_areas.pop_front()
	if overlapping_area is HurtBox:
		overlapping_area.owner.catch()

func _catch_compare(a : Area2D, b : Area2D) -> bool:
	var keep_a := true
	var keep_b := false
	
	# If one is not a HurtBox keep the other
	# If both are not keep a
	if !(b is HurtBox):
		return keep_a
	if !(a is HurtBox):
		return keep_b
	
	# If one is the WhereBear keep it
	# If both are keep a
	if (a.owner is WhereBear):
		return keep_a
	if (b.owner is WhereBear):
		return keep_b
	
	# If one is the SeekerBear keep the other
	# If both are keep a
	if (b.owner == self):
		return keep_a
	if (a.owner == self):
		return keep_b
	
	# If one is contaminated keep it
	# If both are keep a
	if (a.owner.contaminated):
		return keep_a
	if (b.owner.contaminated):
		return keep_b
		
	return keep_a

func _switch_off_torch_light_handle() -> void:
	_torch_light_handle.set_visible(false)

func _switch_on_torch_light_handle() -> void:
	_torch_light_handle.set_visible(true)

func _talk():
	._talk()
	Events.emit_signal("seekerbear_talked")

func metamorphose() -> void:
	pass

func unmetamorphose() -> void:
	pass
