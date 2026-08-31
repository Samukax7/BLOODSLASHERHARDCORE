extends Control


func _ready() -> void:
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

