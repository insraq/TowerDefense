extends Node2D

var money = 150 setget set_money
var lives = 5 setget set_lives
var last_money_highlight = 0
var menu

func _ready():
	set_money(money)
	set_lives(lives)
	get_node("Overlay/Button").connect("pressed", self, "reload")
	
func set_money(new_val):
	money = new_val
	get_node("Money").set_text(str("Money: ", money))
	if OS.get_unix_time() - last_money_highlight >= 2:
		get_node("Money").set("custom_colors/font_color", Color("#FFFFFF"))
	
func highlight_money():
	last_money_highlight = OS.get_unix_time()
	get_node("Money").set("custom_colors/font_color", Color("#EF4836"))
	
func reload():
	get_tree().reload_current_scene()
	get_tree().set_pause(false)

func set_lives(new_val):
	lives = new_val
	if lives <= 0:
		get_node("Overlay").show()
		get_tree().set_pause(true)
	get_node("Lives").set_text(str("Lives: ", lives))