extends Node

## Centraliza trocas de cena para que menus não dependam de caminhos espalhados.
const MAIN_MENU := "res://scenes/menu/main_menu.tscn"
const INTRO := "res://scenes/intro/intro.tscn"
const STAGE_01 := "res://scenes/levels/stage_01.tscn"
const RESULTS := "res://scenes/ui/results.tscn"
const COLLABORATOR_CTA := "res://scenes/ui/collaborator_cta.tscn"


func go_to(scene_path: String) -> void:
	if not ResourceLoader.exists(scene_path):
		push_error("SceneRouter: cena inexistente: %s" % scene_path)
		return
	get_tree().change_scene_to_file(scene_path)


func go_to_main_menu() -> void:
	go_to(MAIN_MENU)


func go_to_intro() -> void:
	go_to(INTRO)


func go_to_stage_01() -> void:
	go_to(STAGE_01)


func go_to_results() -> void:
	go_to(RESULTS)


func go_to_collaborator_cta() -> void:
	go_to(COLLABORATOR_CTA)
