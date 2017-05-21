extends Node2D

var money = 50 setget set_money
var lives = 5 setget set_lives
var menu
var selected_holder setget set_selected_holder

func _ready():
	set_money(money)
	set_lives(lives)
	get_node("Overlay/Button").connect("pressed", self, "reload")
	get_node("LinkButton").connect("pressed", self, "reload")
	get_node("NextLevel/Again").connect("pressed", self, "reload")
	get_node("HUD/Turret/TextureButton").connect("pressed", self, "construct", [get_node("HUD/Turret")])
	get_node("HUD/Turret1/TextureButton1").connect("pressed", self, "construct", [get_node("HUD/Turret1")])
	get_node("HUD/Turret2/TextureButton2").connect("pressed", self, "construct", [get_node("HUD/Turret2")])
	
func set_selected_holder(holder):
	selected_holder = holder
	if holder == null:
		get_node("HUD").hide()
	else:
		get_node("HUD").show()
		
func complete():
	get_node("SamplePlayer2D").play("done")
	get_node("NextLevel").show()
		
func construct(target):
	if selected_holder == null:
		return
	if money < target.cost:
		get_node("SamplePlayer2D").play("coin")
		return
	self.money -= target.cost
	var turret = target.duplicate()
	turret.mode = "WORKING"
	selected_holder.construct(turret)
	get_node("HUD").hide()
	
func set_money(new_val):
	money = new_val
	get_node("Money").set_text(str("$", money))
	
func reload():
	get_tree().reload_current_scene()
	get_tree().set_pause(false)

func set_lives(new_val):
	lives = new_val
	if lives <= 0:
		get_node("Overlay").show()
		get_tree().set_pause(true)
	get_node("Lives").set_text(str("Lives: ", lives))