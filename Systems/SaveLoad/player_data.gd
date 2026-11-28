extends Node

var save_data = {}
var test_gun_ammo_count : int = 6
var player_pos : Vector3

func _ready() -> void:
	save_player_data()

func save_player_data():
	save_data = {
		"test_gun_ammo_count" : test_gun_ammo_count,
		"player_pos" : player_pos
	}

func load_save_data():
	print(save_data)
