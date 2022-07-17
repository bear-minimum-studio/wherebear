extends Node


onready var sunrise = $Sunrise
onready var day = $Day
onready var night = $Night
onready var is_day = true

func _ready():
	start()

func start():
	sunrise.play()

func restart():
	stop()
	start()

func stop():
	day.stop()
	night.stop()

func dawn():
	$AnimationPlayer.play("DawnFade")

func dusk():
	$AnimationPlayer.play_backwards("DawnFade")

func _loop_start():
	day.play()
	night.play()

func _on_Sunrise_finished():
	_loop_start()
