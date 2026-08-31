extends Control

const PROJECT_URL := "https://github.com/Samukax7/BLOODSLASHERHARDCORE"


func _ready() -> void:
	%ReplayButton.grab_focus()


func _on_project_button_pressed() -> void:
	OS.shell_open(PROJECT_URL)


func _on_replay_button_pressed() -> void:
	GameState.reset_run()
	SceneRouter.go_to_intro()


func _on_menu_button_pressed() -> void:
	GameState.reset_run()
	SceneRouter.go_to_main_menu()
