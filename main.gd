extends Node2D

@onready var p1 = $Player1
@onready var p2 = $Player2
@onready var label = $UI/Label
var max_bill = 20000
var over = false

func _ready():
	update_ui()

func _process(delta):
	if over and Input.is_key_pressed(KEY_R):
		get_tree().reload_current_scene()

func update_ui():
	label.text = "P1  HP:" + str(p1.hp) + "  Bill:$" + str(p1.bill) + "          P2  HP:" + str(p2.hp) + "  Bill:$" + str(p2.bill)
	if p1.bill >= max_bill:
		game_end(p1, true)
	elif p2.bill >= max_bill:
		game_end(p2, true)

func game_end(loser, expelled):
	if over:
		return
	over = true
	var loser_name = "P1" if loser == p1 else "P2"
	var winner_name = "P2" if loser == p1 else "P1"
	if expelled:
		label.text = loser_name + " got EXPELLED! " + winner_name + " WINS!!  (R to restart)"
	else:
		label.text = winner_name + " WINS!!!!!   (R to restart)"
