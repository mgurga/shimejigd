class_name ConfigManager

var config = ConfigFile.new()

func _init(project_path: String) -> void:
	if config.load(project_path + "/config.txt") != OK:
		print("error parsing config at " + project_path + "/config.txt using default")
		config.load("res://default_config.txt")
