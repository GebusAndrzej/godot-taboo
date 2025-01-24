extends Node

var words;
var skipNumberInfinite = 11;
var file_pl = "res://dict/pl.json"
var locale = OS.get_locale_language();

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var json_as_text = FileAccess.get_file_as_string(file_pl)
	var json_as_dict = JSON.parse_string(json_as_text)
	#if json_as_dict:
		#print(json_as_dict)
	words = json_as_dict;


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
	
func time_convert(time_in_sec):
	var seconds = time_in_sec % 60
	var minutes = (time_in_sec / 60) % 60
	
	#returns a string with the format "HH:MM:SS"
	return "%02d:%02d" % [minutes, seconds]
