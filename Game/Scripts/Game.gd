extends Node2D

func _ready():
	Events.connect("round_ended", self, "_on_round_ended")

func _on_round_ended(score):
	Logger.info("Game ended!")
	$UICanvas/ScoreDisplay.display_score(score)

	var timer = get_tree().create_timer(5.0)
	yield(timer, "timeout")
	

	PlayerTurn.swap_players()

	Logger.info("Reloading scene...")
	get_tree().reload_current_scene()
	Logger.info("Reloaded!")

