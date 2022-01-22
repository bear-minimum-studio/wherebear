class_name WhereBear
extends GenericBear

# Virtual function to override
# Used to handle all inputs/actions
func _parse_inputs() -> void:
	._parse_inputs()
	if(Input.is_action_just_pressed("p1_contaminate")):
		_bite()

func _bite() -> void:
	var overlapping_areas = hit_box.get_overlapping_areas()
	for overlapping_area in overlapping_areas:
		if(overlapping_area is HurtBox && overlapping_area.owner is NonPlayableBear):
			overlapping_area.owner.contaminate()
			break
