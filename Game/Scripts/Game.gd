extends Node2D

func _ready():
	Events.connect("round_ended", self, "_on_round_ended")

func _on_round_ended(score):
	$UICanvas/ScoreDisplay.display_score(score)
