extends CanvasLayer

onready var scoreLabel: Label = $ScoreLabel
onready var debugLabel: Label = $PauseMenu/ScrollContainer/DebugLabel
onready var pauseMenu: Control = $PauseMenu
onready var btnSettings: Button = $SettingsButtton

var paused: bool = false

func _ready() -> void:
	PlayServices.connect("online", self, "on_online_signal")
	fetchPauseUI()

func fetchPauseUI():
	pauseMenu.visible = paused
	get_tree().paused = paused
	btnSettings.modulate = Color.white if paused else Color(1, 1, 1, 0.7)
	var isConnected = PlayServices.isConnected()
	$PauseMenu/LoginButton.visible = not isConnected
	$PauseMenu/Online.visible = isConnected

func _on_SettingsBtn_pressed() -> void:
	paused = not paused
	fetchPauseUI()

func _on_icon_click(clicks) -> void:
	scoreLabel.text = str(clicks)

func _on_LoginButton_pressed() -> void:
	PlayServices.login()

func _on_ButtonAchievements_pressed() -> void:
	if PlayServices.isConnected():
		PlayServices.show_achievements()
	else:
		fetchPauseUI()
		_on_LoginButton_pressed()

func _on_ButtonLeaderboards_pressed() -> void:
	if PlayServices.isConnected():
		PlayServices.show_leaderboard(Leaderboards.LEAD_CLICKS)
	else:
		fetchPauseUI()
		_on_LoginButton_pressed()

func _on_ButtonStatus_pressed() -> void:
	debugLabel.text = Debug.text


func on_online_signal(isOnline: bool):
	$PauseMenu/LoginButton.visible = not isOnline
	$PauseMenu/Online.visible = isOnline

func _notification(what):
    if what == MainLoop.NOTIFICATION_WM_FOCUS_IN:
        fetchPauseUI()