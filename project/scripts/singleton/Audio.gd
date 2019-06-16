extends Node

const MAX_STEPS: int = 32
const MAX_PITCH: float = 3.0
const MIN_PITCH: float = 1.0

var count: int = 0
var step: int = 1

onready var sfx: AudioStreamPlayer = $SFX
onready var bgm: AudioStreamPlayer = $BGM

func _ready() -> void:
	sfx.pitch_scale = MIN_PITCH
	bgm.play()
	pass

func play_note():
	sfx.play()
	count += step
	sfx.pitch_scale = lerp(MIN_PITCH, MAX_PITCH, (1.0 * count) / MAX_STEPS)
	if count <= 0:
		step = 1
	elif count >= MAX_STEPS:
		step = -1