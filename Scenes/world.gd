extends Node3D
class_name World

@onready var player: Player = $Player

func _ready() -> void:
	#player.global_position = GameManager.player_position
	pass

func save_game_now():
	GameManager.player_position = player.global_position
	GameManager.save_game()
