extends DimensionType

const CellScene = preload("res://Scenes/DimensionTypes/Maze1Cell.tscn")
var Width: int
var Depth: int
var CellSize: float
var WallWidth: float
var Materials: Array

enum RoofTypes {Roof,NoRoof,Mix}
var RoofType

enum MaterialTypes {Mixed,Ordered}
var MaterialType
var MaterialsForWalls = []

var Grid: Dictionary = {} # Vector2i -> Cell

@onready var objectSpawner = $ObjectSpawner

const Directions = {
	Vector2i(0, -1): Vector2i(0, 1),
	Vector2i(0, 1): Vector2i(0, -1),
	Vector2i(1, 0): Vector2i(-1, 0),
	Vector2i(-1, 0): Vector2i(1, 0)
}

func _generate_dimension(seed: int) -> void:
	RNG.seed = seed
	Width = RNG.randi_range(3, 10)
	Depth = RNG.randi_range(3, 10)
	CellSize = RNG.randf_range(7, 15)
	WallWidth = 6.0
	RoofType = RoofTypes.values()[RNG.randi_range(0, RoofTypes.size() - 1)]
	
	Materials = pick_random_materials(RNG)
	MaterialType = MaterialTypes.values()[RNG.randi_range(0, MaterialTypes.size() - 1)]
	if MaterialType == MaterialTypes.Ordered:
		for i in range(0,4):
			MaterialsForWalls.append(Materials[RNG.randi() % Materials.size()])
	
	clear_maze()
	spawn_cells()
	carve_maze(Vector2i.ZERO)
	
	spawn_objects(objectSpawner,[DoorObjectScene],generate_position,[])
	
	$Player.position = Grid[Vector2i(RNG.randi_range(0, Width - 1), RNG.randi_range(0, Depth - 1))].position
	$Player.position.y = 0.96
	
	var Objects = pick_random_objects(RNG)
	spawn_objects(objectSpawner,Objects,generate_position,Materials)
	var RareObjects = pick_rare_objects(RNG)
	spawn_objects(objectSpawner,RareObjects,generate_position,Materials)
	
func generate_position():
	var ObjectPosition = Grid[Vector2i(RNG.randi_range(0, Width - 1), RNG.randi_range(0, Depth - 1))].position
	ObjectPosition.y = 0
	return ObjectPosition

func clear_maze() -> void:
	for CellInstance in Grid.values():
		CellInstance.queue_free()
	Grid.clear()

func spawn_cells() -> void:
	for X in range(Width):
		for Z in range(Depth):
			var GridPos := Vector2i(X, Z)
			var CellInstance: Maze1Cell = CellScene.instantiate()
			add_child(CellInstance)
			CellInstance.position = Vector3(X * (CellSize+6.0), 0,Z * (CellSize+6.0))
			CellInstance.set_cell_size(CellSize)
			CellInstance.set_cell_height(RNG.randf_range(6.0,RNG.randf_range(15.0,25.0)))
			if RoofType == RoofTypes.Mix:
				if RNG.randi_range(0,4) != 0:
					CellInstance.remove_cieling()
			elif RoofType == RoofTypes.NoRoof:
				CellInstance.remove_cieling()
			elif RoofType == RoofTypes.Roof:
				pass
			if MaterialType == MaterialTypes.Ordered:
				for i in range(0,MaterialsForWalls.size()):
					CellInstance.set_material(MaterialsForWalls,i)
			else:
				CellInstance.set_material(MaterialsForWalls,(RNG.randi() % Materials.size()))
			
			Grid[GridPos] = CellInstance

func carve_maze(CurrentPos: Vector2i) -> void:
	var CurrentCell: Maze1Cell = Grid[CurrentPos]
	CurrentCell.Visited = true

	var UnvisitedNeighbors := get_unvisited_neighbors(CurrentPos)
	
	# Shuffle neighbors using the seeded RNG
	UnvisitedNeighbors.sort_custom(func(_A, _B): return RNG.randf() > 0.5)

	for Dir in UnvisitedNeighbors:
		var NextPos = CurrentPos + Dir
		var NextCell: Maze1Cell = Grid[NextPos]

		if not NextCell.Visited:
			CurrentCell.remove_wall(Dir)
			NextCell.remove_wall(Directions[Dir])
			carve_maze(NextPos)

func get_unvisited_neighbors(GridPos: Vector2i) -> Array[Vector2i]:
	var Neighbors: Array[Vector2i] = []
	for Dir in Directions.keys():
		var NeighborPos = GridPos + Dir
		if Grid.has(NeighborPos) and not Grid[NeighborPos].Visited:
			Neighbors.append(Dir)
	return Neighbors
