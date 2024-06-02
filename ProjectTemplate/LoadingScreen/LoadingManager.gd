extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$LogoScenes.logo_scenes_finished.connect(on_logo_scenes_finished)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_logo_scenes_finished() -> void:
	print("logo scenes are finished")
