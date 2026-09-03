extends Node

## Persistência local de configurações e recordes, a implementar após o bootstrap.
const SAVE_PATH := "user://save.cfg"


func load_settings() -> Dictionary:
	return {}


func save_settings(_settings: Dictionary) -> void:
	pass

