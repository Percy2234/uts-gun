extends Node3D

var buildings = [
	preload("res://Buildings/SmallBuilding1.tscn"),
	preload("res://Buildings/SmallBuilding2.tscn"),
	preload("res://Buildings/SmallBuilding3.tscn"),
	preload("res://Buildings/SmallBuilding4.tscn")
]

func _ready():
	randomize()
	generate_city()

func generate_city():
	for x in range(10):
		for z in range(10):

			var building = buildings.pick_random().instantiate()

			building.position = Vector3(
				x * 20,
				0,
				z * 20
			)

			add_child(building)
