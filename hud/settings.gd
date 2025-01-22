extends Control

func _on_bt_back_pressed() -> void:
	SceneManager.change_scene2('res://hud/mainMenu.tscn')
	
func time_convert(time_in_sec):
	var seconds = time_in_sec%60
	var minutes = (time_in_sec/60)%60
	
	#returns a string with the format "HH:MM:SS"
	return "%02d:%02d" % [minutes, seconds]
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/Teams/TeamCountSlider.value = GameState.teams;
	$"VBoxContainer/Round Time/RoundLengthSlider".value = GameState.roundTime;
	$"VBoxContainer/Round Number/RoundNumberSlider".value = GameState.rounds;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$VBoxContainer/Teams/LbTeamsValue.text = str(GameState.teams);
	$"VBoxContainer/Round Time/LbRoundLengthValue".text = str(time_convert(GameState.roundTime));
	$"VBoxContainer/Round Number/LbRoundsNumberValue".text = str(GameState.rounds);

func _on_team_count_slider_value_changed(value: float) -> void:
	GameState.setTeamNo(int(value));

func _on_round_length_slider_value_changed(value: float) -> void:
	GameState.setRoundTime(int(value));

func _on_round_number_slider_value_changed(value: float) -> void:
	GameState.rounds = int(value);
