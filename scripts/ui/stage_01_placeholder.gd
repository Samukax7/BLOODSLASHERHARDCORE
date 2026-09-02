extends Control

const CHRIS_IDLE := preload("res://assets/sprites/Chris/idle/idle_spritesheet.png")
const CHRIS_ENTRY := preload("res://assets/sprites/Chris/intro/chris_entry_10f_style_locked_v4_preview.png")
const CHRIS_RUN := preload("res://assets/sprites/Chris/run/spritesheet run.png")
const CHRIS_ATTACK := preload("res://assets/sprites/Chris/atack basico/atack basico spritesheet.png")
const CHRIS_HURT := preload("res://assets/sprites/Chris/hurt/chris_hurt_4f_style_locked_preview.png")
const CHRIS_DEATH := preload("res://assets/sprites/Chris/death/chris_death_12f_style_locked_v2_preview.png")
const CHRIS_JUMP := preload("res://assets/sprites/Chris/jump/jump spritesheet.png")
const CHRIS_JUMP_ATTACK := preload("res://assets/sprites/Chris/jump atack/jump atack spritesheet.png")
const IMP_SPAWN := preload("res://assets/sprites/enemy/demonio vermelho/imp_spawn_spritesheet.png")
const IMP_IDLE := preload("res://assets/sprites/enemy/demonio vermelho/imp_idle_spritesheet.png")
const PURSUER := preload("res://assets/sprites/enemy/perseguidor/dog_persuit_static.png")
const COLLECTOR := preload("res://assets/sprites/enemy/cobrador/minotaurus_static.png")
const CHRIS_FRAME := Vector2i(126, 126)
const IMP_SPAWN_FRAME := Vector2i(192, 1024)
const IMP_IDLE_FRAME := Vector2i(128, 128)
const GROUND_Y := 290.0
const PLAYER_MIN_X := 64.0
const PLAYER_MAX_X := 565.0
const PLAYER_GROUND_Y := 285.0
const JUMP_VELOCITY := -285.0
const GRAVITY := 680.0
const IMP_SCALE := 0.205

var entering := true
var attacking := false
var jumping := false
var hurt := false
var dead := false
var attack_time := 0.0
var hurt_time := 0.0
var vertical_velocity := 0.0
var touch_direction := 0.0
var health := 100.0
var kills := 0
var spawn_time := 1.2
var spawn_index := 0
var enemies: Array[Dictionary] = []


func _ready() -> void:
	_setup_chris()
	%HealthBar.value = health
	_refresh_hud()


func _process(delta: float) -> void:
	if attacking:
		attack_time -= delta
		if attack_time <= 0.0:
			attacking = false
	if entering:
		return
	if dead:
		return
	if hurt:
		hurt_time -= delta
		if hurt_time <= 0.0:
			hurt = false
	_move_player(delta)
	_spawn_next(delta)
	_update_enemies(delta)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		SceneRouter.go_to_main_menu()
	elif event.is_action_pressed("jump"):
		_jump()
	elif event.is_action_pressed("attack_light"):
		_attack()


func _setup_chris() -> void:
	var frames := SpriteFrames.new()
	_add_animation(frames, "entry", CHRIS_ENTRY, Vector2i(87, 112), 10, 10.0, false)
	_add_animation(frames, "idle", CHRIS_IDLE, CHRIS_FRAME, 6, 7.0, true)
	_add_animation(frames, "run", CHRIS_RUN, CHRIS_FRAME, 8, 10.0, true)
	_add_animation(frames, "attack", CHRIS_ATTACK, Vector2i(252, 126), 8, 12.0, false)
	_add_animation(frames, "hurt", CHRIS_HURT, Vector2i(111, 126), 4, 12.0, false)
	_add_animation(frames, "death", CHRIS_DEATH, Vector2i(73, 112), 12, 10.0, false)
	_add_animation(frames, "jump", CHRIS_JUMP, Vector2i(109, 112), 6, 12.0, false)
	_add_animation(frames, "jump_attack", CHRIS_JUMP_ATTACK, Vector2i(109, 112), 6, 12.0, false)
	%Chris.sprite_frames = frames
	%Chris.animation_finished.connect(_on_chris_animation_finished)
	%Chris.play(&"entry")


