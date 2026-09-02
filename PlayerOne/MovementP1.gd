extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var inputCount = 10
var inRange = false
@onready var inputCounter = $InputCounterP1
@onready var playerTwo = get_node("../Player 2")

func _physics_process(delta: float) -> void:
	
	inputCounter.text = str(inputCount)
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jumpone") and is_on_floor() and inputCount > 0:
		velocity.y = JUMP_VELOCITY
		inputCount -= 1
		
		
	if (Input.is_action_just_pressed("leftone") or Input.is_action_just_pressed("rightone")) and inputCount > 0:
		inputCount -= 1

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("leftone", "rightone")
	if direction and inputCount > 0:
		velocity.x = direction * SPEED

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if Input.is_action_just_pressed("jumpstartone") and inRange and playerTwo.inputcount == 0:
		playerTwo.inputCount = 10
		print("help!")

	move_and_slide()


func _on_jumpstart_area_p_2_body_entered(_body: Node2D) -> void:
	inRange = true
	print("hi 2")

func _on_jumpstart_area_p_2_body_exited(_body: Node2D) -> void:
	inRange = false
	print("bye 2")
