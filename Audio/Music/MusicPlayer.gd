extends Node


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
	AudioServer.set_bus_effect_enabled(1,0,enabled)

func dawn():
	$AnimationPlayer.play("DawnFade")

func dusk():
	$AnimationPlayer.play_backwards("DawnFade")

func _loop_start():
	day.play()
	night.play()

func _on_Sunrise_finished():
	_loop_start()
