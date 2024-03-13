class_name dungeonManager extends Node

##Handles dungeon wide effects and eventually the save/loading of the dungeon
##Does this by having an enum of state which is moved between, probably requiring a new type of switch
##Changes are done based on groups, rather than assigning to this in arrays. It also resets switches
enum dungeonState{
	airlocksShut,
	airlocksOpen
}
@export var state:dungeonState;
@export var group1:String;
@export var group2:String;
@export var switches1:String;
@export var switches2:String;

@export var solarOpen:bool;
func _ready():
	setState(state);
	Singletons.dungeon = self;
func setState(newState:dungeonState):
	print("Setting state");
	state = newState;
	if(state == dungeonState.airlocksOpen):
		get_tree().call_group(group1, "open")
		get_tree().call_group(group2, "close")
		get_tree().call_group(switches1, "remotePress")
		get_tree().call_group(switches2, "reset")
	elif(state == dungeonState.airlocksShut):
		get_tree().call_group(group2, "open")
		get_tree().call_group(group1, "close")
		get_tree().call_group(switches2, "remotePress")
		get_tree().call_group(switches1, "reset")

func openSolarPannels():
	pass;
