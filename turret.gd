tool
extends Node2D

export(String, "ONE", "TWO", "THREE") var type = "ONE" setget set_type
export(String, "DEMO", "WORKING") var mode = "WORKING" setget set_mode

var target_angel
var bullet_prefab = load("res://bullet.tscn")
var fire_delay = 100
var radius = 300
var cost = 50 setget set_cost
var last_fire = OS.get_ticks_msec()
onready var radius_node = get_node("Radius")

func _ready():
	set_process(true)
	get_node("Area2D/CollisionShape2D").get_shape().set_radius(radius)

func set_type(new_val):
	type = new_val
	if get_node("Base") == null || get_node("Gun") == null:
		return
	if type == "ONE":
		get_node("Base").set_texture(load("res://assets/towerDefense_tile180.png"))
		get_node("Gun").set_texture(load("res://assets/towerDefense_tile249.png"))
	elif type == "TWO":
		get_node("Base").set_texture(load("res://assets/towerDefense_tile181.png"))
		get_node("Gun").set_texture(load("res://assets/towerDefense_tile250.png"))
		var bs = get_node("Gun/BulletSpawner")
		var second_bs = bs.duplicate(true)
		var pos = bs.get_pos()
		bs.set_pos(pos + Vector2(15, 0))
		second_bs.set_pos(pos + Vector2(-15, 0))
		get_node("Gun").add_child(second_bs)
		self.cost = 150
		radius = 350
		fire_delay = 200
	elif type == "THREE":
		get_node("Base").set_texture(load("res://assets/towerDefense_tile182.png"))
		get_node("Gun").set_texture(load("res://assets/towerDefense_tile250_1.png"))
		var bs = get_node("Gun/BulletSpawner")
		var second_bs = bs.duplicate(true)
		var third_bs = bs.duplicate(true)
		var pos = bs.get_pos()
		bs.set_pos(pos + Vector2(-15, 0))
		second_bs.set_pos(pos + Vector2(15, 0))
		third_bs.set_pos(pos)
		get_node("Gun").add_child(second_bs)
		get_node("Gun").add_child(third_bs)
		self.cost = 300
		radius = 400
		fire_delay = 300

func set_mode(new_val):
	mode = new_val
	var hud = get_node("HUD")
	if hud == null:
		return
	if mode == "DEMO":
		hud.show()
	else:
		hud.hide()

func set_cost(new_val):
	cost = new_val
	get_node("HUD/Cost").set_text(str("$", cost))

func _process(delta):
	if mode == "DEMO":
		return
		
	var overlaps = get_node("Area2D").get_overlapping_areas()
	for o in overlaps:
		if o.has_method("is_enemy") && o.is_enemy() && OS.get_ticks_msec() - last_fire >= fire_delay:
			fire_at(o)
			
func get_radius():
	return radius_node

func hide_radius():
	if radius_node == null:
		return
	radius_node.hide()
	
func show_radius():
	if radius_node == null:
		return
	radius_node.set_scale(Vector2(radius / 500.0, radius / 500.0))
	radius_node.show()

func fire_at(target):
	last_fire = OS.get_ticks_msec()
	
	var gun = get_node("Gun")
	target_angel = gun.get_global_pos().angle_to_point(target.get_global_pos())
	gun.set_rot(target_angel)
	
	for bs in get_node("Gun").get_children():
		spawen_bullet(bs, target)

func spawen_bullet(bs, target):
	var bullet = bullet_prefab.instance()
	bullet.set_global_pos(bs.get_global_pos())
	bullet.set_direction((target.get_global_pos() - bs.get_global_pos()).normalized())
	get_tree().get_root().add_child(bullet)

