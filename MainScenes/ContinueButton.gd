extends Label

func _init() -> void:
	visible = SaveGame.has_save()
