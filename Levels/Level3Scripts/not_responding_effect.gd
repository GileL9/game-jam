extends CanvasLayer

# ── tweakable values ──────────────────────────────────────────────
const CYCLE_SECONDS   : float = 2.0   # how long between freeze events
const FREEZE_SECONDS  : float = 2.0   # how long the freeze lasts
# ─────────────────────────────────────────────────────────────────
@onready var spriteLoad = $Overlay/Sprite2D
@onready var overlay : ColorRect = $Overlay

var _freeze_start_ms  : int  = 0
var _next_freeze_ms   : int  = 0
var _frozen           : bool = false


func _ready() -> void:
	# This node must keep running even when the game is frozen
	process_mode = Node.PROCESS_MODE_ALWAYS

	# Start hidden
	spriteLoad.hide()
	overlay.hide()

	# Schedule the first freeze
	_schedule_next()


func _process(_delta: float) -> void:
	var now_ms : int = Time.get_ticks_msec()
	#spriteLoad.rotation_degrees += _delta * 90 #have it rotate
	if _frozen:
		# Check whether the freeze duration has elapsed (real wall-clock time)
		if now_ms - _freeze_start_ms >= int(FREEZE_SECONDS * 1000):
			_unfreeze()
	else:
		# Check whether it's time to trigger the next freeze
		if now_ms >= _next_freeze_ms:
			_freeze()


# ── internal helpers ──────────────────────────────────────────────

func _freeze() -> void:
	_frozen        = true
	_freeze_start_ms = Time.get_ticks_msec()

	overlay.show()
	spriteLoad.show()
	Engine.time_scale = 0.0   # freeze everything except PROCESS_MODE_ALWAYS nodes


func _unfreeze() -> void:
	_frozen = false

	Engine.time_scale = 1.0   # resume the game
	overlay.hide()

	# Schedule the next freeze starting NOW (after the unfreeze)
	_schedule_next()


func _schedule_next() -> void:
	_next_freeze_ms = Time.get_ticks_msec() + int(CYCLE_SECONDS * 1000)
