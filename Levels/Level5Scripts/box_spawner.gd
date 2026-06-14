extends Node2D

@onready var box_scene = preload("res://Levels/Level5Scripts/box.tscn")
@onready var button = $"dugme"
var spawned_boxes = []
var markersF = []
var locations = [Vector2(608,164),Vector2(224,296),Vector2(416,231),Vector2(223,453),Vector2(415,360)]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	markersF.append($"../Marker2D")
	markersF.append($"../Marker2D3")
	markersF.append($"../Marker2D4")
	for child in get_children():
		spawned_boxes.append(child)
	change_loc_button()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		spawn_box()
		change_loc_button()
func spawn_box():
	var b = box_scene.instantiate()
	b.position =markersF.pick_random().position
	add_child.call_deferred(b)
	spawned_boxes.append(b)
	if spawned_boxes.size() > 9:
		#queue free 
		spawned_boxes[0].queue_free.call_deferred()
		spawned_boxes.remove_at(0)
		pass
	pass

func change_loc_button():
	button.position = locations.pick_random()
	
	pass
