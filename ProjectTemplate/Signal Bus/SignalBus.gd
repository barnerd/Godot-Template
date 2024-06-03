extends Node

var signal_list: Dictionary = {} # String -> Signal


func get_signal(_name: String) -> Signal:
	if signal_list.has(_name):
		return signal_list[_name]
	else:
		# return empty signal. similar to null, but signal isn't nullable
		# check for null by using:
		# if signal_name.is_null():
		return Signal()


func register_signal(_name: String, _signal: Signal):
	if not signal_list.has(_name):
		signal_list[_name] = _signal
	else:
		print("%s already registered" % _name)


func connect_to_signal(_name: String, _callable: Callable):
	if signal_list.has(_name):
		if not signal_list[_name].is_connected(_callable):
			signal_list[_name].connect(_callable)
		else:
			print("%s is already connected to %s" % [_callable, _name])
	else:
		print("%s not found" % _name)
