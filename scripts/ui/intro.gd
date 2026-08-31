extends Control

const PANELS := [
	{"text": "Ele viveu rápido. Brigou mais do que devia.", "color": Color("301419"), "mark": "I"},
	{"text": "Uma noite, a estrada finalmente cobrou a dívida.", "color": Color("20171a"), "mark": "II"},
	{"text": "Quando abriu os olhos, o asfalto ainda queimava.\nMas aquele não era mais o seu mundo.", "color": Color("3b1712"), "mark": "III"},
	{"text": "Disseram que o Inferno seria eterno.", "color": Color("260b0d"), "mark": "IV"},
	{"text": "Ele ouviu a palavra “eterno”... e sorriu.", "color": Color("450b10"), "mark": "V"},
	{"text": "Se existe redenção, ela está no fim desta estrada.\nSe não existe, ele destruirá o Inferno tentando.", "color": Color("140608"), "mark": "VI"},
]

var panel_index := 0


func _ready() -> void:
	_render_panel()
	%NextButton.grab_focus()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		_skip_intro()
	elif event.is_action_pressed("move_left"):
		_previous_panel()
	elif event.is_action_pressed("move_right") or event.is_action_pressed("jump"):
		_next_panel()


func _render_panel() -> void:
	var panel: Dictionary = PANELS[panel_index]
	%Backdrop.color = panel.color
	%PanelMark.text = panel.mark
	%StoryText.text = panel.text
	%ProgressLabel.text = "%d / %d" % [panel_index + 1, PANELS.size()]
	%BackButton.disabled = panel_index == 0
	%NextButton.text = "ENTRAR NO INFERNO" if panel_index == PANELS.size() - 1 else "AVANÇAR"


func _next_panel() -> void:
	if panel_index >= PANELS.size() - 1:
		SceneRouter.go_to_stage_01()
		return
	panel_index += 1
	_render_panel()


func _previous_panel() -> void:
	if panel_index == 0:
		return
	panel_index -= 1
	_render_panel()


func _skip_intro() -> void:
	SceneRouter.go_to_stage_01()

