extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -50.0


@onready var sprite: Sprite2D = $Sprite2D


func _physics_process(delta: float) -> void:
	# TODO: all of this needs work to make it more like underwater diving
	# and less like a regular platformer with jumping etc
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY

	# TODO: see above, needs work
	var direction_lr := Input.get_axis("ui_left", "ui_right")
	var direction_ud := Input.get_axis("ui_up", "ui_down")
	if direction_lr:
		velocity.x = direction_lr * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction_ud:
		velocity.y = direction_ud * 50
	else:
		pass

	move_and_slide()
	
	if direction_lr < 0:
		sprite.flip_h = true
	elif direction_lr > 0:
		sprite.flip_h = false
