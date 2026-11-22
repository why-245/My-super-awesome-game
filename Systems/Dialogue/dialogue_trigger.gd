extends Node3D
class_name DialogueTrigger

@export var dialogue_texts : Array[String]
@export var name_texts : Array[String]
@export var speaker : Node3D

var current_dialogue : int = -1
var started : bool = false
