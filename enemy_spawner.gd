extends Timer

var enemy_prefab = load("res://enemy.tscn")
var path_follow
var wave

func _ready():
	set_process(true)
	self.connect("timeout", self, "_spawn")
	path_follow = get_node("../PathFollow2D")
	
func set_wave(wave):
	self.wave = wave
	
func _process(delta):
	if wave.size() == 0 && get_tree().get_nodes_in_group("Enemies").size() == 0:
		get_tree().get_root().get_node("Level/ScoreManager").complete()
		get_tree().set_pause(true)
	
func _spawn():
	if path_follow == null:
		print("Cannot find path, not spwaning any enemies")
		return
	if wave == null:
		print("No enemy wave set, not spwaning any enemies")
		return
	if wave.size() == 0:
		print("Wave done.")
		return
	var enemy_health = wave[0]
	wave.pop_front()
	if enemy_health == 0:
		return
	var path = path_follow.duplicate()
	get_parent().add_child(path)
	var enemy = enemy_prefab.instance()
	enemy.health = enemy_health
	enemy.add_to_group("Enemies")
	path.add_child(enemy)