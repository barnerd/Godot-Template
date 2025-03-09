## From: https://www.gdquest.com/tutorial/godot/design-patterns/finite-state-machine/
class_name StateMachine
extends Node

signal state_changed(previous: State, current: State)

#@export var entity: Type
@export var initial_state: State = null

var previous_state: State = null
var current_state: State = null


func _ready() -> void:
	for state_node: State in find_children("*", "State"):
		state_node.finished.connect(_transition_to_next_state)
	
	await owner.ready
	_transition_to_next_state(initial_state if initial_state else get_child(0))


func _unhandled_input(_event: InputEvent) -> void:
	current_state.handle_input(_event)


func _process(_delta: float) -> void:
	current_state.update(_delta)


func _physics_process(_delta: float) -> void:
	current_state.physics_update(_delta)


func _transition_to_next_state(_target_state: State, _data: Dictionary = {}) -> void:
	if not _target_state:
		push_error("%s: Trying to transition to state %s but it does not exist." % [owner.name, _target_state.name])
		return
	
	if current_state:
		previous_state = current_state
		current_state.exit()
	current_state = _target_state
	state_changed.emit(previous_state, current_state)
	current_state.enter(previous_state, _data)
