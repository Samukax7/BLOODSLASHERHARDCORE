extends Node

## Centraliza trocas de cena para que menus não dependam de caminhos espalhados.
const MAIN_MENU := "res://scenes/menu/main_menu.tscn"


func go_to(scene_path: String) -> void:
	if not ResourceLoader.exists(scene_path):
		push_error("SceneRouter: cena inexistente: %s" % scene_path)
		return
	get_tree().change_scene_to_file(scene_path)


func go_to_main_menu() -> void:
	go_to(MAIN_MENU)

