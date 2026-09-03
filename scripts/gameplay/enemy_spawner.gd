class_name EnemySpawner
extends RefCounted

const MINIMUM_DISTANCE := 215.0

static func get_spawn_position(player_position: Vector2, ground_y: float, min_x: float, max_x: float) -> Vector2:
	var direction := -1.0 if player_position.x > (min_x + max_x) * 0.5 else 1.0
	return Vector2(clampf(player_position.x + direction * MINIMUM_DISTANCE, min_x, max_x), ground_y)
