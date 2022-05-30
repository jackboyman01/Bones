extends KinematicBody2D

export var MAX_SPEED = 500
export var ACCELARATION = 2000
var motion = Vector2.ZERO
var bones = 0

func _physics_process(delta):
	var axis = get_input_axis()
	if axis == Vector2.ZERO:
		apply_friction(ACCELARATION * delta)
	else:
		apply_movement(axis * ACCELARATION * delta)
	motion = move_and_slide(motion)
	
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("Bone"):
			collision.collider.queue_free()
			$Bone.play()
			bones += 1

func get_input_axis():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return axis.normalized()

func apply_friction(amount):
	if motion.length() > amount:
		motion -= motion.normalized() * amount
	else:
		motion = Vector2.ZERO
	if motion == Vector2.ZERO:
		$Sprite.frame = 0

func apply_movement(acceleration):
	$AnimationPlayer.play("Walk")
	motion += acceleration
	motion = motion.clamped(MAX_SPEED)
