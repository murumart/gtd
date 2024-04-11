extends VBoxContainer

@onready var width_slider: HSlider = %WidthSlider
@onready var create_note_button: Button = %CreateNoteButton
@onready var note_container: VBoxContainer = %NoteContainer
@export var thing_loader: ThingLoader


func _ready() -> void:
	assert(is_instance_valid(thing_loader))
	width_slider.value_changed.connect(func(value: float):
		custom_minimum_size.x = value
	)
	create_note_button.pressed.connect(func():
		var note := preload("res://scenes/note.tscn").instantiate()
		note_container.add_child(note)
	)
	thing_loader.note_loaded.connect(func(note: Note):
		note_container.add_child(note)
	)
	thing_loader.note_panel_width_loaded.connect(func(value: float):
		custom_minimum_size.x = value
		width_slider.value = value
	)


func _save_me(save_dict: Dictionary) -> void:
	save_dict[Saver.SaveSpots.NOTE_PANEL_WIDTH] = width_slider.value
