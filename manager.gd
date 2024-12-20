extends Node
const ShimejiPack = preload("res://ShimejiPack.gd")
const ConfigManager = preload("res://ConfigManager.gd")
const Shimeji = preload("res://shimeji.gd")

var cm: ConfigManager
var packs = []
var shimejis = []

func _ready() -> void:
	randomize()
	get_tree().get_root().set_transparent_background(true)
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT, true, 0)
	#DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_MOUSE_PASSTHROUGH, true, 0)
	#DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_ALWAYS_ON_TOP, true, 0)
	#DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true, 0)
	
	# create shimeji folder if it does not exist
	var project_path = OS.get_config_dir() + "/shimejigd"
	if not DirAccess.dir_exists_absolute(project_path):
		create_project_folder(project_path)
	else:
		print("shimejigd folder found ^_^")
	cm = get_config_manager(project_path)

	# find all shimeji packs
	packs = ShimejiPack.get_packs(project_path + "/packs")
	
	# create first shimeji
	var num = cm.config.get_value("manager", "starting_shimes", 1)
	for i in range(0, num):
		create_shimeji()
	
	pass # Replace with function body.

func create_shimeji():
	var pack = cm.config.get_value("manager", "pack", "random")
	
	var sprite = Shimeji.new(packs[0], cm)
	if pack == "random":
		sprite = Shimeji.new(packs.pick_random(), cm)
	else:
		for p in packs:
			if p.name == pack:
				sprite = Shimeji.new(packs[0], cm)
	add_child(sprite)

func get_config_manager(project_path: String) -> ConfigManager:
	if not FileAccess.file_exists(project_path + "/config.txt"):
		DirAccess.copy_absolute("res://default_config.txt", project_path + "/config.txt")
	
	return ConfigManager.new(project_path)

func create_project_folder(project_path: String) -> void:
	print("shimejigd folder does not exist creating one at: " + project_path)
	DirAccess.make_dir_absolute(project_path)
	var packs_path = project_path + "/packs"
	DirAccess.make_dir_absolute(packs_path)
	DirAccess.make_dir_absolute(packs_path + "/Shimeji")
	
	var dir = DirAccess.open("res://Shimeji")
	dir.list_dir_begin()
	var fn = dir.get_next()
	while fn != "":
		dir.copy("res://Shimeji/" + fn, packs_path + "/Shimeji/" + fn)
		fn = dir.get_next()
	
	print("done creating shimejigd folder")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
