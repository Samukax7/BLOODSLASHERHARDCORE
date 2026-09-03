extends Control


func _ready() -> void:
	%StartButton.grab_focus()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey or event is InputEventJoypadButton or event is InputEventMouseButton:
		if event.pressed:
			AudioManager.unlock_audio()


func _on_start_button_pressed() -> void:
	AudioManager.unlock_audio()
	SceneRouter.go_to_intro()


func _on_controls_button_pressed() -> void:
	AudioManager.unlock_audio()
	%StatusLabel.text = "A/D MOVER  •  ESPAÇO SALTAR  •  J/K ATACAR  •  SHIFT ESQUIVAR  •  R FÚRIA"


func _on_options_button_pressed() -> void:
	AudioManager.unlock_audio()
	%StatusLabel.text = "OPÇÕES CHEGAM NO MILESTONE 1"


func _on_credits_button_pressed() -> void:
	AudioManager.unlock_audio()
	%StatusLabel.text = "CRIADO POR SAMUKAX7"
