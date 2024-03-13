class_name door extends Openable

@export var closedSprite:Texture2D
@export var openSprite:Texture2D
@export var collider:StaticBody2D;
@export var player:PlayerMovement;
var location:Vector2i;
func _ready():
	player = Singletons.player;
	if(isOpen):
		texture = openSprite;
		collider.add_collision_exception_with(player);
	else:
		texture = closedSprite;
		
func open():
	isOpen = true;
	texture = openSprite;
	collider.add_collision_exception_with(player);
	z_index = 1; ##So that rendering order works properly
func close():
	isOpen = false;
	texture = closedSprite;
	collider.remove_collision_exception_with(player);
	z_index = 0; ##So that rendering order works properly
