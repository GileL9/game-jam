extends Node2D


# Called when the node enters the scene tree for the first time.
@onready var player = $Player
@onready var goal = $goal
func _ready() -> void:
	player.set_while_true(true)
	goal.change_icon("sad")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_kill_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.has_method("kill"):
			body.kill(Vector2(289.0,547.0))


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("da")
		get_tree().change_scene_to_file.call_deferred("res://Levels/Final.tscn")
		pass
	pass # Replace with function body.
	pass # Replace with function body.
