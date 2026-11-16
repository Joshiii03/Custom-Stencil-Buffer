extends RigidBody3D

var is_near_hole : bool = false:
	set(new_value):
		is_near_hole = new_value
		if is_near_hole:
			#collision_mask = 1
			#collision_layer = 1
			set_collision_layer_value(1, false)
			set_collision_mask_value(1, false)
			set_collision_layer_value(2, true)
			set_collision_mask_value(2, true)
			#apply_impulse(Vector3(0,0.1,0))
			move_and_collide(Vector3(0,0,0))
		else:
			if position.y > -1:
				set_collision_layer_value(1, true)
				set_collision_mask_value(1, true)
				set_collision_layer_value(2, false)
				set_collision_mask_value(2, false)

func _ready():
	is_near_hole = is_near_hole

func _process(_delta):
	#move_and_collide(Vector3(0,0,0))
	if position.y < -10:
		
		queue_free.call_deferred()


func _on_timer_timeout():
	
	move_and_collide(get_velocity_at_local_position(Vector3(0,0,0)))
