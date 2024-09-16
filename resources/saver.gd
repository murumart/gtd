class_name Saver

enum SaveSpots {HEADER, TIMERS, NOTES, NOTE_PANEL_WIDTH}
const GTD_SAVE_PATH := "user://gtd/"


static func _static_init() -> void:
	if not DirAccess.dir_exists_absolute(GTD_SAVE_PATH):
		DirAccess.make_dir_absolute(GTD_SAVE_PATH)


static func save(tree: SceneTree, profile: int) -> void:
	var save_dict := {}
	tree.call_group("_save_me", "_save_me", save_dict)
	save_dict[SaveSpots.HEADER] = "GTD SAVE FILE by: xXxMurumartxXx"
	write_dict_to_file(save_dict, str("profile_", profile))
	print(save_dict)


static func load_file(profile: int) -> Dictionary:
	return read_dict_from_file(str("profile_", profile))


static func write_dict_to_file(data: Dictionary, filename: String) -> void:
	print("data size: ", data.size())
	var file := FileAccess.open(str(GTD_SAVE_PATH, filename), FileAccess.WRITE)
	assert(FileAccess.get_open_error() == OK)
	file.store_buffer(var_to_bytes(data))
	file.flush()


static func read_dict_from_file(filename: String) -> Dictionary:
	if not FileAccess.file_exists(str(GTD_SAVE_PATH, filename)):
		print("no %s file exists" % filename)
		return {}
	var file := FileAccess.open(str(GTD_SAVE_PATH, filename), FileAccess.READ)
	assert(FileAccess.get_open_error() == OK)
	var bytes := file.get_buffer(file.get_length()) as PackedByteArray
	var returnable := bytes_to_var(bytes) as Dictionary
	if returnable == null:
		printerr("Save data corrupted!")
		return {}
	return returnable
