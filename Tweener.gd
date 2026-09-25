@tool
extends MeshInstance3D

@export var move : bool = true

func _process(_delta):
	if move:
		rotation.x += min(0.01 * (abs(sin(Time.get_ticks_usec())) + .001), 0.02)
		rotation.y += min(0.01 * (abs(cos(Time.get_ticks_usec())) + .001), 0.02)
		rotation.z += min(0.01 * (abs(tan(Time.get_ticks_usec())) + .001), 0.02)

#func _ready():
	#tween.tween_property(self, "rotation", 1, 5)
	#pass
