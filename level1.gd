extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var enemy_prefab = load("res://enemy.tscn")

func _ready():
	get_tree().call_group(SceneTree.GROUP_CALL_DEFAULT, "Prebuilt", "on_click")
	get_node("Timer").connect("timeout", self, "_spawn")
	
func _spawn():
	var path_follow = get_node("Path2D/PathFollow2D").duplicate()
	get_node("Path2D").add_child(path_follow)
	path_follow.add_child(enemy_prefab.instance())