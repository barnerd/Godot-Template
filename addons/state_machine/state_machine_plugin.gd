@tool
extends EditorPlugin


func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	add_custom_type("StateMachine", "Node", preload("state_machine.gd"), preload("res://addons/state_machine/img/Pictogrammers-Material-State-machine.512.png"))
	add_custom_type("State", "Node", preload("state.gd"), preload("res://addons/state_machine/img/Pictogrammers-Material-State-machine.512.png"))


func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	remove_custom_type("StateMachine")
	remove_custom_type("State")
