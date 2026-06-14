extends Area2D

# Exported variable allows you to change the point value in the Inspector
@export var score_value: int = 10

func _on_body_entered(body: Node2D) -> void:
	# Check if the colliding body is the player
	if body.name == "Player": 
		# Option A: Call a function on the player to add points/inventory
		if body.has_method("add_score"):
			body.add_score(score_value)
		queue_free() 
