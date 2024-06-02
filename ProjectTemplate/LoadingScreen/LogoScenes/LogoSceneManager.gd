extends Node

@onready var timer: Timer = $Timer

signal logo_scenes_finished()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if not child is Timer:
			# wait a second for the next logo
			timer.start(1)
			await timer.timeout
			
			# have scene display it's logo
			await child.display_logo()
	
	logo_scenes_finished.emit()
