extends Control

@onready var fullscreen = $Settings/Tabs/Video/Fullscreen

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/start_menu.tscn")

func _on_fullscreen_pressed():
	if fullscreen.button_pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
