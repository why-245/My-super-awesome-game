extends StaticBody3D

@onready var prompt_label: Label3D = %Label3D
@onready var canvas_layer: CanvasLayer = %CanvasLayer
var open : bool = false


func hide_prompt():
	prompt_label.hide()

func show_prompt():
	prompt_label.show()


func make_visible():
	canvas_layer.visible = true
	open = true

func make_invisble():
	canvas_layer.visible = false
	open = false

func interact():
	if open == false:
		make_visible() 
	else:
		make_invisble()
