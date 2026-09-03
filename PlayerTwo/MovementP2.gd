extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0
const DRAG = 0.25
const ACCEL = 0.10
const DECCEL = 20

var inputCount = 10
var inRange = false
var satOn = false
@onready var inputCounter = $InputCounterP2
@onready var playerOne = get_node("../Player 1")

func _physics_process(delta: float) -> void:
	
	inputCounter.text = str(inputCount)
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jumptwo") and is_on_floor() and inputCount > 0 and not satOn:
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("lefttwo", "righttwo")
	if direction and inputCount > 0:
		velocity.x += direction * SPEED * ACCEL
		velocity.x = clamp(velocity.x, -(SPEED), SPEED)

	else:
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0, DECCEL)
		else:
			velocity.x = move_toward(velocity.x, 0, DECCEL * DRAG)

	move_and_slide()
	
	if is_on_ceiling() and direction != 0 and inputCount > 0:
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			var collider = collision.get_collider()
			
			if collider == playerOne:
				position.x += direction * SPEED * delta
				
	if ((Input.is_action_just_released("lefttwo") or Input.is_action_just_released("righttwo")) or (Input.is_action_just_pressed("jumptwo") and not satOn)) and inputCount > 0:
		inputCount -= 1

	if Input.is_action_just_pressed("jumpstarttwo") and inRange and playerOne.inputCount == 0 and inputCount > 0:
		playerOne.inputCount = 10	


func _on_jumpstart_area_p_1_body_entered(_body: Node2D) -> void:
	inRange = true

func _on_jumpstart_area_p_1_body_exited(_body: Node2D) -> void:
	inRange = false

func _on_jumper_p_1_body_entered(body: Node2D) -> void:
	if body == self:
		satOn = true

func _on_jumper_p_1_body_exited(body: Node2D) -> void:
	if body == self:
		satOn = false
