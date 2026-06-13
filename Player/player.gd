extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -600.0

var continuous_movement: bool = false  # Toggle this to enable the mechanic
var last_direction: float = 0.0
var last_jump: bool = false

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction := Input.get_axis("left", "right")
	var jump_pressed := Input.is_action_just_pressed("jump")

	if continuous_movement:
		# Update last inputs only when new input is given
		if direction != 0:
			last_direction = direction
		if jump_pressed:
			last_jump = true

		# Jump: fires once per landing (auto-repeats when on floor)
		if last_jump and is_on_floor():
			velocity.y = JUMP_VELOCITY
			last_jump = false  # consume it — gravity + loop will re-trigger next landing

		# Horizontal: always use last known direction, player cannot stop
		if last_direction != 0:
			velocity.x = last_direction * SPEED
		
	else:
		# Default behavior
		if jump_pressed and is_on_floor():
			velocity.y = JUMP_VELOCITY

		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func set_while_true(val):
	continuous_movement = val
	pass
