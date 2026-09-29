extends Control
var sound_playing = true

func _ready():
	$music_button/musicbuttonpng.set_self_modulate(Color(0.5, 0.5, 0.5, 1))
	$"../ColorRect".set_visible(false)
	
func _on_button_pressed():
	print("button pressed")
	#plays a sound effect
	$music_button/start_button/click_sound_effect.set_playing(true)
	
func _on_music_button_pressed():
	$music_button/start_button/click_sound_effect.set_playing(true)
	if sound_playing == false: 
		$music_button/menu_music.set_playing(true)
		sound_playing = true
		$music_button/musicbuttonpng.set_self_modulate(Color(0.5, 0.5, 0.5, 1))
	#else if the sound_playing varible is set to true 
	elif sound_playing == true:
		$music_button/menu_music.set_playing(false)
		sound_playing = false
		$music_button/musicbuttonpng.set_self_modulate(Color(1, 0.5, 0.5, 1))
		
func _on_exit_button_pressed():
	$"../ColorRect".set_visible(true)
	$music_button/start_button/click_sound_effect.set_playing(true)
	

func _on_music_button_mouse_entered():
	if sound_playing == true:
		$music_button/musicbuttonpng.set_self_modulate(Color(1, 1, 1, 1))
	elif sound_playing == false:
		$music_button/musicbuttonpng.set_self_modulate(Color(0.7, 0.5, 0.5, 1))

func _on_music_button_mouse_exited():
	if sound_playing == true:
		$music_button/musicbuttonpng.set_self_modulate(Color(0.5, 0.5, 0.5, 1))
	elif sound_playing == false:
		$music_button/musicbuttonpng.set_self_modulate(Color(1, 0.5, 0.5, 1))
		
func _on_yes_button_pressed():
	$music_button/start_button/click_sound_effect.set_playing(true)
#plays sound effect
	get_tree().quit()
#ends game

func _on_no_button_pressed():
	$music_button/start_button/click_sound_effect.set_playing(true)
#plays sound effect
	$"../ColorRect".set_visible(false)
	
func _on_start_button_pressed():
	$music_button/start_button/click_sound_effect.set_playing(true)
	$music_button/start_button/click_sound_effect/Timer.start()


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Cookie CLicker/Scenes/game.tscn")
