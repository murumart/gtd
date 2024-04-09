class_name TimerData extends Resource

var name := "Uus taimer"
var seconds := 0
var minutes := 0
var hours := 0


static func from_dict(dict: Dictionary) -> TimerData:
	var td := TimerData.new()
	td.seconds = dict.seconds
	td.minutes = dict.minutes
	td.hours = dict.hours
	td.name = dict.name
	return td


func to_secs() -> int:
	return seconds + minutes * 60 + hours * 3600


	
