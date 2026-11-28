extends Node

#change save location!!
var save_path : String = "res://SavePathTest//save_game.res"


func _ready() -> void:
	load_game_data()

func save_game_data():
	var new_save_game : SaveGame = SaveGame.new()
	new_save_game.save_data_dict.clear()
	new_save_game.save_data_dict.merge(PlayerData.save_data)
	var error = ResourceSaver.save(new_save_game,save_path)
	if error == OK:
		print("save works!! :3")
		#future signal maybe
	else: 
		print("save don't work :(((")

func load_game_data():
	if ResourceLoader.exists(save_path):
		var loaded_data = ResourceLoader.load(save_path).duplicate(true) as SaveGame
		if loaded_data:
			PlayerData.load_save_data()
		else:
			print("no loaded data")
	else:
		print("save path missing")
