extends Control

onready var score_text = $VBoxContainer/Score

func update_score(score: int) -> void:
	score_text.set_text("%d" % score)

func hide() -> void:
	self.visible = false
