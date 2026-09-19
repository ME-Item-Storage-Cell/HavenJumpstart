extends Node2D

@export var distanceMovedX := 0
@export var distanceMovedY := 0


func activate(boolean: bool):
	print("check")
	if boolean:
		position.y += distanceMovedY
		position.x += distanceMovedX
	else:
		position.y -= distanceMovedY
		position.x -= distanceMovedX
