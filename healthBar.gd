extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta: float):
	tint_progress = Color.GREEN
	if value < max_value * 0.7:
		tint_progress = Color.YELLOW 
	if value < max_value * 0.35:
		tint_progress = Color.RED
