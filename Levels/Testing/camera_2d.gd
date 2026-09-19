extends Camera2D

@export var player1: Node2D
@export var player2: Node2D

@export var margin := 200.0
@export var min_zoom := 0.5
@export var max_zoom := 1.5
@export var smooth_speed := 5.0
@export var vertical_smooth_speed := 10.0

func _ready() -> void:
	call_deferred("_set_initial_zoom")


func _set_initial_zoom() -> void:
	var midpoint = (player1.global_position + player2.global_position) / 2.0
	global_position = midpoint
	var distance_x = abs(player1.global_position.x - player2.global_position.x)
	var distance_y = abs(player1.global_position.y - player2.global_position.y)
	var viewport_size = get_viewport_rect().size
	var zoom_x = viewport_size.x / (distance_x + margin)
	var zoom_y = viewport_size.y / (distance_y + margin)
	var desired_zoom = min(zoom_x, zoom_y)
	desired_zoom = clamp(desired_zoom, min_zoom, max_zoom)

	zoom = Vector2(desired_zoom, desired_zoom)

func _process(delta):
	var midpoint = (player1.global_position + player2.global_position) / 2.0
	var new_x = lerp(global_position.x, midpoint.x, smooth_speed * delta)
	var new_y = lerp(global_position.y, midpoint.y, vertical_smooth_speed * delta)

	global_position = Vector2(new_x, new_y)

	var distance_x = abs(player1.global_position.x - player2.global_position.x)
	var distance_y = abs(player1.global_position.y - player2.global_position.y)
	var viewport_size = get_viewport_rect().size
	var zoom_x = viewport_size.x / (distance_x + margin)
	var zoom_y = viewport_size.y / (distance_y + margin)
	var desired_zoom = min(zoom_x, zoom_y)

	desired_zoom = clamp(desired_zoom, min_zoom, max_zoom)

	zoom = zoom.lerp(
		Vector2(desired_zoom, desired_zoom),
		smooth_speed * delta
	)
