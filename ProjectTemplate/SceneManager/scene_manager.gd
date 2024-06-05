extends Node

var title_screen_scene: PackedScene
var new_game_scene: PackedScene
var main_scene: PackedScene

# load and preload scenes, 
# Transition between them
# has many transition types
# Has ability to get back to previous scene
# Can load scenes into place, or switch to them completely
# (i.e. don’t remove hud, or add a window)