func _add_animation(frames: SpriteFrames, name: StringName, sheet: Texture2D, cell: Vector2i, count: int, fps: float, loop: bool) -> void:
	frames.add_animation(name)
	frames.set_animation_speed(name, fps)
	frames.set_animation_loop(name, loop)
	for index in count:
		var atlas := AtlasTexture.new()
		atlas.atlas = sheet
		atlas.region = Rect2i(index * cell.x, 0, cell.x, cell.y)
		frames.add_frame(name, atlas)


func _on_chris_animation_finished() -> void:
	if %Chris.animation == &"entry":
		entering = false
		%Chris.play(&"idle")
	elif %Chris.animation == &"hurt" and not dead:
		hurt = false
	elif %Chris.animation == &"jump_attack" and jumping and not dead:
		%Chris.play(&"jump")


func _move_player(delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")
	if is_zero_approx(direction):
		direction = touch_direction
	if not is_zero_approx(direction) and not hurt:
		%Chris.position.x = clampf(%Chris.position.x + direction * 115.0 * delta, PLAYER_MIN_X, PLAYER_MAX_X)
		%Chris.flip_h = direction < 0.0
	_update_jump(delta)
	if hurt:
		return
	if jumping:
		if not attacking:
			%Chris.play(&"jump")
		return
	if not attacking:
		%Chris.play(&"idle" if is_zero_approx(direction) else &"run")


func _jump() -> void:
	if entering or dead or hurt or jumping:
		return
	jumping = true
	vertical_velocity = JUMP_VELOCITY
	%Chris.play(&"jump")


func _update_jump(delta: float) -> void:
	if not jumping:
		return
	vertical_velocity += GRAVITY * delta
	%Chris.position.y += vertical_velocity * delta
	if %Chris.position.y >= PLAYER_GROUND_Y:
		%Chris.position.y = PLAYER_GROUND_Y
		vertical_velocity = 0.0
		jumping = false
		if not attacking:
			%Chris.play(&"idle")


func _spawn_next(delta: float) -> void:
	spawn_time -= delta
	if spawn_time > 0.0 or enemies.size() >= 4:
		return
	var enemy_type: String = ["imp", "pursuer", "collector"][spawn_index % 3]
	spawn_index += 1
	spawn_time = 3.5
	_spawn_enemy(enemy_type)


func _spawn_enemy(enemy_type: String) -> void:
	var actor := Node2D.new()
	actor.position = EnemySpawner.get_spawn_position(%Chris.position, GROUND_Y, 50.0, 590.0)
	%Enemies.add_child(actor)
	var sprite: Node2D
	if enemy_type == "imp":
		var imp := AnimatedSprite2D.new()
		var frames := SpriteFrames.new()
		_add_animation(frames, "spawn", IMP_SPAWN, IMP_SPAWN_FRAME, 8, 8.0, false)
		imp.sprite_frames = frames
		imp.play(&"spawn")
		imp.scale = Vector2.ONE * IMP_SCALE
		sprite = imp
	else:
		var static_sprite := Sprite2D.new()
		static_sprite.texture = PURSUER if enemy_type == "pursuer" else COLLECTOR
		static_sprite.scale = Vector2.ONE * (0.28 if enemy_type == "pursuer" else 0.22)
		sprite = static_sprite
	actor.add_child(sprite)
	var hit_flash := Polygon2D.new()
	hit_flash.polygon = PackedVector2Array([Vector2(-24, -40), Vector2(24, -40), Vector2(24, 6), Vector2(-24, 6)])
	hit_flash.color = Color(1, 0.04, 0.02, 0)
	actor.add_child(hit_flash)
	var stats := _stats(enemy_type)
	enemies.append({"type": enemy_type, "actor": actor, "sprite": sprite, "flash": hit_flash, "health": stats.health, "speed": stats.speed, "damage": stats.damage, "range": stats.range, "cooldown": 0.8, "spawn": 1.0 if enemy_type == "imp" else 0.0, "hit": 0.0})


func _stats(enemy_type: String) -> Dictionary:
	var difficulty := 1.0 + floori(kills / 5.0) * 0.2
	match enemy_type:
		"imp": return {"health": 20.0, "speed": 23.0, "damage": 3.0 * difficulty, "range": 58.0}
		"pursuer": return {"health": 30.0, "speed": 42.0, "damage": 30.0 * difficulty, "range": 64.0}
		_: return {"health": 50.0, "speed": 15.0, "damage": 50.0 * difficulty, "range": 78.0}


func _update_enemies(delta: float) -> void:
	for enemy in enemies.duplicate():
		if not is_instance_valid(enemy.actor):
			enemies.erase(enemy)
			continue
		if enemy.spawn > 0.0:
			enemy.spawn -= delta
			if enemy.spawn <= 0.0:
				var frames := SpriteFrames.new()
				_add_animation(frames, "idle", IMP_IDLE, IMP_IDLE_FRAME, 6, 7.0, true)
				enemy.sprite.sprite_frames = frames
				enemy.sprite.play(&"idle")
			continue
		enemy.cooldown = maxf(0.0, enemy.cooldown - delta)
		var distance := absf(enemy.actor.position.x - %Chris.position.x)
		var direction := signf(%Chris.position.x - enemy.actor.position.x)
		var speed: float = enemy.speed
		if enemy.type == "pursuer" and distance < 180.0:
			speed *= 2.35
		if distance > enemy.range:
			enemy.actor.position.x = clampf(enemy.actor.position.x + direction * speed * delta, 50.0, 590.0)
		elif enemy.cooldown <= 0.0:
			enemy.cooldown = 1.0 if enemy.type == "imp" else 1.3
			_damage_player(enemy.damage)
		enemy.actor.position.y = GROUND_Y
		_flash_enemy(enemy, delta)


func _attack() -> void:
	if entering or attacking or hurt or dead:
		return
	attacking = true
	attack_time = 6.0 / 12.0 if jumping else 8.0 / 12.0
	%Chris.play(&"jump_attack" if jumping else &"attack")
	for enemy in enemies.duplicate():
		if enemy.spawn <= 0.0 and absf(enemy.actor.position.x - %Chris.position.x) <= 118.0:
			enemy.health -= 10.0
			enemy.hit = 0.18
			enemy.sprite.modulate = Color(1, 0.12, 0.12, 1)
			enemy.flash.color = Color(1, 0.04, 0.02, 0.72)
			if enemy.health <= 0.0:
				_kill(enemy)


func _flash_enemy(enemy: Dictionary, delta: float) -> void:
	if enemy.hit <= 0.0:
		return
	enemy.hit -= delta
	if enemy.hit <= 0.0:
		enemy.sprite.modulate = Color.WHITE
		enemy.flash.color = Color(1, 0.04, 0.02, 0)


func _kill(enemy: Dictionary) -> void:
	enemies.erase(enemy)
	kills += 1
	_refresh_hud()
	var tween := create_tween()
	tween.tween_property(enemy.actor, "modulate:a", 0.0, 0.28)
	tween.parallel().tween_property(enemy.actor, "scale", Vector2.ONE * 0.55, 0.28)
	tween.tween_callback(enemy.actor.queue_free)


func _damage_player(amount: float) -> void:
	if dead:
		return
	health = maxf(0.0, health - amount)
	var tween := create_tween()
	tween.tween_property(%HealthBar, "value", health, 0.18)
	%Chris.modulate = Color(1, 0.25, 0.25, 1)
	tween.parallel().tween_property(%Chris, "modulate", Color.WHITE, 0.18)
	if health <= 0.0:
		dead = true
		attacking = false
		jumping = false
		vertical_velocity = 0.0
		%Chris.position.y = PLAYER_GROUND_Y
		%Chris.play(&"death")
		%GameplayStatus.text = "CHRIS CAIU. Use RESULTADO para encerrar este teste."
	else:
		hurt = true
		hurt_time = 4.0 / 12.0
		%Chris.play(&"hurt")


func _refresh_hud() -> void:
	%KillCounter.text = "MORTES  %03d" % kills
	%GameplayStatus.text = "TESTE DE COMBATE  |  DIFICULDADE %d\nATAQUE perto do inimigo. Vermelho = acerto." % (1 + int(kills / 5))


func _on_finish_button_pressed() -> void:
	GameState.run_stats = {"time": "00:00", "kills": kills, "max_combo": 0, "rages": 0, "damage_received": int(100 - health), "rank": "—"}
	SceneRouter.go_to_results()

func _on_move_left_button_down() -> void:
	touch_direction = -1.0

func _on_move_left_button_up() -> void:
	if touch_direction < 0.0:
		touch_direction = 0.0

func _on_move_right_button_down() -> void:
	touch_direction = 1.0

func _on_move_right_button_up() -> void:
	if touch_direction > 0.0:
		touch_direction = 0.0

func _on_attack_button_down() -> void:
	_attack()

func _on_jump_button_down() -> void:
	_jump()
