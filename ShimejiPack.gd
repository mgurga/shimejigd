class_name ShimejiPack

var name = ""
var frames = []

static func get_pack(pack_path: String) -> ShimejiPack:
	var out = ShimejiPack.new()
	var dir = DirAccess.open(pack_path)
	
	var pack_check = true
	pack_check = FileAccess.file_exists(pack_path + "/shime1.png") && pack_check
	pack_check = FileAccess.file_exists(pack_path + "/shime46.png") && pack_check
	pack_check = FileAccess.file_exists(pack_path + "/banner.bmp") && pack_check
	if pack_check:
		print("found shimeji pack at " + pack_path)
		
		for i in range(1, 47):
			var path = pack_path + "/shime" + str(i) + ".png"
			var img = Image.load_from_file(path)
			out.frames.append(img)
		
		return out
	else:
		print("incorrect shimeji pack at " + pack_path)
		return null

static func get_packs(packs_path: String) -> Array:
	var out = []
	var dir = DirAccess.open(packs_path)

	dir.list_dir_begin()
	var fn = dir.get_next()
	while fn != "":
		var pack = get_pack(packs_path + "/" + fn)
		if not pack == null:
			pack.name = fn
			out.append(pack)
		fn = dir.get_next()
	
	print ("found ", str(len(out)), " pack(s)")
	return out

func init() -> void:
	pass
