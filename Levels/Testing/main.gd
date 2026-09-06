extends Node

@onready var spawnPointP1 = $SpawnP1
@onready var player1 = $Player1

@onready var spawnPointP2 = $SpawnP2
@onready var player2 = $Player2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player1.global_position = spawnPointP1.global_position
	player2.global_position = spawnPointP2.global_position
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
