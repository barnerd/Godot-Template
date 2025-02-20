## From: https://www.gdquest.com/tutorial/godot/design-patterns/finite-state-machine/
class_name StateMachine
extends Node

signal state_changed(previous_state: State, current_state: State)

@export var initial_state: State = null

var previous_state: State = null
var current_state: State = null


func _ready() -> void:
	for state_node: State in find_children("*", "State"):
		state_node.finished.connect(_transition_to_next_state)
	
	await owner.ready
	_transition_to_next_state(initial_state if initial_state else get_child(0))


func _unhandled_input(event: InputEvent) -> void:
	current_state.handle_input(event)


func _process(delta: float) -> void:
	current_state.update(delta)


func _physics_process(delta: float) -> void:
	current_state.physics_update(delta)


func _transition_to_next_state(target_state: State, data: Dictionary = {}) -> void:
	if not target_state:
		printerr("%s: Trying to transition to state %s but it does not exist." % [owner.name, target_state.name])
		return
	
	if current_state:
		previous_state = current_state
		current_state.exit()
	current_state = target_state
	state_changed.emit(previous_state, current_state)
	current_state.enter(previous_state, data)
