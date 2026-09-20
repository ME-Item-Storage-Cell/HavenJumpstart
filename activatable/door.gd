extends Node2D

@export var distanceMovedX := 0
@export var distanceMovedY := 0
@export var speed := 100.0

var starPos: Vector2
var targetPos: Vector2

func _ready() -> void:
	starPos = position
	targetPos = position
	

func activate(boolean: bool):
	print("check")
	if boolean:
		targetPos = starPos + Vector2(distanceMovedX, distanceMovedY)
	else:
		targetPos = starPos
		
func _process(delta: float) -> void:
	position = position.move_toward(targetPos, speed * delta)
