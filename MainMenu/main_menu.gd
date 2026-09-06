extends Control

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("jumpone") or Input.is_action_just_pressed("jumptwo"):
		get_tree().change_scene_to_file("res://Levels/Testing/main.tscn")


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/Testing/main.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()
