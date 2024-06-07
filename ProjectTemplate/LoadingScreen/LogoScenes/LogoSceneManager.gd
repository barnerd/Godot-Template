extends Node

@onready var timer: Timer = $Timer

@export var scene_delay: float = 1.0

signal logo_scenes_finished()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is BootSplash:
			# wait for the next logo
			timer.start(scene_delay)
			await timer.timeout
			
			# have scene display it's logo
			await child.display_logo()
	
	logo_scenes_finished.emit()
