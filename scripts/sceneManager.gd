extends Node

# Funkcja do zmiany sceny
func change_scene(scene_path: String):
	# Usuwanie aktualnej sceny, jeśli istnieje
	if get_tree().current_scene:
		get_tree().current_scene.queue_free()
	
	# Wczytanie i dodanie nowej sceny
	var new_scene = load(scene_path).instantiate()
	get_tree().current_scene = new_scene
	get_tree().root.add_child(new_scene)

	print("Zmieniono scenę na:", scene_path)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
