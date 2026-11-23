extends Area2D

var speed = 600
var dir = Vector2.ZERO
var shooter
var life = 2.0
var boom = false

func _physics_process(delta):
	position += dir * speed * delta
	life -= delta
	if life <= 0:
		queue_free()

func _on_body_entered(body):
	if body == shooter:
		return
	if boom:
		explode()
	elif body.is_in_group("player"):
		body.hit()
	elif body.is_in_group("wall"):
		shooter.bill += body.cost
		body.queue_free()
		get_parent().update_ui()
	queue_free()

func explode():
	for w in get_tree().get_nodes_in_group("wall"):
		if w.global_position.distance_to(global_position) < 130 and not w.is_queued_for_deletion():
			shooter.bill += w.cost
			w.queue_free()
	for p in get_tree().get_nodes_in_group("player"):
		if p != shooter and p.global_position.distance_to(global_position) < 130:
			p.hit()
	get_parent().update_ui()
