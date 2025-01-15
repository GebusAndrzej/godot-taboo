extends Control

var team = 0;
var roundNo = 1;

#-
func getScore() -> String:
	var ret = "";
	var keys = GameState.teamScore.keys();
	print(GameState.teamScore)
	
	for key in keys:
		ret += str("Drużyna ", key,": ", GameState.teamScore[key],'\n')
		
	return ret

#round handlers
func round_start() -> void:
	$NextRound.hide();
	$ElapsedTime.start();
	$ElapsedTimeLabel.show();
	$SuccessButton.show();
	$IgnoreButton.show();
	$ScoreLabel.hide();
	
func round_stop() -> void:
	$ElapsedTime.stop();
	$ElapsedTimeLabel.hide();
	$SuccessButton.hide();
	$IgnoreButton.hide();
	$ScoreLabel.show();
	
	
	if roundNo < GameState.rounds:
		if team < GameState.teams:
			team += 1;
		else:
			team = 1;
			roundNo += 1;
		$NextRound.show();
	else:
		if team < GameState.teams:
			team += 1;
			$NextRound.show();
		else:
			print("Ostatnia runda minęła")
	
	$ScoreLabel.text = getScore();

# Start
func _ready() -> void:
	$ElapsedTime.wait_time = GameState.roundTime;
	round_stop();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ElapsedTimeLabel.text = str($ElapsedTime.time_left);
	$LbState.text = str("Runda: ",roundNo, " / ", GameState.rounds,"\n", "Team: ", team, " / ", GameState.teams);
	

# listeners
func _on_elapsed_time_timeout() -> void:
	round_stop()

func _on_next_round_pressed() -> void:
	round_start()

func _on_success_button_pressed() -> void:
	GameState.teamScore[team] = GameState.teamScore.get(team, 0) + 1
	pass # Replace with function body.
