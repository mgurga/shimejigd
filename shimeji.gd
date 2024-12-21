extends Sprite2D
const ShimejiPack = preload("res://ShimejiPack.gd")
const ConfigManager = preload("res://ConfigManager.gd")

var pack: ShimejiPack
var shime_size = 0
var cur_frame = 0
var falling = false
var time = 0
var walk_direction = false # false = left, true = right
var walk_timer = 0

func set_shime(frame: int) -> void:
	if cur_frame == frame:
		return
	
	cur_frame = frame
	self.texture = ImageTexture.create_from_image(pack.frames[cur_frame])

func _init(p: ShimejiPack, cm: ConfigManager) -> void:
	pack = p
	self.scale.x = cm.config.get_value("shime", "scale", 1)
	self.scale.y = cm.config.get_value("shime", "scale", 1)
	shime_size = pack.frames[0].get_size().x * self.scale.x
	pass

func _ready() -> void:
	self.position.y = randi_range(-(shime_size * 3), -shime_size)
	self.position.x = randi_range(0, get_window().size.x - shime_size)
	self.texture = ImageTexture.create_from_image(pack.frames[cur_frame])
	pass

func action_happening() -> bool:
	return falling or walk_timer != 0

func _process(delta: float) -> void:
	time += delta
	
	if self.position.y + (shime_size / 2) <= get_window().size.y:
		self.position.y += 2
		self.offset.y = 25
		set_shime(3)
		falling = true
	elif falling == true:
		self.offset.y = 0
		set_shime(17)
		falling = false
		
	if walk_timer == 0 and not action_happening():
		if randi_range(0, 50) == 0:
			walk_timer = randi_range(20, 200)
			walk_direction = bool(randi_range(0, 1))
			if self.position.x - walk_timer < 0 and not walk_direction:
				walk_direction = true
			if self.position.x + walk_timer + shime_size > get_window().size.x and walk_direction:
				walk_direction = false
		else:
			set_shime(0)
	
	if walk_timer != 0:
		walk_timer -= 1
		if walk_direction:
			self.flip_h = true
			self.position.x += 1
		else:
			self.flip_h = false
			self.position.x -= 1

		if walk_timer % 10 == 0:
			set_shime(2 if cur_frame == 1 else 1)
