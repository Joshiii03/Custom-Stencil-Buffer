@tool
class_name Portal
extends Node3D

@export var portal_frame : StencilReader
@onready var stencil_writer_1 : StencilWriter = $StencilWriter
@onready var stencil_writer_2 : StencilWriter = $StencilWriter2

@export var stencil_layer_1 : int = -1
@export var stencil_layer_2 : int = -1

@export var player : Player:
	set(value):
		player = value
		if player and portal_frame:
			portal_frame.player = player

# The Normal of the Portal plane.
var normal : Vector3 :
	get():
		return -transform.basis.z

# Returns on which side the Player is.
# Main use is to detect if the Player switched the side.
var player_side : bool = false:
	get():
		if player != null:
			var player_coords : Vector3 = player.global_position
			var  z_coord : float = normal.dot(player_coords - global_position)  #dot(player_coords - global_position, normal );
			return z_coord < 0
		return false

# If the Player is insdie the Area3D
var player_inside : bool = false :
	set(new_value):
		if new_value:
			last_player_side = player_side
		player_inside = new_value

var last_player_side : bool = true :
	set(new_value):
		if last_player_side == null:
			last_player_side = new_value
		elif last_player_side != new_value:
			player_changed_side()
		last_player_side = new_value


func _ready():
	update_portal_layer()


func _process(_delta: float) -> void:
	last_player_side = player_side


func _on_area_3d_body_entered(body):
	if body is Player:
		player_inside = true


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body is Player:
		player_inside = false


var last_update : int = 0 

func update_portal_layer() -> void:
	var active_layer : int =  player.stencil_layer
	print("###########################")
	print("active: ", active_layer)
	if stencil_writer_1 and stencil_writer_2 and last_update < Time.get_ticks_msec() + 10:
		last_update = Time.get_ticks_msec()
		if player_inside:
			match active_layer:
				stencil_layer_1:
					if player_side:
						print("Case 1")
						stencil_writer_1.stencil_layer = stencil_layer_1
						stencil_writer_2.stencil_layer = stencil_layer_2
					else:
						print("Case 2")
						stencil_writer_1.stencil_layer = stencil_layer_2
						stencil_writer_2.stencil_layer = stencil_layer_1
				stencil_layer_2:
					if player_side:
						print("Case 3")
						stencil_writer_1.stencil_layer = stencil_layer_2
						stencil_writer_2.stencil_layer = stencil_layer_1
					else:
						print("Case 4")
						stencil_writer_1.stencil_layer = stencil_layer_1
						stencil_writer_2.stencil_layer = stencil_layer_2
		else:
			match active_layer:
				stencil_layer_1:
					stencil_writer_1.stencil_layer = stencil_layer_2
					stencil_writer_2.stencil_layer = stencil_layer_2
				stencil_layer_2:
					stencil_writer_1.stencil_layer = stencil_layer_1
					stencil_writer_2.stencil_layer = stencil_layer_1


# Is triggered when Player changes side of portal while standing inside.
# Swaps active PortalLayer
func player_changed_side():
	if  player_inside:
		match player.stencil_layer:
			stencil_layer_1:
				player.stencil_layer = stencil_layer_2
			stencil_layer_2:
				player.stencil_layer = stencil_layer_1
