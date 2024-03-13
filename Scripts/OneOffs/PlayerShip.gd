extends Sprite2D

var player:PlayerMovement;
@export var leaveButton:Button;
func _ready():
	player = Singletons.player; 
func _on_area_2d_body_entered(body):
	if(player == body):
		leaveButton.visible = true;
		if(Singletons.console.placed):
				leaveButton.disabled = false;

func _on_area_2d_body_exited(body):
	if(player == body):
		leaveButton.visible = false;
		leaveButton.disabled = true;
