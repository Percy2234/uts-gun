extends CharacterBody2D

@export var player_id = 1
var speed = 250
var hp = 3
var bill = 0
var facing = Vector2.RIGHT
var can_shoot = true
var bullet_scene = preload("res://bullet.tscn")

var weapon = 0
var weapon_names = ["Pistol", "Shotgun", "Bazooka"]

func _ready():
	add_to_group("player")

func _physics_process(delta):
	var p = "p" + str(player_id) + "_"
	var dir = Input.get_vector(p + "left", p + "right", p + "up", p + "down")
	if dir != Vector2.ZERO:
		facing = dir.normalized()
	velocity = dir * speed
	move_and_slide()

	if Input.is_action_just_pressed(p + "switch"):
		weapon = (weapon + 1) % 3
		get_parent().update_ui()

	if Input.is_action_just_pressed(p + "shoot") and can_shoot:
		shoot()

func shoot():
	can_shoot = false
	var wait = 0.3
	if weapon == 0:
		spawn_bullet(facing, false)
	elif weapon == 1:
		for a in [-0.3, -0.15, 0, 0.15, 0.3]:
			spawn_bullet(facing.rotated(a), false)
		wait = 0.7
	elif weapon == 2:
		spawn_bullet(facing, true)
		wait = 1.2
	await get_tree().create_timer(wait).timeout
	can_shoot = true

func spawn_bullet(d, boom):
	var b = bullet_scene.instantiate()
	b.position = position + d * 30
	b.dir = d
	b.shooter = self
	b.boom = boom
	if boom:
		b.scale = Vector2(2.5, 2.5)
	get_parent().add_child(b)

func hit():
	hp -= 1
	get_parent().update_ui()
	if hp <= 0:
		get_parent().game_end(self, false)
