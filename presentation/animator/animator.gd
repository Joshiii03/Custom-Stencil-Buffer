
class_name Animator
extends Node3D

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


# Collect all animation keys in scene-tree order.
func get_keys() -> Array[AnimatorKey]:
	var keys: Array[AnimatorKey] = []

	for child in get_children():
		if child is AnimatorKey:
			keys.append(child)

	return keys


# Start animation from the beginning.
func start() -> void:
	play_from(0)


# Start animation from a specific key.
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

	# Animate through all keys starting at the selected index.
	for i in range(key_index, keys.size()):
		var key := keys[i]

		# Convert key position into the target's local space.
		var target_position := (key.global_position)

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

		tween.tween_property(
			target,
			"global_position",
			target_position,
			maxf(key.time, 0.001)
		).set_trans(transition).set_ease(ease_type)

	tween.finished.connect(_on_tween_finished)


# Stop and destroy the current tween.
func stop() -> void:
	if tween != null and tween.is_valid():
		tween.kill()

	tween = null


# Pause animation.
func pause() -> void:
	if tween != null and tween.is_running():
		tween.pause()


# Resume animation.
func resume() -> void:
	if tween != null and tween.is_valid():
		tween.play()


# Restart animation.
func restart() -> void:
	start()


# Check whether animation is currently running.
func is_playing() -> bool:
	return tween != null and tween.is_running()


# Called when a non-looping animation finishes.
func _on_tween_finished() -> void:
	if not loop:
		finished.emit()
