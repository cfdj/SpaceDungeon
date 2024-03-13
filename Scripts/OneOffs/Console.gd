class_name Console extends Sprite2D

@export var HomeSprite:Texture2D
@export var DestinationSprite:Texture2D;
@export var HomeEnding:TextureRect;
@export var DestinationEnding:TextureRect;

@export var HomeItem:PackedScene;
@export var DestinationItem:PackedScene;

@export var highlightSprite:AnimatedSprite2D;
var player:PlayerMovement;
@export var placed:bool = false;
var homeOrDestination:bool = false; ##False = home, true = Destination
var playerInRoom:bool;
func _ready():
	player = Singletons.player;
	Singletons.console = self;
func home():
	placed = true;
	homeOrDestination = false;
	texture = HomeSprite;
func destination():
	placed = true;
	homeOrDestination = true;
	texture = DestinationSprite;

func placeMap(item:PackedScene):
	if(item ==DestinationItem):
		destination();
	if(item == HomeItem):
		home();
func switchActivation():
	if(placed&&!homeOrDestination):
		HomeEnding.visible = true;
	elif (placed&&homeOrDestination):
		DestinationEnding.visible = true;

func _on_area_2d_body_entered(body):
	if(body == player):
		playerInRoom = true;
		highlightSprite.play();

func _on_area_2d_body_exited(body):
	if(body == player):
		playerInRoom = false;
		highlightSprite.stop();
