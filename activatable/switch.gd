extends Node2D

@export var connectedObject: Node2D
@onready var animated_sprite_2d: AnimatedSprite2D = $SpriteButton
var isActive = false


func _on_area_button_body_entered(body: Node2D) -> void:
	if body.is_in_group("Players") and not isActive:
		isActive = true
		_use_switch()

func _on_area_button_body_exited(body: Node2D) -> void:
	if body.is_in_group("Players") and isActive:
		isActive = not isActive
		_use_switch()
	

func _use_switch():
	if isActive:
		animated_sprite_2d.play("activate")
	else:
		animated_sprite_2d.play_backwards("activate")
		
	await animated_sprite_2d.animation_finished
	connectedObject.activate(isActive)
