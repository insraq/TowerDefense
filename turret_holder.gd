extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var turret_prefab = load("res://turret.tscn")
var score_manager
var turret

func _ready():
	set_process_input(true)
	set_process(true)	
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
		
func _process(delta):
	if turret != null:
		return
	if score_manager.selected_holder == self:
		get_node("holder").hide()
		get_node("holder_selected").show()
	else:
		get_node("holder").show()
		get_node("holder_selected").hide()

func construct(turret_to_build):
	if turret != null:
		return
	turret = turret_to_build
	turret.set_pos(get_node("holder").get_pos())
	get_node("holder").hide()
	get_node("holder_selected").hide()
	add_child(turret)

func on_click():
	if turret == null:
		get_tree().call_group(SceneTree.GROUP_CALL_REALTIME, "Turrets", "hide_radius")
		if score_manager.selected_holder == self:
			score_manager.selected_holder = null
		else:
			score_manager.selected_holder = self
	else:
		var visible = turret.get_radius().is_visible()
		get_tree().call_group(SceneTree.GROUP_CALL_REALTIME, "Turrets", "hide_radius")
		if !visible:
			turret.show_radius()	