class_name ship extends CharacterBody2D

@export var ShipWidth:int;
@export var ShipHeight:int;
var partsLocations = [];
var partsList = [];
@export var AvailableParts = [];

func _ready():
	make2DArray();

## Scan the list of components and figure out what the ship can do
func determineProperties():
	pass;
	
func make2DArray():
	for i in range(ShipWidth): 
		partsLocations.append([])
		for j in range(ShipHeight): 
			partsLocations[i].append(0)
