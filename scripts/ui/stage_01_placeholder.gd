extends Control

const CHRIS_IDLE := preload("res://assets/sprites/Chris/idle/idle_spritesheet.png")
const CHRIS_RUN := preload("res://assets/sprites/Chris/run/spritesheet run.png")
const CHRIS_ATTACK := preload("res://assets/sprites/Chris/atack basico/atack basico spritesheet.png")
const IMP_SPAWN := preload("res://assets/sprites/enemy/demonio vermelho/imp_spawn_spritesheet.png")

const CHRIS_FRAME := Vector2i(126, 126)
const IMP_FRAME := Vector2i(128, 128)
const PLAYER_SPEED := 115.0
const PLAYER_MIN_X := 64.0
const PLAYER_MAX_X := 565.0
const ATTACK_DURATION := 16.0 / 18.0

var is_attacking := false
var current_chris_animation := &"idle"
var attack_timer := 0.0


func _ready() -> void:
	_setup_chris()
	_setup_imp_spawn()
	%FinishButton.grab_focus()
	_update_gameplay_status()


func _process(delta: float) -> void:
	if is_attacking:
		attack_timer -= delta
		if attack_timer <= 0.0:
			_finish_attack_test()
	_update_player_test(delta)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		SceneRouter.go_to_main_menu()
	elif event.is_action_pressed("attack_light"):
		_play_attack_test()


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
	_add_animation(frames, "attack", CHRIS_ATTACK, CHRIS_FRAME, 16, 18.0, false)
	%Chris.sprite_frames = frames
	%Chris.animation_finished.connect(_on_chris_animation_finished)
	_play_chris(&"idle")


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


func _update_player_test(delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")
	if not is_zero_approx(direction):
		%Chris.position.x = clampf(%Chris.position.x + direction * PLAYER_SPEED * delta, PLAYER_MIN_X, PLAYER_MAX_X)
		%Chris.flip_h = direction < 0.0

	if is_attacking:
		_update_gameplay_status()
		return

	if is_zero_approx(direction):
		_play_chris(&"idle")
	else:
		_play_chris(&"run")


func _play_attack_test() -> void:
	if is_attacking:
		return
	is_attacking = true
	attack_timer = ATTACK_DURATION
	_play_chris(&"attack")


func _on_chris_animation_finished() -> void:
	if %Chris.animation == &"attack":
		_finish_attack_test()


func _finish_attack_test() -> void:
	if not is_attacking:
		return
	is_attacking = false
	attack_timer = 0.0
	current_chris_animation = &""
	_update_player_test(0.0)


func _play_chris(animation_name: StringName) -> void:
	if current_chris_animation == animation_name:
		return
	current_chris_animation = animation_name
	%Chris.play(animation_name)
	_update_gameplay_status()


func _update_gameplay_status() -> void:
	var imp_animation := "spawn"
	if is_instance_valid(%ImpSpawn) and %ImpSpawn.sprite_frames:
		imp_animation = str(%ImpSpawn.animation)

	%GameplayStatus.text = "GAMEPLAY TEST  |  CHRIS: %s  |  IMP: %s\nA/D mover  |  J ataque  |  ESC menu" % [
		str(%Chris.animation).to_upper(),
		imp_animation.to_upper(),
	]
