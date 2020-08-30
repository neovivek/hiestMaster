extends CanvasModulate

const DARK = Color("181a18")
const NIGHT_VISION = Color("176c14")

var cooldown = false

func _ready():
	visible = true
	color = DARK

func cycle_vision_mode():
	if not cooldown:
		if color == DARK:
			NIGHT_VISION_mode()
		else:
			DARK_mode()
		cooldown = true
		$Timer.start()

func NIGHT_VISION_mode():
	color = NIGHT_VISION
	$AudioStreamPlayer2D.stream = load("res://SFX/nightvision.wav")
	$AudioStreamPlayer2D.play()
	get_tree().call_group("lights", "hide")
	get_tree().call_group("labels", "show")

func DARK_mode():
	color = DARK
	$AudioStreamPlayer2D.stream = load("res://SFX/nightvision_off.wav")
	$AudioStreamPlayer2D.play()
	get_tree().call_group("lights", "show")
	get_tree().call_group("labels", "hide")

func _on_Timer_timeout():
	if color == NIGHT_VISION:
		DARK_mode()
		$Timer.start()
	else:
		cooldown = false
