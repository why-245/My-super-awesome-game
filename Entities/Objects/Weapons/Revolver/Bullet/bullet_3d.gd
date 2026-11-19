extends Area3D

const RANGE = 55
const speed = 40
var travelled_distance = 0

func _process(delta: float) -> void:
	position += -transform.basis.z * speed * delta 
	travelled_distance += speed * delta
	if travelled_distance > RANGE:
		queue_free()
