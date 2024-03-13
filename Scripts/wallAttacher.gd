extends Item

@export var flightSpeed:float;
@export var flightDistance:int;

@export var north:Texture2D;
@export var south:Texture2D;
@export var east:Texture2D;
@export var west:Texture2D;
var attached = false;
var found = false;
var noTarget = false;
var target:Vector2; ## in global position, will need converting back
var start:Vector2;
var t = 0;
func useItem(facing:PlayerMovement.direction,location:Vector2i):
	var tilemap:Map = Singletons.tileMap;
	start = tilemap.to_global(tilemap.map_to_local(location));
	position = start;
	var castDirection:Vector2i;
	if(facing == PlayerMovement.direction.up):
		castDirection = Vector2i(0,-1);
		texture = north;
	if (facing == PlayerMovement.direction.left):
		castDirection = Vector2i(-1,0);
		texture = west;
	if (facing == PlayerMovement.direction.right):
		castDirection = Vector2i(1,0);
		texture = east;
	if (facing == PlayerMovement.direction.down):
		castDirection = Vector2i(0,1);
		texture = south;
	var checkingPosition;
	var i = 1;
	while(i<flightDistance && found == false):
		checkingPosition = location+castDirection*i;
		var checking = tilemap.get_cell_tile_data(1,checkingPosition,false);

		if(checking != null):
			if(checking.get_custom_data("Wall")):
				found = true;
		i+=1;
	if(found):
		target = tilemap.to_global(tilemap.map_to_local(checkingPosition - castDirection));
	else:
		noTarget = true;
		target = tilemap.to_global(tilemap.map_to_local(checkingPosition));
func _process(delta):
	if((found or noTarget) &&!attached):
		t+= delta*flightSpeed;
		position= start.lerp(target,t)
		if(abs(position.distance_to(target))<0.01):
			position = target;
			attached = true;
			placeSpot();
			if(noTarget):
				queue_free();
func placeSpot():
	var tilemap:Map = Singletons.tileMap;
	var location = tilemap.to_local(target);
	location = tilemap.local_to_map(location);
	tilemap.removeCollider(location,0);
func removeSpot():
	var tilemap:Map = Singletons.tileMap;
	var location = tilemap.to_local(target);
	location = tilemap.local_to_map(location);
	tilemap.addCollider(location,0);
