extends Label

@export var initialFade := 0.0



func _ready() -> void:
	modulate.a = initialFade


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Players"):
		
		var tween = create_tween()
		tween.tween_property(self, "modulate:a", 1.0, 1.0)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Players"):
		
		var tween = create_tween()
		tween.tween_property(self, "modulate:a", 0.0, 1.0)
