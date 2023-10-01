extends RigidBody2D

@export var explosionScene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	angular_velocity = 2*PI
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_explode_timer_timeout():
	var explosion = explosionScene.instantiate()
	explosion.position = position
	get_parent().add_child(explosion)
	queue_free()
