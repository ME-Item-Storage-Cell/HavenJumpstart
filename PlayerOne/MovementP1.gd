extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var inputCount = 0

@onready var inputCounter = $InputCounterP1

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jumpone") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		inputCount += 1

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("leftone", "rightone")
	if direction:
		velocity.x = direction * SPEED
		inputCount += 1
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		inputCount += 1

	move_and_slide()
