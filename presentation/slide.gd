
@tool
class_name Slide
extends Node

@export var slide_name: String = "New Slide"
@export var comments: Array[String] = []

@export_file_path("*.tscn") var scene: String
@export var use_scene: bool = true

var new_scene: PackedScene = null
var instance: Node = null

var loading_started := false
var activation_id := 0


func prepare() -> void:
	if Engine.is_editor_hint():
		return

	if not scene or not use_scene:
		return

	if new_scene != null or loading_started:
		return

	var error = ResourceLoader.load_threaded_request(scene)

	if error == OK or error == ERR_BUSY:
		loading_started = true
	else:
		push_error("Could not start loading: " + scene)


func activate() -> void:
	if Engine.is_editor_hint() or not scene or not use_scene:
		return

	activation_id += 1
	var my_id = activation_id

	# Start loading if it hasn't already started
	prepare()

	# Wait until loading is complete
	while new_scene == null:
		# Was this activation cancelled?
		if my_id != activation_id:
			return

		var status = ResourceLoader.load_threaded_get_status(scene)

		match status:
			ResourceLoader.THREAD_LOAD_LOADED:
				new_scene = ResourceLoader.load_threaded_get(scene)
				loading_started = false

			ResourceLoader.THREAD_LOAD_FAILED:
				loading_started = false
				push_error("Failed to load slide: " + scene)
				return

			ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
				loading_started = false
				push_error("Invalid resource: " + scene)
				return

			_:
				await get_tree().process_frame

	# Check again before instantiating
	if my_id != activation_id:
		return

	instance = new_scene.instantiate()
	get_parent().add_child(instance)


func deactivate() -> void:
	# Cancel any pending activation
	activation_id += 1

	if is_instance_valid(instance):
		instance.queue_free()
		instance = null
