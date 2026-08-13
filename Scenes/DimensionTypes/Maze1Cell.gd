class_name Maze1Cell
extends Node3D

@onready var WallNorth: CSGBox3D = $CSGCombiner3D/WallNorth
@onready var WallSouth: CSGBox3D = $CSGCombiner3D/WallSouth
@onready var WallEast: CSGBox3D = $CSGCombiner3D/WallEast
@onready var WallWest: CSGBox3D = $CSGCombiner3D/WallWest
@onready var Walls = [WallNorth,WallSouth,WallWest,WallEast]

@onready var PostNW: CSGBox3D = $CSGCombiner3D/PostNW
@onready var PostSW: CSGBox3D = $CSGCombiner3D/PostSW
@onready var PostSE: CSGBox3D = $CSGCombiner3D/PostSE
@onready var PostNE: CSGBox3D = $CSGCombiner3D/PostNE
@onready var Posts = [PostNW,PostSW,PostSE,PostNE]

@onready var FloorNode: CSGBox3D = $CSGCombiner3D/Floor
@onready var CeilingNode: CSGBox3D = $CSGCombiner3D/Cieling
@onready var MaterialsForWallsIndexes := {
	"0":[WallNorth,WallSouth,WallEast,WallWest],
	"1":[PostNW,PostSW,PostSE,PostNE],
	"2":[CeilingNode],
	"3":[FloorNode],
		}

var Visited: bool = false

func remove_wall(TargetDirection: Vector2i) -> void:
	match TargetDirection:
		Vector2i(0, -1): WallNorth.visible = false
		Vector2i(0, 1): WallSouth.visible = false
		Vector2i(1, 0): WallEast.visible = false
		Vector2i(-1, 0): WallWest.visible = false

func remove_cieling():
	CeilingNode.visible = false

func set_cell_height(Height: float):
	CeilingNode.position.y = Height
	for Post in Posts:
		var OriginalHeight = Post.size.y
		Post.size.y = Height
		Post.position.y += (Height-OriginalHeight)/2.0
	for Wall in Walls:
		var OriginalHeight = Wall.size.y
		Wall.size.y = Height
		Wall.position.y += (Height-OriginalHeight)/2.0

func set_cell_size(CellSize: float) -> void:
	var HalfSize: float = CellSize / 2.0
	
	FloorNode.size.x = CellSize+6.0
	FloorNode.size.z = CellSize+6.0
	CeilingNode.size.x = CellSize+6.0
	CeilingNode.size.z = CellSize+6.0
	
	for Wall in Walls:
		Wall.position = Vector3(HalfSize*(-1 if Wall.position.x < -1 else 1 if Wall.position.x != 0 else 0), Wall.position.y, HalfSize*(-1 if Wall.position.z < -1 else 1 if Wall.position.z != 0 else 0))
		Wall.size.x = CellSize if Wall.position.x == 0 else 6.0
		Wall.size.z = CellSize if Wall.position.z == 0 else 6.0
		
	var PostOffset: float = HalfSize
	for Post in Posts:
		Post.position = Vector3(PostOffset * (-1 if Post.position.x < 0 else 1), Post.position.y, PostOffset * (-1 if Post.position.z < 0 else 1))

func set_material(MaterialList,Index):
	if Index >= 0 and Index < MaterialList.size():
		for node in MaterialsForWallsIndexes[str(Index)]:
			node.material = MaterialList[Index]
