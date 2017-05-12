extends Node2D

var target_angel
var bullet_prefab = load("res://bullet.tscn")
var fire_delay = 100
var radius = 300
var last_fire = OS.get_ticks_msec()
onready var radius_node = get_node("Radius")

func _ready():
	set_process(true)
	get_node("Area2D/CollisionShape2D").get_shape().set_radius(radius)

func _process(delta):
	var overlaps = get_node("Area2D").get_overlapping_areas()
	for o in overlaps:
		if o.has_method("is_enemy") && o.is_enemy() && OS.get_ticks_msec() - last_fire >= fire_delay:
			fire_at(o)
			
func get_radius():
	return radius_node

func hide_radius():
	radius_node.hide()
	
func show_radius():
	radius_node.set_scale(Vector2(radius / 500.0, radius / 500.0))
	radius_node.show()

func fire_at(target):
	last_fire = OS.get_ticks_msec()
	
	var gun = get_node("Gun")
	target_angel = gun.get_global_pos().angle_to_point(target.get_global_pos())
	gun.set_rot(target_angel)
	
	var bs = get_node("Gun/BulletSpawner")
	var bullet = bullet_prefab.instance()
	
	bullet.set_global_pos(bs.get_global_pos())
	bullet.set_direction((target.get_global_pos() - bs.get_global_pos()).normalized())
	get_tree().get_root().add_child(bullet)

