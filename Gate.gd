extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func open():
	$SpriteClosed.visible = false
	$SpriteOpen.visible = true
	$Timer.start()
	
func close():
	$SpriteClosed.visible = true
	$SpriteOpen.visible = false

func _on_timer_timeout():
	close()
