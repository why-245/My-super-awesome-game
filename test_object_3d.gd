extends StaticBody3D

@onready var prompt_label: Label3D = %Label3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
func interact():
	print("Test")
	queue_free()
	
func hide_prompt():
	prompt_label.hide()

func show_prompt():
	prompt_label.show()
