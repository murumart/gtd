extends Window

signal timer_confirmed(timer_data: TimerData)

@onready var confirm_button: Button = %ConfirmButton
@onready var cancel_button: Button = %CancelButton

@onready var seconds_le: LineEdit = %Seconds
@onready var minutes_le: LineEdit = %Minutes
@onready var hours_le: LineEdit = %Hours
@onready var name_line: LineEdit = %NameLine


func _ready() -> void:
	confirm_button.pressed.connect(func():
		timer_confirmed.emit(
			TimerData.from_dict(
				{
					"seconds": int(seconds_le.text),
					"minutes": int(minutes_le.text),
					"hours": int(hours_le.text) ,
					"name": "Uus taimer" if not name_line.text \
					else name_line.text
				}
			)
		)
		hide()
	)
	cancel_button.pressed.connect(func():
		hide()
	)


