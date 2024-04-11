class_name ThingLoader extends Node

signal timer_loaded(TimerData)
signal note_loaded(Note)
signal note_panel_width_loaded(float)


func load_things(profile := 0) -> void:
	var dict := Saver.load_file(profile)
	print(dict)
	# load timers
	var timers := dict.get(Saver.SaveSpots.TIMERS, []) as Array
	for t: Dictionary in timers:
		var td := TimerData.from_save_dict(t)
		timer_loaded.emit(td)
	var notes := dict.get(Saver.SaveSpots.NOTES, []) as Array
	for t: Dictionary in notes:
		var n := Note.from_save(t)
		note_loaded.emit(n)
	note_panel_width_loaded.emit(dict.get(Saver.SaveSpots.NOTE_PANEL_WIDTH, 120))
