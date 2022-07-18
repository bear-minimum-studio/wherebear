extends Control

onready var score_text = $VBoxContainer/Score

func display_score(score: int) -> void:
	self.visible = true
	score_text.set_text("%d" % score)
