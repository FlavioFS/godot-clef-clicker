extends Node

signal online

var gplay = Engine.get_singleton("GooglePlay")

var supported: bool = false
var isInit: bool = false

func _ready():
	supported = (OS.get_name() == "Android") and (gplay != null)

func _receive_message(tag, from, key, data):
	if tag == "FrogSquare" and from == "GoogleService":
		if key == "login" and data:
			emit_signal("online", data)
			unlock_achievement(Achievements.LOGIN)

		# I changed the module sources (GodotGoogleService)
		# and recompiled Godot to add this custom callback
		if key == "loginFail":
			emit_signal("online", false)

# =====================================
# Connection
# =====================================
func login():
	if supported:
		if not isInit:
			gplay.init(get_instance_id())
			isInit = true
		if not gplay.is_connected():
			gplay.login()
		else:
			emit_signal("online", true)

func logout():
	if supported and gplay.is_connected():
		gplay.logout()
		emit_signal("online", false)

func isConnected():
	return supported and isInit and gplay.is_connected()

# =====================================
# Achievements
# =====================================
func unlock_achievement(id: String):
	if isConnected():
		gplay.unlock_achievement(id)

func increase_achievement(id: String, delta: int):
	if isConnected():
		gplay.increase_achievement(id, delta)

func show_achievements():
	if isConnected():
		gplay.show_achievements()

# =====================================
# Leaderboards
# =====================================
func show_leaderboards():
	if isConnected():
		gplay.show_leaderboards()

func show_leaderboard(id: String):
	if isConnected():
		gplay.show_leaderboard(id)

func submit_leaderboard(score: int, id: String):
	if isConnected():
		gplay.show_leaderboard(score, id)