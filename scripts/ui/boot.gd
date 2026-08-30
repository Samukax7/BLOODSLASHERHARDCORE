extends Control


func _ready() -> void:
	# Um frame garante que os Autoloads estejam prontos antes da navegação.
	await get_tree().process_frame
	SceneRouter.go_to_main_menu()

