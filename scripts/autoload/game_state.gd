extends Node

## Estado da tentativa atual. Estatísticas de gameplay entram nos próximos milestones.
var run_stats: Dictionary = {}


func reset_run() -> void:
	run_stats.clear()

