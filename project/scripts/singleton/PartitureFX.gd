extends Node

const CLEFS = [
	preload("res://sprites/fx/clef1.png"),
	preload("res://sprites/fx/clef2.png")
]

const NOTES = [
	preload("res://sprites/fx/note1.png"),
	preload("res://sprites/fx/note2.png"),
	preload("res://sprites/fx/note3.png"),
	preload("res://sprites/fx/note4.png"),
	preload("res://sprites/fx/note4.png"),
	preload("res://sprites/fx/note5.png"),
	preload("res://sprites/fx/note6.png"),
	preload("res://sprites/fx/note7.png"),
	preload("res://sprites/fx/note8.png")
]

var note_count = 0

func _ready() -> void:
	randomize()

func increment() -> void:
	note_count += 1