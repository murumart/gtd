class_name Saver

enum SaveSpots {TIMERS}
const GTD_SAVE_PATH := "user://gtd/"


static func _static_init() -> void:
	if not DirAccess.dir_exists_absolute(GTD_SAVE_PATH):
		DirAccess.make_dir_absolute(GTD_SAVE_PATH)


static func save(tree: SceneTree, profile: int) -> void:
	var save_dict := {}
	tree.call_group("_save_me", "_save_me", save_dict)
	write_dict_to_file(save_dict, str("profile_", profile))
	print(save_dict)


static func load_file(profile: int) -> Dictionary:
	return read_dict_from_file(str("profile_", profile))


static func write_dict_to_file(data: Dictionary, filename: String) -> void:
	var zip := ZIPPacker.new()
	var err := zip.open(str(GTD_SAVE_PATH, filename))
	assert(err == OK)
	zip.start_file("sav")
	zip.write_file(var_to_bytes(data))
	zip.close_file()
	zip.close()


static func read_dict_from_file(filename: String) -> Dictionary:
	if not FileAccess.file_exists(str(GTD_SAVE_PATH, filename)):
		print("no %s file exists" % filename)
		return {}
	var zip := ZIPReader.new()
	var err := zip.open(str(GTD_SAVE_PATH, filename))
	assert(err == OK)
	var bytes := zip.read_file("sav") as PackedByteArray
	var returnable: Dictionary = bytes_to_var(bytes)
	return returnable

