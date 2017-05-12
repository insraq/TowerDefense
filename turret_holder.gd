extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var turret_prefab = load("res://turret.tscn")
var turret

func _ready():
	set_process_input(true)
	
func _input_event(viewport, event, shape_idx):
	if event.type == InputEvent.MOUSE_BUTTON && event.is_pressed():
		on_click()
	
func hide_radius():
	if turret != null:
		turret.hide_radius()
			
func on_click():
	if has_node("holder"):
		print("Build")
		turret = turret_prefab.instance()
		turret.set_pos(get_node("holder").get_pos())
		add_child(turret)
		get_node("holder").queue_free()
	else:
		print("Upgrade")
		if turret.get_radius().is_visible():
			turret.hide_radius()
		else:
			get_tree().call_group(SceneTree.GROUP_CALL_REALTIME, "Turrets", "hide_radius")
			turret.show_radius()