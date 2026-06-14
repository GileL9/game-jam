extends Node2D
@onready var title2 = $title2
@onready var goal = $goal
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	goal.change_icon("sad")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_timer_timeout() -> void:
	#slowly remove title
	var tween = create_tween()
	tween.tween_property(title2, "modulate:a", 0.0, 1.0)
	pass # Replace with function body.
