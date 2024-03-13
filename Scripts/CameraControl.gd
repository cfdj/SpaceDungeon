extends Camera2D

@export var player:PlayerMovement;

var width;
var height;
var roomPosition:Vector2;
var followPosition:Vector2;
var follow:bool = false;
func _ready():
	width = get_viewport_rect().size[0];
	height = get_viewport_rect().size[1];
	roomPosition = position;
	followPosition = position;
func _process(delta):
	##if Input.is_action_just_pressed("LockCamera"):
	##	follow = !follow
	##If the player gets too far away, move the camera to the next room
	var distance = player.position-roomPosition;
	if (distance.x>width/2):
		print("Moving Right")
		roomPosition += Vector2(width,0);
	elif(distance.x < -width/2):
		print("Moving Left")
		roomPosition -= Vector2(width,0);
	if(distance.y>height/2):
		print("Moving up")
		roomPosition += Vector2(0,height);
	if(distance.y<-height/2):
		print("Moving down")
		roomPosition -= Vector2(0,height);
	if(!follow):
		position = roomPosition;
	else:
		position = player.position;
