extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var turret_prefab = load("res://turret.tscn")
var score_manager
var turret

func _ready():
	set_process_input(true)
	
	score_manager = get_tree().get_root().get_node("Level/ScoreManager")
	if score_manager == null:
		OS.alert("`Level/ScoreManager` required", "Score Manager is null")
		get_tree().quit()
	
func _input_event(viewport, event, shape_idx):
	if event.type == InputEvent.MOUSE_BUTTON && event.is_pressed():
		on_click()
	
func hide_radius():
	if turret != null:
		turret.hide_radius()
			
func on_click():
	if has_node("holder"):
		turret = turret_prefab.instance()
		
		if score_manager.money < turret.cost:
			score_manager.highlight_money()
			return
			
		get_tree().call_group(SceneTree.GROUP_CALL_REALTIME, "Turrets", "hide_radius")
		score_manager.set_money(score_manager.money - turret.cost)
		
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