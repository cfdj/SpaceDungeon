class_name UIItem extends Item

@export var displayElement:TextureRect;

func useItem(facing:PlayerMovement.direction,position:Vector2i):
	if(!Singletons.mapDisplay.is_visible_in_tree()):
		Singletons.mapDisplay.texture = texture;
		Singletons.mapDisplay.visible = true;
	elif(Singletons.mapDisplay.is_visible_in_tree()):
		Singletons.mapDisplay.visible = false;
	queue_free();
