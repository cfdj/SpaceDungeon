class_name Inventory extends TextureRect

@export var player:PlayerMovement;
@export var background:TextureRect;
@export var displays:Array[UIBox];
@export var EBox:UIBox;
@export var QBox:UIBox;
var items:Array[PackedScene];
var EItem = 0;
var QItem = 0;
var currentFocus = 0;
var OpenUI = false;
var UIDelay = false; ##Making it wait to set the UI as open so it doesn't get immediately shut
func _ready():
	for i in displays:
		i.visible = false;

func _process(delta):
	if OpenUI:
		if Input.is_action_just_pressed("OpenUI"):
			closeUI();	
		if(Input.is_action_just_pressed("itemUse")):
			QItem = currentFocus;
			setQBox(items[QItem]);
		if(Input.is_action_just_pressed("itemUse2")):
			EItem = currentFocus;
			setEBox(items[EItem]);
	if(UIDelay):
		UIDelay = false;
		OpenUI = true;
func _on_selection_box_focus_entered(SelectNum:int):
	currentFocus = SelectNum;

func closeUI():
	OpenUI = false;
	for i in displays:
		i.visible = false;
	background.visible = false;
	player.closeUI(EItem,QItem);
func openUI(E:int,Q:int,currentItems:Array[PackedScene]):
	items = currentItems;
	EItem = E;
	QItem = Q;
	background.visible = true;
	for i in currentItems.size():
		displays[i].visible = true;
		var tempItem:Item = currentItems[i].instantiate();
		displays[i].setItem(tempItem.uiSprite);
		tempItem.queue_free();
	displays[0].grab_focus();
	UIDelay  = true;
func setQBox(item:PackedScene):
	var tempItem:Item = item.instantiate();
	QBox.setItem(tempItem.uiSprite);
	tempItem.queue_free()
func setEBox(item:PackedScene):
	var tempItem:Item = item.instantiate();
	EBox.setItem(tempItem.uiSprite)
	tempItem.queue_free()
