extends Node2D

signal click

var base: Vector2 = Vector2.ZERO
var time: float = 0

var ampy: float = 0.5 * OS.get_screen_size().y
var freqy: float = 1
var fiy: float = 1.2

var ampx: float = 0.2 * OS.get_screen_size().x
var freqx: float = 0.85
var fix: float = 0.7

const PLUS1 = preload("res://scenes/Plus1Particle.tscn")
var clicks: int = 0
var achievementClicks: int = 0

var gplay = Engine.get_singleton("GooglePlay")

func _ready():
	time = 100 * randf()
	position = base

func _physics_process(delta):
	time += delta
	position.x = base.x + ampx * cos(freqx * time)
	position.y = base.y + ampy * sin(freqy * time)

func _on_Area2D_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			var p1 = PLUS1.instance()
			add_child(p1)
			p1.position = Vector2.ZERO
			p1.emitting = true
			clicks += 1
			achievementClicks += 1
			emit_signal("click", clicks)
			Audio.play_note()

func _on_AchievementTimer_timeout() -> void:
	print("Target: ", global_position, ", ", position)
	if achievementClicks > 0 and PlayServices.isConnected():
		PlayServices.increase_achievement(Achievements.CLICKITY, achievementClicks)
		achievementClicks = 0