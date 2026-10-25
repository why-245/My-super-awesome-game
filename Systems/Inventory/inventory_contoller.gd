extends Node
class_name InventoryController
@onready var inventory_ui: Control = %InventoryUi
var open : bool = false

func make_visible():
	inventory_ui.visible = true
	open = true

func make_invisble():
	inventory_ui.visible = false
	open = false

func is_visible() -> bool:
	return open
