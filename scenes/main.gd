extends Control

const CreateTimerPopupType := preload("res://scenes/create_timer_popup.gd")

@onready var create_timer_button: Button = %CreateTimerButton
@onready var create_timer_popup := %CreateTimerPopup as CreateTimerPopupType
@onready var timer_container: VBoxContainer = %TimerContainer
@onready var thing_loader: ThingLoader = $ThingLoader


func _ready() -> void:
	create_timer_popup.timer_confirmed.connect(_on_timer_confirmed)
	create_timer_button.pressed.connect(func():
		create_timer_popup.popup()
	)
	thing_loader.timer_loaded.connect(_on_timer_confirmed)
	thing_loader.load_things(0)


func _notification(what: int) -> void:
	match what:
		NOTIFICATION_WM_CLOSE_REQUEST:
			Saver.save(get_tree(), 0)
			get_tree().quit()


func _on_timer_confirmed(timer_data: TimerData) -> void:
	var tb := TimerBox.from_data(timer_data)
	timer_container.add_child(tb)


