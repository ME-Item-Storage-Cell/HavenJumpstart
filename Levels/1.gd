extends Node

@export var spawnPointP1 = Node2D
@export var player1 = Node2D

@export var spawnPointP2 = Node2D
@export var player2 = Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player1.global_position = spawnPointP1.global_position
	player2.global_position = spawnPointP2.global_position
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
