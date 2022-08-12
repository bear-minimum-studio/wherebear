extends Node2D

const NUMBER_OF_BEARS := 40

onready var score := $Score
onready var world := $World
onready var hud := $UICanvas/HUD
onready var pause_menu := $UICanvas/Pause
onready var round_end_display := $UICanvas/RoundEndDisplay

var game_ended := false

func _ready():
	score.init(NUMBER_OF_BEARS, hud)
	world.init(NUMBER_OF_BEARS)
	MusicPlayer.start()
	# warning-ignore:return_value_discarded
	Events.connect("round_ended", self, "_on_round_ended")

func _on_round_ended(score):
	Logger.info("Game ended!")
	hud.hide()
	$UICanvas/RoundEndDisplay.display_score(score)
	MusicPlayer.lowpass(true)
	var timer = get_tree().create_timer(0.5)
	yield(timer, "timeout")
	game_ended = true

func _next_round():
	PlayerTurn.swap_players()
	
	Logger.info("Reloading scene...")
	# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
	Logger.info("Reloaded!")
	MusicPlayer.restart()
	game_ended = false

func _input(event: InputEvent) -> void:
	if game_ended && event.is_action_pressed("ui_accept"):
		_next_round()


func _on_Pause_visibility_changed():
	if pause_menu.visible and round_end_display.visible:
		round_end_display.hide()
	elif not pause_menu.visible and game_ended:
		round_end_display.show()
