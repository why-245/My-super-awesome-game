extends Node
class_name InventoryController
@onready var inventory_ui: Control = %inventory_ui
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func make_visible():
	inventory_ui.visible = true
