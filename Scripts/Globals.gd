class_name Globals extends Node

@export var player:PlayerMovement;
@export var mapDisplay:TextureRect;
@export var tileMap:Map;
@export var dungeon:dungeonManager;
@export var console:Console;
@export var globals:Globals;

func _ready():
	globals = self;
func leave():
	print("Leaving check")
	if(console.placed):
		console.switchActivation();
