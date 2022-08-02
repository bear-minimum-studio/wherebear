extends Node

const MASTER_BUS = 0
const MUSIC_BUS = 1
const SFX_BUS = 2

onready var sunrise := $Sunrise
onready var day := $Day
onready var night := $Night

var is_day := true


func start():
	sunrise.play()

func restart():
	stop()
	lowpass(false)
	start()

func stop():
	day.stop()
	night.stop()

func lowpass(enabled):
	AudioServer.set_bus_effect_enabled(MUSIC_BUS,0,enabled)

func dawn():
	$AnimationPlayer.play("DawnFade")

func dusk():
	$AnimationPlayer.play_backwards("DawnFade")

func _loop_start():
	day.play()
	night.play()

func _on_Sunrise_finished():
	_loop_start()
