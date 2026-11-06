
class_name Animator
extends Node

signal finished

@export var autostart: bool = false
@export var loop: bool = false

var tween: Tween
var target: Node3D


func _ready() -> void:
	target = get_parent() as Node3D

	if target == null:
		push_error("Animator's parent must be a Node3D!")
		return

	if autostart:
		start()


func get_keys() -> Array[AnimatorKey]:
	var keys: Array[AnimatorKey] = []

	for child in get_children():
		if child is AnimatorKey:
			keys.append(child)

	return keys


func start() -> void:
	play_from(0)


func play_from(key_index: int) -> void:
	if target == null:
		return

	var keys := get_keys()

	if keys.is_empty():
		push_warning("Animator has no AnimatorKey children!")
		return

	if key_index < 0 or key_index >= keys.size():
		push_warning("Invalid Animator key index!")
		return

	stop()

	tween = create_tween()

	if loop:
		tween.set_loops()

	for i in range(key_index, keys.size()):
		var key := keys[i]

		# Convert key transform to target's local space.
		var target_position := key.global_position

		var target_rotation := key.global_rotation

		var transition: Tween.TransitionType
		var ease_type: Tween.EaseType = Tween.EASE_IN_OUT

		match key.easing:
			AnimatorKey.AnimationEasing.Smooth:
				transition = Tween.TRANS_SINE

			AnimatorKey.AnimationEasing.Jump:
				transition = Tween.TRANS_BOUNCE
				ease_type = Tween.EASE_OUT

			AnimatorKey.AnimationEasing.Linear:
				transition = Tween.TRANS_LINEAR

		var duration := maxf(key.time, 0.001)

		# Position animation.
		if key.animate_position:
			tween.tween_property(
				target,
				"global_position",
				target_position,
				duration
			).set_trans(transition).set_ease(ease_type)

		# Rotation animation.
		if key.animate_rotation:
			tween.tween_property(
				target,
				"global_rotation",
				target_rotation,
				duration
			).set_trans(transition).set_ease(ease_type)

	tween.finished.connect(_on_tween_finished)


func stop() -> void:
	if tween != null and tween.is_valid():
		tween.kill()

	tween = null


func pause() -> void:
	if tween != null and tween.is_running():
		tween.pause()


func resume() -> void:
	if tween != null and tween.is_valid():
		tween.play()


func restart() -> void:
	start()


func is_playing() -> bool:
	return tween != null and tween.is_running()


func _on_tween_finished() -> void:
	if not loop:
		finished.emit()
