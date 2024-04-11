class_name Note extends MarginContainer

enum _Ss {TITLE, TEXT}

@onready var title: LineEdit = %Title
@onready var text: TextEdit = %Text


static func from_save(dict: Dictionary) -> Note:
	var n := preload("res://scenes/note.tscn").instantiate()
	n.ready.connect(func():
		n.title.text = dict[_Ss.TITLE]
		n.text.text = dict[_Ss.TEXT]
	)
	return n


func _save_me(save_dict: Dictionary) -> void:
	if not save_dict.has(Saver.SaveSpots.NOTES):
		save_dict[Saver.SaveSpots.NOTES] = []
	save_dict[Saver.SaveSpots.NOTES].append({
		_Ss.TITLE: title.text,
		_Ss.TEXT: text.text
	})


func _on_delete_button_pressed() -> void:
	queue_free()
