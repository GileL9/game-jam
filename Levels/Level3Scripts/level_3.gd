extends Node2D

@onready var player = $Player
@onready var title2 = $title2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_kill_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.has_method("kill"):
			body.kill(Vector2(142,365))
		pass
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	var tween = create_tween()
	tween.tween_property(title2, "modulate:a", 0.0, 1.0)
	pass # Replace with function body.
