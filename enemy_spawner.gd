extends Timer

var enemy_prefab = load("res://enemy.tscn")
var path_follow
var wave

func _ready():
	self.connect("timeout", self, "_spawn")
	path_follow = get_node("../PathFollow2D")
	
func set_wave(wave):
	self.wave = wave
	
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
	path.add_child(enemy)