class_name PlayerMovement extends CharacterBody2D

@export var tilemap: TileMap;
@export var speed:float;
@export var currentItemQ:PackedScene;
@export var currentItemE:PackedScene;
@export var animation:AnimatedSprite2D;
@export var items:Array[PackedScene];
@export var UI:Inventory;
@export var console:Console; ##Temp for end sequence setup
enum direction{up,down,left,right}
var facing = direction.up;
var previousFacing = null;
var UIActive = false;
var UIDelay ##Delay to stop the UI switching itself immediately
var E:int = 0;
var Q:int = 0;
func _ready():
	Singletons.player = self;
	
func _process(delta):
	if(!UIActive):
		if(!console.playerInRoom):
			if Input.is_action_just_pressed("itemUse"):
				useItem();
			if Input.is_action_just_pressed("itemUse2"):
				useItem2();
		else:
			if Input.is_action_just_pressed("itemUse"):
				endSequence(1);
			if Input.is_action_just_pressed("itemUse2"):
				endSequence(2);
		if Input.is_action_just_pressed("OpenUI"):
			openUI();
func _physics_process(delta):
	var move =Vector2i(0,0);
	if(!UIActive):
		if Input.is_action_pressed("up"):
			move += Vector2i(0,-1);
			facing = direction.up;
			
		if Input.is_action_pressed("left"):
			move += Vector2i(-1,0);
			facing = direction.left;
			
		if Input.is_action_pressed("right"):
			move += Vector2i(1,0);
			facing = direction.right;
			
		if Input.is_action_pressed("down"):
			move += Vector2i(0,1);
			facing = direction.down;
			
		if(facing != previousFacing):
			previousFacing = facing;
			match facing:
				direction.up:
					animation.play("North");
				direction.down:
					animation.play("South");
				direction.left:
					animation.play("West");
				direction.right:
					animation.play("East");
		if(move.length() ==0):
			previousFacing = null;
			animation.stop();
	move_and_collide(move*delta*speed);
func useItem():
	if(currentItemQ != null):
		var tempItem:Item = currentItemQ.instantiate();
		tempItem.position = position;
		get_tree().root.add_child(tempItem);
		var location = getLocation();
		tempItem.useItem(facing,location);

func useItem2():
	if(currentItemE != null):
		var tempItem:Item = currentItemE.instantiate();
		tempItem.position = position;
		get_tree().root.add_child(tempItem);
		var location = getLocation();
		tempItem.useItem(facing,location)

func getLocation():
	var templocation = tilemap.to_local(position);
	templocation = tilemap.local_to_map(templocation);
	return templocation;
func openUI():
	UIActive = true;
	UI.openUI(E,Q,items)
func closeUI(selectedE:int, selectedQ:int):
	if(items.size()>0):
		currentItemQ = items[selectedQ];
		currentItemE = items[selectedE];
	UIActive = false;
	E = selectedE;
	Q = selectedQ;
func addItem(item:PackedScene):
	items.append(item);
	UI.setQBox(item);
	currentItemQ = item;

func endSequence(mapNum:int):
	var currentItem:PackedScene;
	if(mapNum ==1):
		currentItem = currentItemQ
	else:
		currentItem = currentItemE
	console.placeMap(currentItem);
