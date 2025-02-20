extends Node

signal story_variable_set(variable_name: String, delta: float)
signal story_variable_changed(variable_name: String, value: float)

@onready var ink_player = InkPlayer.new()

var is_story_loaded: bool = false


func _init() -> void:
	SignalBus.register_signal("story_variable_set", story_variable_set)
	SignalBus.register_signal("story_variable_changed", story_variable_changed)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ink_player.connect("loaded", _on_story_loaded)
	#ink_player.connect("continued", _on_story_continued)
	#ink_player.connect("prompt_choices", _prompt_choices)
	#ink_player.connect("ended", on_story_ended)
	
	# TODO: Move this to the BootLoad process
	ink_player.ink_file = load("res://Dialogue/Dialogue.ink.json")
	ink_player.loads_in_background = true
	ink_player.create_story()


func _on_story_loaded(is_successful: bool) -> void:
	if not is_successful:
		return
	
	is_story_loaded = true
	bind_functions()
	#ink_player.continue_story()


func bind_functions() -> void:
	ink_player.bind_external_function("set_variable", self, "set_variable")
	ink_player.bind_external_function("change_variable", self, "change_variable")


func set_variable(variable_name: String, value: float) -> void:
	story_variable_set.emit(variable_name, value)
	ink_player.continue_story()


func change_variable(variable_name: String, delta: float) -> void:
	story_variable_changed.emit(variable_name, delta)
	ink_player.continue_story()


# I'm not sure if continue_story() is needed after making a choice
#ink_player.choose_choice_index(index)
#ink_player.continue_story()


#ink_player.continue_story()
#ink_player.get_state()
#ink_player.set_state(state)
#ink_player.choose_path(_knot: String)
