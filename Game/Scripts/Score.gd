extends Node

const CONTAMINATION_POINTS := 2
const CONTAMINATED_CATCH_POINTS := -1
const UNCONTAMINATED_CATCH_POINTS := 1

var _score := 0
var _number_of_bears: int
var _hud : Control

func _ready() -> void:
	# warning-ignore:return_value_discarded
	Events.connect("contaminated_non_playable_bear_caught", self, "_on_contaminated_non_playable_bear_caught")
	# warning-ignore:return_value_discarded
	Events.connect("uncontaminated_non_playable_bear_caught", self, "_on_uncontaminated_non_playable_bear_caught")
	# warning-ignore:return_value_discarded
	Events.connect("wherebear_caught", self, "_on_wherebear_caught")
	# warning-ignore:return_value_discarded
	Events.connect("non_playable_bear_contaminated", self, "_on_non_playable_bear_contaminated")

func init(number_of_bears: int, hud: Control):
	_number_of_bears = number_of_bears
	_hud = hud
	print_score()

func print_score() -> void:
	_hud.update_score(_score)
	Logger.debug("Score: %d" % _score)

func _update_number_of_bears() -> void:
	_number_of_bears -= 1
	if _number_of_bears < 1:
		_round_ending()

func _round_ending() -> void:
	Events.emit_signal("round_ended", _score)
	Logger.debug("ROUND ENDED")
	print_score()

func _on_contaminated_non_playable_bear_caught() -> void:
	_score += CONTAMINATED_CATCH_POINTS
	print_score()

func _on_uncontaminated_non_playable_bear_caught() -> void:
	_score += UNCONTAMINATED_CATCH_POINTS
	print_score()

func _on_wherebear_caught() -> void:
	_round_ending()

func _on_non_playable_bear_contaminated() -> void:
	_score += CONTAMINATION_POINTS
	_update_number_of_bears()
	print_score()
