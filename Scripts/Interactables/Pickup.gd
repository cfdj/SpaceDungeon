extends Area2D
@export var player:PlayerMovement;
@export var item:PackedScene;

@export var hoverDistance:float;
@export var hoverSpeed:float;
var t = 0;
var hoverGoal:Vector2;
var hoverStart:Vector2;
var hoveringUp:bool = true;
func _ready():
	hoverStart = position;
	hoverGoal = hoverStart + Vector2(0,hoverDistance);
func _on_body_entered(body):
	if(body == player):
		player.addItem(item);
		queue_free();

func _process(delta):
	if(hoveringUp):
		t+=delta*hoverSpeed;
		position = hoverStart.lerp(hoverGoal,t);
		if(position.distance_to(hoverGoal)<0.1):
			t=0;
			hoveringUp = false;
	else:
		t+= delta*hoverSpeed
		position = hoverGoal.lerp(hoverStart,t);
		if(position.distance_to(hoverStart)<0.1):
			t=0;
			hoveringUp = true;
