extends Area2D

func _ready() -> void:
	# Connect the collision signal to our function below when the level starts
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	# 1. Check if the object that entered is actually a platform
	if body.is_in_group("platforms"):
		# 2. Since it's a platform, we know it has the teleport function. Call it!
		body.teleport_down()
