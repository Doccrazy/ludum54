extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$FireParticles2D.emitting = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_free_timer_timeout():
	queue_free()


func _on_area_2d_area_entered(area):
	print(area.get_parent().name)
	if area.get_parent().has_method("ignite"):
		area.get_parent().ignite()
