class_name AnimatorKey
extends Marker3D

enum AnimationEasing {
	Smooth,
	Jump,
	Linear
}

@export_group("Animation")
@export var time: float = 1.0
@export var easing: AnimationEasing = AnimationEasing.Smooth

@export_group("Position")
@export var animate_position: bool = true

@export_group("Rotation")
@export var animate_rotation: bool = false
