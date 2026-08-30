extends Node

## Interface global de áudio. Os buses e stems serão ligados quando houver assets.
var audio_unlocked := false


func unlock_audio() -> void:
	audio_unlocked = true

