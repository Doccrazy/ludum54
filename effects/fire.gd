extends Node2D

var shockwaveScene = preload("res://effects/shockwave.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_explode_timer_timeout():
	var shockwave = shockwaveScene.instantiate()
	shockwave.position = global_position
	get_tree().root.add_child(shockwave)
	get_parent().queue_free()
	queue_free()
