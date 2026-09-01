extends Control

const CHRIS_IDLE := preload("res://assets/sprites/Chris/idle/idle_spritesheet.png")
const CHRIS_RUN := preload("res://assets/sprites/Chris/run/spritesheet run.png")
const CHRIS_ATTACK := preload("res://assets/sprites/Chris/atack basico/atack basico spritesheet.png")
const IMP_SPAWN := preload("res://assets/sprites/enemy/demonio vermelho/imp_spawn_spritesheet.png")

const CHRIS_FRAME := Vector2i(126, 126)
const IMP_FRAME := Vector2i(128, 128)


func _ready() -> void:
	_setup_chris()
	_setup_imp_spawn()
	%FinishButton.grab_focus()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		SceneRouter.go_to_main_menu()


func _on_finish_button_pressed() -> void:
	GameState.run_stats = {
		"time": "00:00",
		"kills": 0,
		"max_combo": 0,
		"rages": 0,
		"damage_received": 0,
		"rank": "—",
	}
	SceneRouter.go_to_results()


func _setup_chris() -> void:
	var frames := SpriteFrames.new()
	_add_animation(frames, "idle", CHRIS_IDLE, CHRIS_FRAME, 5, 7.0, true)
	_add_animation(frames, "run", CHRIS_RUN, CHRIS_FRAME, 8, 10.0, true)
	_add_animation(frames, "attack", CHRIS_ATTACK, CHRIS_FRAME, 16, 14.0, true)
	%Chris.sprite_frames = frames
	%Chris.play("idle")


func _setup_imp_spawn() -> void:
	var frames := SpriteFrames.new()
	_add_animation(frames, "spawn", IMP_SPAWN, IMP_FRAME, 8, 8.0, false)
	%ImpSpawn.sprite_frames = frames
	%ImpSpawn.play("spawn")
	%ImpSpawn.animation_finished.connect(_on_imp_spawn_finished)


func _on_imp_spawn_finished() -> void:
	var frames := SpriteFrames.new()
	_add_animation(
		frames,
		"idle",
		preload("res://assets/sprites/enemy/demonio vermelho/imp_idle_spritesheet.png"),
		IMP_FRAME,
		6,
		7.0,
		true
	)
	%ImpSpawn.sprite_frames = frames
	%ImpSpawn.play("idle")


func _add_animation(
	frames: SpriteFrames,
	animation_name: StringName,
	sheet: Texture2D,
	frame_size: Vector2i,
	frame_count: int,
	speed: float,
	loops: bool
) -> void:
	frames.add_animation(animation_name)
	frames.set_animation_speed(animation_name, speed)
	frames.set_animation_loop(animation_name, loops)

	for frame_index in frame_count:
		var atlas := AtlasTexture.new()
		atlas.atlas = sheet
		atlas.region = Rect2i(frame_index * frame_size.x, 0, frame_size.x, frame_size.y)
		frames.add_frame(animation_name, atlas)
