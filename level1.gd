extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	var turret_prefab = load("res://turret.tscn")
	for i in get_tree().get_nodes_in_group("Prebuilt"):
		i.construct(turret_prefab.instance())
	
	get_node("Path2D/EnemySpawner").set_wave([
		1,1,1,1,1,1,1,1,1,1,
		0,0,0,
		2,2,2,2,2,2,2,2,2,2,
		0,0,0,
		5,5,5,5,5,5,5,5,5,5,
		0,0,0,0,0,
		10,10,10,10,10,10,10,10,10,10,
		0,0,0,
		15,15,15,15,15,15,15,15,15,15,
		0,0,0,
		20,20,20,20,20,20,
		0,0,0,
		30,30,30,30,30,30,
		0,0,0,
		40,40,40,40,40,40
	])