class_name EndingSwitch extends Area2D

@export var player:PlayerMovement;
@export var notPressed:Texture2D;
@export var pressed:Texture2D;
@export var target:Console;
@export var sprite:Sprite2D;
func _on_body_entered(body):
	if(body == player):
		open();
func open():
	sprite.texture = pressed;
	target.switchActivation();

func reset():
	sprite.texture = notPressed;


func _on_body_exited(body):
	if(body == player):
		reset();
