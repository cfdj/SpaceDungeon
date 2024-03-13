class_name Switch extends Area2D

@export var player:PlayerMovement;
@export var notPressed:Texture2D;
@export var pressed:Texture2D;
@export var target:Array[Openable];
@export var closetargets:Array[Openable];
@export var sprite:Sprite2D;
func _on_body_entered(body):
	if(body == player):
		open();
func open():
	sprite.texture = pressed;
	for i in target:
		i.open();
	for i in closetargets:
		i.close();
func close():
	sprite.texture = notPressed;
	for i in target:
		i.close();
	for i in closetargets:
		i.open();
func reset():
	sprite.texture = notPressed;
func remotePress():
	sprite.texture = pressed;
