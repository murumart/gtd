class_name TimerBox extends PanelContainer

enum _Ss {
	TIMER_TIME,
	TIMER_LENGTH,
	TIMER_NAME
}

var _timer_length: float

@onready var pause_button: Button = %PauseButton
@onready var close_button: Button = %CloseButton
@onready var timer: Timer = $Timer
@onready var progress_bar: ProgressBar = $VBoxContainer/ProgressBar
@onready var name_line: LineEdit = %NameLine
@onready var time_left_label: Label = %TimeLeftLabel


static func from_data(timer_data: TimerData) -> TimerBox:
	var tb := preload("res://scenes/timer_box.tscn").instantiate()
	tb._timer_length = timer_data.to_secs()
	tb.ready.connect(func():
		tb.name_line.text = timer_data.name
		if timer_data.save_time <= 0.0:
			tb.timer.wait_time = tb._timer_length
		else:
			tb.timer.wait_time = timer_data.save_time
		# _ready comes before ready signal call
		tb.timer.start()
	, CONNECT_ONE_SHOT)
	return tb


static func time_left_string(time: float) -> String:
	var hours := floorf(time * 0.00027777777778)
	var minutes := floorf(fposmod(time * 0.01666666667, 60.0))
	var seconds := floorf(fposmod(time, 60.0))
	return str(hours, ":", minutes, ":", seconds)


func _ready() -> void:
	pause_button.pressed.connect(func():
		timer.paused = not timer.paused
		pause_button.text = ">" if timer.paused else "||"
	)
	close_button.pressed.connect(func(): queue_free())
	get_window().focus_entered.connect(_window_focused.bind(true))
	get_window().focus_exited.connect(_window_focused.bind(false))
	timer.timeout.connect(func():
		var top := TimeOutPopup.create(name_line.text)
		get_window().request_attention()
		add_child(top)
		top.decided_restart_timer.connect(func():
			top.queue_free()
			timer.start(_timer_length)
		)
		top.decided_close_timer.connect(func():
			top.queue_free()
			queue_free()
		)
	)


func _physics_process(_delta: float) -> void:
	progress_bar.value = timer.time_left / _timer_length
	time_left_label.text = TimerBox.time_left_string(timer.time_left)


func _window_focused(in_focus: bool) -> void:
	set_physics_process(in_focus)


func _save_me(save_dict: Dictionary) -> void:
	if not save_dict.has(Saver.SaveSpots.TIMERS):
		save_dict[Saver.SaveSpots.TIMERS] = []
	save_dict[Saver.SaveSpots.TIMERS].append({
		_Ss.TIMER_TIME: timer.time_left,
		_Ss.TIMER_LENGTH: _timer_length,
		_Ss.TIMER_NAME: name_line.text
	})
