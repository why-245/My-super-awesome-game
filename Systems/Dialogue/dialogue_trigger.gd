extends Node3D


@onready var player : Player = get_tree().current_scene.get_node("Player")
@onready var dialogue_ui_canvas = get_tree().current_scene.get_node("DialogueUi/CanvasLayer")
@onready var name_text : RichTextLabel = get_tree().current_scene.get_node("DialogueUI/CanvasLayer/NameText")
@onready var dialogue_text : RichTextLabel = get_tree().current_scene.get_node("DialogueUi/CanvasLayer/NameText")

@export var dialogue_texts : Array[String]
@export var name_texts : Array[String]
@export var speaker : Node3D

var current_dialogue : int = -1
var started : bool = false

func continue_dialogue():
	current_dialogue += 1
	if dialogue_ui_canvas.visible != true:
		dialogue_ui_canvas.visible = true
	dialogue_text.text = dialogue_texts[current_dialogue]
