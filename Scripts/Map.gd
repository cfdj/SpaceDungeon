class_name Map extends TileMap

func _ready():
	Singletons.tileMap = self;
##Swaps based on location in the tilemap
func removeCollider(location:Vector2i,layer:int):
	var tile = get_cell_atlas_coords(layer,location);
	erase_cell(layer,location);
	set_cell(layer,location,1,tile);
func addCollider(location:Vector2i,layer:int):
	var tile = get_cell_atlas_coords(layer,location);
	erase_cell(layer,location);
	set_cell(layer,location,0,tile);
