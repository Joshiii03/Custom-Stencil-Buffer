
class_name AnimatorKey
extends Marker3D

enum AnimationEasing {
	Smooth,
	Jump,
	Linear
}

@export var time: float = 1.0
@export var easing: AnimationEasing = AnimationEasing.Smooth
