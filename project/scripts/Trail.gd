extends Node2D

const NOTE = preload("res://scenes/Note.tscn")

export(NodePath) var targetPath
export var length: int = 100

onready var line: Line2D = $Node/Line2D

var target

func _ready() -> void:
	line.width = length
	target = get_node(targetPath)

func _process(delta: float) -> void:
	line.add_point(target.global_position)
	while line.get_point_count() > length:
		line.remove_point(0)

func _on_NoteSpawnTimer_timeout() -> void:
	var note = NOTE.instance() as Node2D
	get_node("/root").add_child(note)
	note.global_rotation = 0
	var n: int = line.get_point_count() * 3/4
	note.global_position = line.get_point_position(n)