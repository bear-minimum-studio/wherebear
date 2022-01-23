extends Node

var player_turn = 1

func swap_players():
	player_turn = 1 - player_turn

func get_werebear_player_id():
	return player_turn

func get_seeker_player_id():
	return 1 - player_turn
