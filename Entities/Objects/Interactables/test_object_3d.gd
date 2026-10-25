extends StaticBody3D

@onready var prompt_label: Label3D = %Label3D

func interact():
	print("Test")
	queue_free()
	
func hide_prompt():
	prompt_label.hide()

func show_prompt():
	prompt_label.show()
