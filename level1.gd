extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	get_tree().call_group(SceneTree.GROUP_CALL_DEFAULT, "Prebuilt", "on_click")
	get_node("Path2D/EnemySpawner").set_wave([
		1,1,1,1,1,1,1,1,1,1,
		0,0,0,
		2,2,2,2,2,2,2,2,2,2,
		0,0,0,
		5,5,5,5,5,5,5,5,5,5,
		0,0,0,0,0,
		5,5,5,5,5,5,5,5,5,5,
		0,0,0,
		10,10,10,10,10,10,10,10,10,10,
		0,0,0,
		15,15,15,15,15,15,15,15,15,15,
	])