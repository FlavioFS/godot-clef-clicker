extends Node2D

onready var sprite: Sprite = $Sprite
onready var timer: Timer = $SelfdestructTimer

func _ready() -> void:
	sprite.visible = false
	sprite.texture = PartitureFX.NOTES[randi() % PartitureFX.NOTES.size()]
	PartitureFX.increment()
	$AnimationPlayer.play("float")
	sprite.visible = true
	timer.start()

func _on_SelfdestructTimer_timeout() -> void:
	queue_free()