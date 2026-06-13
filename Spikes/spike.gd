extends Area2D

# Export the path to the TileMapLayer so you can assign it in the Inspector
@export var tilemap_layer: TileMapLayer

func _ready() -> void:
	# Connect the body/area signal. 
	# Using area_entered if your TileMapLayer has Area2D physics, 
	# or body_entered if you are using standard tile collisions.
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	# Check if the player touched the TileMapLayer
	if body == tilemap_layer:
		# Get the global coordinates of the hazard detector
		var global_pos: Vector2 = global_position
		
		# Convert global position to the local map coordinates of the TileMapLayer
		var map_pos: Vector2i = tilemap_layer.local_to_map(tilemap_layer.to_local(global_pos))
		
		# Fetch the tile data at that specific coordinate
		var tile_data: TileData = tilemap_layer.get_cell_tile_data(map_pos)
		
		# If the tile exists, check if it has the deadly custom data property
		if tile_data and tile_data.get_custom_data("is_deadly"):
			trigger_death()


func trigger_death() -> void:
	print("Ouch! Dead.")
	# Reset the current active scene
	get_tree().reload_current_scene()
