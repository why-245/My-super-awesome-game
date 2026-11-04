extends ActionData
class_name TestItemAction
@export var test_text : String = "test action"

func _init() -> void:
	action_type = ACTIONTYPE.TEST_1
