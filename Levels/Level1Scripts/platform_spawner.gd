extends Node2D

@onready var spawn_points = $Markers
@onready var plat_scene = preload("res://Levels/Level1Scripts/windows_not_resp_platform.tscn")
@onready var label = $"../UI/Label"
@onready var player = $"../Player"
@onready var errorSFX = $AudioStreamPlayer2D
var already_spawned = []  # tracks used spawn point nodes
@export var limit: int = 6
@export var spawn_point: Vector2 = Vector2(68.0,624)
func _process(delta: float) -> void:
	label.text = str(already_spawned.size()) + "/" + str(limit) + " Allowed Windows"
	if already_spawned.size() > limit:
		reset_level()
		#reset level (create a function for that sets the player pos to (359.0,67)
	pass
func reset_level() -> void:
	# Clear all spawned platforms
	for child in get_children():
		if child is plat_scene:
			child.queue_free()
	already_spawned.clear()
	player.position = spawn_point
func _on_timer_timeout() -> void:
	# Get only the spawn points that are currently free
	var available = spawn_points.get_children().filter(func(p): return p not in already_spawned)

	if available.is_empty():
		print("No free spawn points!")
		return

	var p = available.pick_random()
	already_spawned.append(p)      # mark it as used
	spawn_platform(p.global_position)

func spawn_platform(pos: Vector2) -> void:
	var f = plat_scene.instantiate()
	f.position = pos
	errorSFX.play()
	add_child(f)

	# When the platform is removed from the scene, free its spawn point
	f.tree_exited.connect(_on_platform_removed.bind(pos))

func _on_platform_removed(pos: Vector2) -> void:
	# Find the spawn point matching this position and unmark it
	for p in spawn_points.get_children():
		if p.global_position == pos:
			already_spawned.erase(p)
			break
