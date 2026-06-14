extends Node2D

@onready var goal = $goal
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	goal.change_icon("sad")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("da")
		get_tree().change_scene_to_file.call_deferred("res://Levels/Level7Scripts/Level7SubLevel.tscn")
		pass
	pass # Replace with function body.


func _on_kill_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.has_method("kill"):
			body.kill(Vector2(91.0,650.0))
		pass
	pass # Replace with function body.
