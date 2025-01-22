extends Control

var team = 0;
var roundNo = 1;
var state = 0; # 0 - idle, 1 - round in progress, 2 - end
var wordNo = 0;
var words = Global.words;

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
	$LbWord.show();
	state = 1;
	
func round_stop() -> void:
	$ElapsedTime.stop();
	$ElapsedTimeLabel.hide();
	$SuccessButton.hide();
	$IgnoreButton.hide();
	$ScoreLabel.show();
	$LbWord.hide();
	state = 0;
	nextWord();
	
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
			state = 2;
	
	$ScoreLabel.text = getScore();

func prepareCards() -> void:
	words.shuffle();
	
func nextWord() -> int:
	wordNo = (wordNo + 1) % len(words);
	return wordNo
	
# Start
func _ready() -> void:
	prepareCards();
	GameState.resetScore();
	$ElapsedTime.wait_time = GameState.roundTime;
	round_stop();
	$ScoreLabel.hide();
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ElapsedTimeLabel.text = str($ElapsedTime.time_left);
	$LbState.text = str("Runda: ",roundNo, " / ", GameState.rounds,"\n", "Team: ", team, " / ", GameState.teams);
	if state == 1:
		$LbWord.text = str(
			Global.words[wordNo].word,
			"\n", 
			"\n".join(Global.words[wordNo].forbiddenWords)
		);

# listeners
func _on_elapsed_time_timeout() -> void:
	round_stop()

func _on_next_round_pressed() -> void:
	round_start()

func _on_success_button_pressed() -> void:
	GameState.teamScore[team] = GameState.teamScore.get(team, 0) + 1;
	nextWord();

func _on_bt_back_pressed() -> void:
	SceneManager.change_scene2("MainMenu");
