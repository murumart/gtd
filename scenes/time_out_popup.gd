class_name TimeOutPopup extends Window

signal decided_restart_timer
signal decided_close_timer

@onready var alert_sound: AudioStreamPlayer = $AlertSound
@onready var descriptive_label: Label = %DescriptiveLabel
@onready var restart_button: Button = %RestartButton
@onready var close_button: Button = %CloseButton


static func create(nomen: String) -> TimeOutPopup:
	var top := preload("res://scenes/time_out_popup.tscn").instantiate()
	top.ready.connect(func():
		top.descriptive_label.text = top.descriptive_label.text % nomen
		top.restart_button.pressed.connect(func(): 
			top.decided_restart_timer.emit())
		top.close_button.pressed.connect(func():
			top.decided_close_timer.emit())
		top.alert_sound.finished.connect(top.alert_sound.play)
	)
	
	return top
