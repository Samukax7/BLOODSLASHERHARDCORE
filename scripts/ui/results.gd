extends Control


func _ready() -> void:
	var stats := GameState.run_stats
	%TimeValue.text = str(stats.get("time", "00:00"))
	%KillsValue.text = str(stats.get("kills", 0))
	%ComboValue.text = str(stats.get("max_combo", 0))
	%RageValue.text = str(stats.get("rages", 0))
	%DamageValue.text = str(stats.get("damage_received", 0))
	%RankValue.text = str(stats.get("rank", "—"))
	%ContinueButton.grab_focus()


func _on_continue_button_pressed() -> void:
	SceneRouter.go_to_collaborator_cta()

