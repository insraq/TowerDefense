extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var health = 10

func _ready():
	connect("body_enter", self, "_on_collision")
	set_fixed_process(true)

func _on_collision(body):
	body.destroy()
	health -= 1
	if !get_node("ExplodeAnimation").is_playing():
		get_node("ExplodeAnimation").play("Explode")
	if (health <= 0):
		hide()
		queue_free()
		
func is_enemy():
	return true

func _fixed_process(delta):
	var parent = get_parent()
	# Follow if my parent is a Path2DFollow
	if !parent.has_method("get_offset"):
		return
	if parent.get_unit_offset() >= 1:
		hide()
		queue_free()
		parent.hide()
		parent.queue_free()
		return
	parent.set_offset(parent.get_offset() + 500 * delta)