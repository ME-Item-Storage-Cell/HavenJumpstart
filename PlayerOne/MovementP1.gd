extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -350.0
const DRAG = 0.25
const ACCEL = 0.10
const DECCEL = 15

var inputCount = 10
var inRange = false
var satOn = false
@onready var inputCounter = $InputCounterP1
@onready var playerTwo = $"../Player2"

func _physics_process(delta: float) -> void:
	
	inputCounter.text = str(inputCount)
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jumpone") and is_on_floor() and inputCount > 0 and not satOn:
		velocity.y += JUMP_VELOCITY

	var direction := Input.get_axis("leftone", "rightone")
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
			
			if collider == playerTwo:
				position.x += direction * SPEED * delta
				
	if ((Input.is_action_just_released("leftone") or Input.is_action_just_released("rightone")) or (Input.is_action_just_released("jumpone") and not satOn)) and inputCount > 0:
		inputCount -= 1
	
	if Input.is_action_just_pressed("jumpstartone") and inRange and playerTwo.inputCount == 0 and inputCount != 0:
		playerTwo.inputCount = 10
		
func _on_jumpstart_area_p_2_body_entered(body: Node2D) -> void:
	if body == self:
		inRange = true

func _on_jumpstart_area_p_2_body_exited(body: Node2D) -> void:
	if body == self:
		inRange = false

func _on_jumper_p_2_body_entered(body: Node2D) -> void:
	if body == self:
		satOn = true

func _on_jumper_p_2_body_exited(body: Node2D) -> void:
	if body == self:
		satOn = false
