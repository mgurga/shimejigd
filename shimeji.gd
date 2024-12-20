extends Sprite2D
const ShimejiPack = preload("res://ShimejiPack.gd")
const ConfigManager = preload("res://ConfigManager.gd")

var pack: ShimejiPack
var shime_size = 0
var cur_frame = 0

func set_shime(frame: int) -> void:
	if cur_frame == frame:
		return
	
	cur_frame = frame
	self.texture = ImageTexture.create_from_image(pack.frames[cur_frame])

func _init(p: ShimejiPack, cm: ConfigManager) -> void:
	pack = p
	shime_size = pack.frames[0].get_size().x
	
	pass

func _ready() -> void:
	self.position.y = randi_range(-(shime_size * 3), -shime_size)
	self.position.x = randi_range(0, get_window().size.x - shime_size)
	self.texture = ImageTexture.create_from_image(pack.frames[cur_frame])
	pass

func _process(delta: float) -> void:
	if self.position.y + (shime_size / 2) <= get_window().size.y:
		self.position.y += 2
		set_shime(3)
	else:
		set_shime(0)
