extends Node

export var text = "Debug\n"

func log(value: String):
	text += "%s\n" % value