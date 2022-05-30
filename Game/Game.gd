extends Node2D

func _ready():
	if !MusicPlayer.game_music_play:
		MusicPlayer.play_game_music()

func _on_FadeIn_fade_finished():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Menu/Main Menu.tscn")

func _process(_delta):
	get_node("CanvasLayer/Label").text = str("Bones: ") + str($Player.bones)
	if Input.is_action_pressed("ui_cancel"):
		$Player/FadeIn.show()
		$Player/FadeIn.fade_in()
