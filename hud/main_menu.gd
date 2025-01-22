extends Node2D

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass;
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

func _on_bt_settings_pressed() -> void:
	#SceneManager.change_scene("res://hud/settings.tscn")
	SceneManager.change_scene2("res://hud/settings.tscn")

func _on_bt_start_game_pressed() -> void:
	SceneManager.change_scene2("res://hud/game.tscn")
