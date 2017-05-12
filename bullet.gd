extends KinematicBody2D

var speed = 2000
var direction

func _ready():
	set_fixed_process(true)
	get_node("Timer").connect("timeout", self, "destroy")

func set_direction(dir):
	direction = dir

func _fixed_process(delta):
	if direction != null:
		self.move(direction * speed * delta)

func destroy():
	hide()
	queue_free()