extends Node
var score = 100000
var unlocked_grandma = false
var grandma_button_hovering = false
var grandmas_bought = 0
var grandma_cost = 100

func _ready() -> void:
	_rotate_cookie()
	$"../Shop stuff/TextureButton/Panel2/ColorRect".set_modulate(Color(0.03, 0.03, 0.03, 1.0))
	$"../Shop stuff/TextureButton/Panel2/shop_label".set_text("???")

#on the start the game it calls the rotate cookie function to rotate the cookie

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int):
	if event is InputEventMouseButton and event.pressed == true:
		score += 1 
		print("score is ",score)
		#for debug
		$"../Label".text = str(score)
		$"../Area2D/ClickSound".set_playing(true)
		#plays a sound effect
		_cookie_click()

func _cookie_click():
	var tween = create_tween()
	#creates a tween
	tween.set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property($"../Area2D/Cookie","scale",Vector2(13.6,13.6),0.1)
	#makes the cookie smaller 
	tween.tween_property($"../Area2D/Cookie","scale",Vector2(15,15),0.1)
	if score >= 50 and unlocked_grandma == false:
		unlocked_grandma = true
		print("unlocked grandma")
		$"../Shop stuff/TextureButton/Panel2/ColorRect".set_modulate(Color(1.0, 1.0, 1.0, 1.0))
		$"../Shop stuff/TextureButton/Panel2/shop_label".set_text("GRANDMA")
	#makes the cookie bigger
	
func _rotate_cookie():
	var tween = create_tween()
	tween.tween_property($"../Area2D/Cookie","rotation",deg_to_rad(14401),360)
	tween.set_loops(999999999999999999)
	#loops for days

#spins cookie for 0.08 milseconds

func _on_area_2d_mouse_shape_entered(shape_idx: int):
	var size_up = create_tween()
	size_up.set_trans(Tween.TRANS_BOUNCE)
	size_up.tween_property($"../Area2D/Cookie", "scale", Vector2(15,15),0.2)


func _on_area_2d_mouse_shape_exited(shape_idx: int):
	var size_down = create_tween()
	size_down.tween_property($"../Area2D/Cookie", "scale", Vector2(12,12),0.1)
	

func _on_texture_button_mouse_entered() -> void:
	if unlocked_grandma == true:
		grandma_button_hovering = true
		$"../Shop stuff/TextureButton/Panel2".set_modulate(Color(0.42, 0.42, 0.42, 1.0))
		var hover = create_tween()
		hover.set_ease(Tween.EASE_OUT)
		hover.set_trans(Tween.TRANS_SPRING)
		hover.tween_property($"../Shop stuff/TextureButton/Panel2", "scale", Vector2(1.2,1),0.2)
		

func _on_texture_button_mouse_exited() -> void:
	if unlocked_grandma == true:
		grandma_button_hovering = false
		$"../Shop stuff/TextureButton/Panel2".set_modulate(Color(1.0, 1.0, 1.0, 1.0))
		var hover = create_tween()
		hover.tween_property($"../Shop stuff/TextureButton/Panel2", "scale", Vector2(1,1),0.2)
		
func _on_texture_button_pressed() -> void:
	if score >= grandma_cost and unlocked_grandma == true:
		$"../Area2D/ClickSound".set_playing(true)
		var tween = get_tree().create_tween()
		print("grandma bought ",grandmas_bought) 
		grandmas_bought += 1
		score -= int(grandma_cost)
		grandma_cost *= 1.25 
		$"../grandma cooking time".start(true)
		print("grandma cost is now ", int(grandma_cost))
		$"../Label".text = str(score)
		$"../Shop stuff/TextureButton/Panel2/descripton_label".text = str("the cost is ", int(grandma_cost))
		if grandma_button_hovering == true:
			$"../Shop stuff/TextureButton/Panel2".set_modulate(Color(1.0, 1.0, 1.0, 1.0))
			tween.tween_callback($"../Shop stuff/TextureButton/Panel2".set_modulate.bind(Color(0.42, 0.42, 0.42, 1.0))).set_delay(0.05)

func _on_grandma_cooking_time_timeout() -> void:
	print("grandmas baked ",10 * grandmas_bought," cookies")
	score += 10 * grandmas_bought
	$"../Label".text = str(score)
