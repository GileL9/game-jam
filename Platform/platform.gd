extends StaticBody2D

@export var speed: float = 150.0
@export var reset_y_position: float = 600.0

# A flag to prevent the platform from moving during the teleport frame
var is_teleporting: bool = false

func _physics_process(delta: float) -> void:
	# Only move upward if we aren't currently resetting
	if not is_teleporting:
		global_position.y -= speed * delta

func teleport_down() -> void:	
	is_teleporting = true
	global_position.y = reset_y_position
	
	# Wait for 0.1 seconds to let the physics engine realize the platform moved,
	# then allow it to start moving upwards again.
	await get_tree().create_timer(0.1).timeout
	is_teleporting = false
