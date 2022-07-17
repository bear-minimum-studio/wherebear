class_name WhereBear
extends GenericBear

onready var bites := [$Audio/Bite, 
					 $Audio/Bite2, 
					 $Audio/Bite3,
					]

func _ready() -> void:
	player_id = PlayerTurn.get_werebear_player_id()
	contaminated = true
	metamorphose()

	Events.connect("non_playable_bear_contaminated", self, "_on_good_bite")

# Virtual function to override
# Used to handle all inputs/actions
func _parse_inputs() -> void:
	._parse_inputs()
	if(Input.is_action_just_pressed("p%d_primary_action" % player_id)):
		_bite()
	if(Input.is_action_just_pressed("p%d_secondary_action" % player_id)):
		_talk()

func _bite() -> void:
	if(!metamorphosed):
		return
	
	var overlapping_areas = hit_box.get_overlapping_areas()
	if overlapping_areas == null || overlapping_areas.size() < 1:
		return
	overlapping_areas.sort_custom(self, "_bite_compare")
	for overlapping_area in overlapping_areas:
		if(overlapping_area is HurtBox && overlapping_area.owner is NonPlayableBear):
			overlapping_area.owner.contaminate()
			break

func _bite_compare(a : Area2D, b : Area2D) -> bool:
	var keep_a := true
	var keep_b := false
	
	# If one is not a HurtBox keep the other
	# If both are not keep a
	if !(b is HurtBox):
		return keep_a
	if !(a is HurtBox):
		return keep_b
	
	# If one is not a NonPlayableBear keep the other
	# If both are not keep a
	if !(b.owner is NonPlayableBear):
		return keep_a
	if !(a.owner is NonPlayableBear):
		return keep_b
	
	# If one is the WhereBear keep the other
	# If both are keep a
	if (b.owner == self):
		return keep_a
	if (a.owner == self):
		return keep_b
	
	# If one is not contaminated keep it
	# If both are not keep a
	if !(a.owner.contaminated):
		return keep_a
	if !(b.owner.contaminated):
		return keep_b
		
	return keep_a

func _on_good_bite() -> void:
	var bite = bites[randi() % bites.size()]
	bite.set_pitch_scale(0.9 + randf()*0.2 )
	bite.play()


func catch() -> void:
	Events.emit_signal("wherebear_caught")
	Logger.debug("Caught")
	kill()
