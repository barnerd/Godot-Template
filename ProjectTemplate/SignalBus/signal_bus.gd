extends Node

var signal_list: Dictionary = {} # String -> Signal


func get_signal(name: String) -> Signal:
	if signal_list.has(name):
		return signal_list[name]
	else:
		# return empty signal. similar to null, but signal isn't nullable
		# check for null by using:
		# if signal_name.is_null():
		return Signal()


func register_signal(name: String, _signal: Signal):
	if not signal_list.has(name):
		signal_list[name] = _signal
	else:
		print("%s already registered" % name)


func connect_to_signal(name: String, callable: Callable):
	if signal_list.has(name):
		if not signal_list[name].is_connected(callable):
			signal_list[name].connect(callable)
		else:
			print("%s is already connected to %s" % [callable, name])
	else:
		print("%s not found" % name)
