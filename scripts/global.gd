extends Node

var file_pl = "res://dict/pl.json"
var words;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var json_as_text = FileAccess.get_file_as_string(file_pl)
	var json_as_dict = JSON.parse_string(json_as_text)
	if json_as_dict:
		print(json_as_dict)
	words = json_as_dict;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
