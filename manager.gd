extends Node
const ShimejiPack = preload("res://ShimejiPack.gd")
const Shimeji = preload("res://shimeji.gd")

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

	# find all shimeji packs
	packs = ShimejiPack.get_packs(project_path + "/packs")
	
	# create first shimeji
	create_shimeji()
	
	pass # Replace with function body.

func create_shimeji():
	var sprite = Shimeji.new(packs[0])
	add_child(sprite)

func create_project_folder(project_path: String):
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
