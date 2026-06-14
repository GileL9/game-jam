# fps_limiter.gd
extends Node

var target_fps: int = 20  # Set your desired FPS cap here
var items = []
var _frame_time: float
var _accumulator: float = 0.0
@onready var goal = $"../goal"
func _ready() -> void:
	set_process(true)
	_frame_time = 1.0 / float(target_fps)
	items = $"../FileContainer".get_children()

func _process(delta: float) -> void:
	items = $"../FileContainer".get_children()
	var new_fps = target_fps
	if items.size() == 5:
		new_fps = 5
	if items.size() == 4:
		new_fps = 10
	if items.size() == 3:
		new_fps = 15
	if items.size() == 2:
		new_fps = 20
	if items.size() == 1:
		new_fps = 25
	if items.size() == 0:
		new_fps = 60
		goal.change_icon("happy")
	if new_fps != target_fps:  # Only update when changed
		target_fps = new_fps
		_frame_time = 1.0 / float(target_fps)
	print(target_fps)
	_accumulator += delta
	if _accumulator < _frame_time:
		# Busy-wait to block the frame from finishing
		var wait_until := Time.get_ticks_usec() + int((_frame_time - _accumulator) * 1_000_000)
		while Time.get_ticks_usec() < wait_until:
			pass
		_accumulator = 0.0
	else:
		_accumulator = fmod(_accumulator, _frame_time)
	
