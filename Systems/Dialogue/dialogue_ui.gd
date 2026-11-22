extends Control
class_name DialogueUi

@onready var player: Player = get_parent()

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var dialogue_box: RichTextLabel = $CanvasLayer/DialogueText
@onready var name_box: RichTextLabel = $CanvasLayer/NameText

@onready var continue_button: Button = $CanvasLayer/ContinueButton
@onready var n_button: Button = $CanvasLayer/NButton
@onready var y_button: Button = $CanvasLayer/YButton

var dialogue_scene : DialogueTrigger
var current_dialogue : int
var dialogue_texts : Array[String]
var speaker_names : Array[String]

var speaker : StaticBody3D
var can_continue : bool = true

func start_dialogue(dialogue_trigger : DialogueTrigger , object : StaticBody3D):
	_paws()
	speaker = object
	dialogue_scene = dialogue_trigger
	dialogue_texts = dialogue_scene.dialogue_texts
	speaker_names = dialogue_scene.name_texts
	canvas_layer.visible = true
	animation_player.play("RESET")
	
	if dialogue_scene.started != true:
		dialogue_scene.current_dialogue += 1
		dialogue_scene.started = true
		_show_continue_button()
		dialogue_box.text = dialogue_texts[dialogue_scene.current_dialogue]
		_play_text_animation(dialogue_texts[dialogue_scene.current_dialogue].length())
	elif speaker.is_in_group("DialogueObject"):
		object_dialogue()

func object_dialogue():
	if speaker.get_node("InteractionComponent").inventory_check(player.inventory_data) == true:
		can_continue = true

func continue_dialogue():
	
	dialogue_scene.current_dialogue += 1
	
	if dialogue_scene.current_dialogue == 2:
		_show_y_n_buttons()
		
	dialogue_box.text = dialogue_texts[dialogue_scene.current_dialogue]
	_play_text_animation(dialogue_texts[dialogue_scene.current_dialogue].length())
	can_continue = false

func exit_dialogue():
	canvas_layer.visible = false
	_paws()

func _on_continue_button_pressed() -> void:
	if can_continue == true:
		continue_dialogue()
	else:
		exit_dialogue()

func _on_y_button_pressed():
	dialogue_scene.current_dialogue += 1
	speaker.get_node("InteractionComponent").interact(player.inventory_data)
	dialogue_box.text = dialogue_texts[dialogue_scene.current_dialogue]
	_play_text_animation(dialogue_texts[dialogue_scene.current_dialogue].length())
	can_continue = false
	_show_continue_button()

func _on_n_button_pressed() -> void:
	exit_dialogue()

func _show_y_n_buttons():
	n_button.disabled = false 
	n_button.visible = true
	y_button.disabled = false
	y_button.visible = true
	continue_button.disabled = true
	continue_button.visible = false

func _show_continue_button():
	n_button.disabled = true 
	n_button.visible = false
	y_button.disabled = true
	y_button.visible = false
	continue_button.disabled = false
	continue_button.visible = true

func _play_text_animation(text_length : int):
	_set_text_speed(text_length)
	animation_player.play("RESET")
	animation_player.play("text_animation")

func _set_text_speed(text_length : int):
	var max_length = 325.0
	animation_player.speed_scale = (max_length - text_length)/ max_length

func _paws():
	if get_tree().paused != true:
		get_tree().paused = true
	else: 
		get_tree().paused = false
