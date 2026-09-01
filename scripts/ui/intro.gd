extends Control

const PANELS := [
	{
		"text": "Ele viveu rápido. Brigou mais do que devia.",
		"image": preload("res://assets/sprites/intro/Christofoly na Curva da Tempestade.png"),
		"mark": "I",
	},
	{
		"text": "Uma noite, a estrada finalmente cobrou a dívida.",
		"image": preload("res://assets/sprites/intro/Impacto da corrente na estrada infernal.png"),
		"mark": "II",
	},
	{
		"text": "Quando abriu os olhos, o asfalto ainda queimava.\nMas aquele não era mais o seu mundo.",
		"image": preload("res://assets/sprites/intro/Despertar na estrada infernal.png"),
		"mark": "III",
	},
	{
		"text": "Disseram que o Inferno seria eterno.",
		"image": preload("res://assets/sprites/intro/Silêncio após o impacto na curva.png"),
		"mark": "IV",
	},
	{
		"text": "Ele ouviu a palavra “eterno”... e sorriu.",
		"image": preload("res://assets/sprites/intro/Chris aprova com um joinha.png"),
		"mark": "V",
	},
	{
		"text": "Se existe redenção, ela está no fim desta estrada.\nSe não existe, ele destruirá o Inferno tentando.",
		"image": preload("res://assets/sprites/intro/Christofoly encara a horda demoníaca.png"),
		"mark": "VI",
	},
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
	%PanelImage.texture = panel.image
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
