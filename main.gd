extends Node

@export var mainScene: PackedScene;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SceneManager.change_scene("res://hud/mainMenu.tscn");
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
