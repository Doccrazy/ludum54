extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$ShockwaveParticles2D.emitting = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_free_timer_timeout():
	queue_free()
