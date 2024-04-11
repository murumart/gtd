extends Control

var profile := 0

@onready var thing_loader: ThingLoader = $ThingLoader


func _ready() -> void:
	thing_loader.load_things(profile)


func _notification(what: int) -> void:
	match what:
		NOTIFICATION_WM_CLOSE_REQUEST:
			Saver.save(get_tree(), profile)
			get_tree().quit()



