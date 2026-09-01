extends SceneTree


func _init() -> void:
	call_deferred("_run")


func _run() -> void:
	var stage: Node = load("res://scenes/levels/stage_01.tscn").instantiate()
	root.add_child(stage)
	await process_frame
	await process_frame

	var chris: AnimatedSprite2D = stage.get_node("Actors/Chris")
	var start_x := chris.position.x

	Input.action_press("move_right")
	for frame: int in 12:
		await process_frame

	if chris.position.x <= start_x:
		push_error("Chris did not move right in gameplay test.")
		quit(1)
		return

	if chris.animation != &"run":
		push_error("Expected Chris run animation, got %s." % chris.animation)
		quit(1)
		return

	Input.action_release("move_right")
	await process_frame
	stage._play_attack_test()
	await process_frame

	if chris.animation != &"attack":
		push_error("Expected Chris attack animation, got %s." % chris.animation)
		quit(1)
		return

	stage._process(1.0)
	await process_frame

	if chris.animation != &"idle":
		push_error("Expected Chris to return to idle, got %s." % chris.animation)
		quit(1)
		return

	print("Stage 01 gameplay smoke passed.")
	quit()
