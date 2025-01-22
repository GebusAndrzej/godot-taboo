extends Node

var roundTime: int = 5;
var rounds: int = 2;
var teams: int = 2;
var teamScore: Dictionary = Dictionary();

## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
	
func setRoundTime(number: int) -> void:
	roundTime = number;
	
func setTeamNo(number: int) -> void:
	teams = number;
	resetScore()

func resetScore() -> void:
	teamScore.clear();
	
	for i in teams:
		GameState.teamScore[i+1] = 0;
