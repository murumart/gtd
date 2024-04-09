class_name TimerData extends Resource

var name := "Uus taimer"
var seconds := 0
var minutes := 0
var hours := 0
var save_time := 0.0


static func from_dict(dict: Dictionary) -> TimerData:
	var td := TimerData.new()
	td.seconds = dict.get("seconds", 0)
	td.minutes = dict.get("minutes", 0)
	td.hours = dict.get("hours", 0)
	td.name = dict.get("name", "")
	td.save_time = dict.get("save_time", 0.0)
	return td


static func from_save_dict(dict: Dictionary) -> TimerData:
	var td := TimerData.new()
	td.seconds = dict[TimerBox._Ss.TIMER_LENGTH]
	td.save_time = dict[TimerBox._Ss.TIMER_TIME]
	td.name = dict[TimerBox._Ss.TIMER_NAME]
	return td


func to_secs() -> int:
	return seconds + minutes * 60 + hours * 3600


func _to_string() -> String:
	return str("TimerData(",
		"seconds=", seconds, ", ",
		"minutes=", minutes, ", ",
		"hours=", hours, ", ",
		"name=", name, ", ",
		"save_time=", save_time, ")"
	)
