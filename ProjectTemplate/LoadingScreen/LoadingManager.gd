extends Control

var title_screen_scene_path: String = "res://MainScenes/title_screen.tscn"
var new_game_scene_path: String = "res://MainScenes/new_game.tscn"
var main_scene_path: String = "res://MainScenes/main.tscn"

var scene_load_status: ResourceLoader.ThreadLoadStatus
var progress: Array
var progress_percent: float

@onready var progress_bar: ProgressBar = $ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$LogoScenes.logo_scenes_finished.connect(on_logo_scenes_finished)
	ResourceLoader.load_threaded_request(title_screen_scene_path)
	ResourceLoader.load_threaded_request(new_game_scene_path)
	ResourceLoader.load_threaded_request(main_scene_path)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress_percent = 0.0
	
	if SceneManager.title_screen_scene:
		progress_percent += 1/3.0
	else:
		scene_load_status = ResourceLoader.load_threaded_get_status(title_screen_scene_path, progress)
		progress_percent += 1/3.0 * progress[0]
	
	if SceneManager.new_game_scene:
		progress_percent += 1/3.0
	else:
		scene_load_status = ResourceLoader.load_threaded_get_status(new_game_scene_path, progress)
		progress_percent += 1/3.0 * progress[0]
		if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
			SceneManager.new_game_scene = ResourceLoader.load_threaded_get(new_game_scene_path)
	
	if SceneManager.main_scene:
		progress_percent += 1/3.0
	else:
		scene_load_status = ResourceLoader.load_threaded_get_status(main_scene_path, progress)
		progress_percent += 1/3.0 * progress[0]
		if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
			SceneManager.main_scene = ResourceLoader.load_threaded_get(main_scene_path)
	
	progress_bar.value = progress_percent


func on_logo_scenes_finished() -> void:
	print("logo scenes are finished")
	
	if progress_percent < 1.0:
		progress_bar.visible = true
	
	# this blocks until loaded
	SceneManager.title_screen_scene = ResourceLoader.load_threaded_get(title_screen_scene_path)
	$TitleScreen.add_child(SceneManager.title_screen_scene.instantiate())
