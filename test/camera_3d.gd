extends Camera3D

var speed = 20.0

func _process(delta):

	if Input.is_action_pressed("ui_up"):
		position.z -= speed * delta

	if Input.is_action_pressed("ui_down"):
		position.z += speed * delta

	if Input.is_action_pressed("ui_left"):
		position.x -= speed * delta

	if Input.is_action_pressed("ui_right"):
		position.x += speed * delta
