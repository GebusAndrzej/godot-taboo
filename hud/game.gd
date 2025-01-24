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
	$SuccessButton.show();
	$SkipWordButton.show();
	$ScoreLabel.hide();
	$LbWord.show();
	$LbForbiddenWords.show();
	%RoundTimeProgressBar.show();
	state = 1;
	
func round_stop() -> void:
	$ElapsedTime.stop();
	$SuccessButton.hide();
	$SkipWordButton.hide();
	$ScoreLabel.show();
	$LbWord.hide();
	$LbForbiddenWords.hide();
	%RoundTimeProgressBar.hide();
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
	GameState.resetSkips();
	$ElapsedTime.wait_time = GameState.roundTime;
	round_stop();
	$ScoreLabel.hide();
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
#	Set ui left time
	%RoundTimeProgressBar.value = ($ElapsedTime.time_left / GameState.roundTime) * 100;
	$RoundTimeProgressBar/TimeLeft.text = str(Global.time_convert(int($ElapsedTime.time_left)));
	
	$LbState.text = str("Runda: ",roundNo, " / ", GameState.rounds,"\n", "Team: ", team, " / ", GameState.teams);
	
	if GameState.maxSkipCount != Global.skipNumberInfinite and GameState.teamSkips[team] >= GameState.maxSkipCount:
		$SkipWordButton.disabled = true;
	else:
		$SkipWordButton.disabled = false;
	
	if state == 1:
#		Set the words in card
		$LbWord.text = str(Global.words[wordNo].word);
		$LbForbiddenWords.text = str("\n".join(Global.words[wordNo].forbiddenWords))
		
#		Set skip button state
		$SkipWordButton.text = str(
			"Pomiń",
			str(" (", GameState.maxSkipCount - GameState.teamSkips[team], ")") if GameState.maxSkipCount != Global.skipNumberInfinite else ""
		)

# listeners
func _on_elapsed_time_timeout() -> void:
	round_stop()

func _on_next_round_pressed() -> void:
	round_start()

func _on_success_button_pressed() -> void:
	GameState.teamScore[team] = GameState.teamScore.get(team, 0) + 1;
	nextWord();

func _on_ignore_button_pressed() -> void:
	GameState.teamSkips[team] = GameState.teamSkips.get(team, 0) + 1;
	nextWord();
	
func _on_bt_back_pressed() -> void:
	SceneManager.change_scene2("MainMenu");
