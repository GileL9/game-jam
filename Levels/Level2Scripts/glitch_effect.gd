# fps_limiter.gd
extends Node

@export var target_fps: int = 20  # Set your desired FPS cap here

var _frame_time: float
var _accumulator: float = 0.0

func _ready() -> void:
	set_process(true)
	_frame_time = 1.0 / float(target_fps)

func _process(delta: float) -> void:
	_accumulator += delta
	if _accumulator < _frame_time:
		# Busy-wait to block the frame from finishing
		var wait_until := Time.get_ticks_usec() + int((_frame_time - _accumulator) * 1_000_000)
		while Time.get_ticks_usec() < wait_until:
			pass
		_accumulator = 0.0
	else:
		_accumulator = fmod(_accumulator, _frame_time)
