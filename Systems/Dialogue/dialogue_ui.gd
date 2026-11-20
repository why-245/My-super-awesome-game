extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func set_text_speed(text_lenght : int ):
	animation_player.speed_scale = (325 - text_lenght) / 325.0

func _ready() -> void:
	
