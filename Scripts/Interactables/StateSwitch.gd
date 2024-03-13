class_name StateSwitch extends Switch;

@export var manager:dungeonManager;
@export var state:dungeonManager.dungeonState;

func _on_body_entered(body):
	if(body == player):
		open();
func open():
	sprite.texture = pressed;
	manager.setState(state);
func close():
	sprite.texture = notPressed;
	
func reset():
	sprite.texture = notPressed;
func remotePress():
	sprite.texture = pressed;
