extends Node

var scene_dictionary  = {
	"MainMenu" : "res://hud/mainMenu.tscn",
	"Game" : "res://hud/game.tscn",
	"Settings" : "res://hud/settings.tscn",
}

func change_scene2(scene_name: String) -> void:
	scene_name = scene_dictionary.get(scene_name, scene_name)
	get_tree().change_scene_to_file(scene_name)

## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
