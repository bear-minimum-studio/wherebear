# Healthy.gd
extends State

func enter(_msg := {}) -> void:
	print('Dead')
	owner.kill()
