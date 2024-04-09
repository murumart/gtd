class_name ThingLoader extends Node

signal timer_loaded(TimerData)


func load_things(profile := 0) -> void:
	var dict := Saver.load_file(profile)
	print(dict)
	# load timers
	var timers := dict.get(Saver.SaveSpots.TIMERS, []) as Array
	for t: Dictionary in timers:
		var td := TimerData.from_save_dict(t)
		timer_loaded.emit(td)
