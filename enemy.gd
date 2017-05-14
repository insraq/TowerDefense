extends Area2D

var health setget set_health
var value
var move_speed = 500
var score_manager

func _ready():
	connect("body_enter", self, "_on_collision")
	set_fixed_process(true)
	set_process(true)
	score_manager = get_tree().get_root().get_node("Level/ScoreManager")
	if score_manager == null:
		OS.alert("`Level/ScoreManager` required", "Score Manager is null")
		get_tree().quit()

func _on_collision(body):
	body.destroy()
	var hit = body.hit || 1
	health -= hit
	if !get_node("ExplodeAnimation").is_playing():
		get_node("ExplodeAnimation").play("Explode")
	get_node("Sound").play("Explode", true)
	if health <= 0:
		hide()
		score_manager.set_money(score_manager.money + value)

func set_health(h):
	health = h
	value = h
	var sprite = get_node("Sprite")
	if health <= 5:
		sprite.set_texture(load("res://assets/towerDefense_tile245.png"))
	elif health <= 10:
		sprite.set_texture(load("res://assets/towerDefense_tile246.png"))
	elif health <= 15:
		sprite.set_texture(load("res://assets/towerDefense_tile247.png"))
	else:
		sprite.set_texture(load("res://assets/towerDefense_tile248.png"))
	

func is_enemy():
	return health > 0

func _process(delta):
	# Free the scene only after the sound has been played
	if health <= 0 && !get_node("ExplodeAnimation").is_active():
		queue_free()
	var parent = get_parent()
	# Follow if my parent is a Path2DFollow
	if !(parent extends PathFollow2D):
		OS.alert("`Path2DFollow/Enemy` is required", "Enemy parent is not Path2DFollow")
		return
	if parent.get_unit_offset() >= 1: # Enemy reaches the end
		hide()
		queue_free()
		parent.hide()
		parent.queue_free()
		if health > 0:
			score_manager.set_lives(score_manager.lives - 1)
		return
	parent.set_offset(parent.get_offset() + move_speed * delta)
