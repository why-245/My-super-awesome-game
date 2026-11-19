extends Control
class_name PickUpPrompt

@onready var player: Player = $".."
@onready var texture_rect: TextureRect = $CanvasLayer/ColorRect/TextureRect
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var text_edit: RichTextLabel = $CanvasLayer/ColorRect/TextEdit

var slot_data : SlotData
var object : Node

func _on_y_button_pressed() -> void:
	get_tree().paused = false
	canvas_layer.visible = false
	player.inventory_data.pick_up_slot_data(slot_data)
	object.queue_free()


func _on_n_button_button_down() -> void:
	get_tree().paused = false
	canvas_layer.visible = false

func on_item_pick_up(slot : SlotData, node : Node):
	slot_data = slot
	object = node
	text_edit.text = "Pick up " + slot_data.item_data.item_name
	texture_rect.texture = slot_data.item_data.icon
	canvas_layer.visible = true
	get_tree().paused = true
