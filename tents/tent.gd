extends StaticBody2D

var fireScene = preload("res://effects/fire.tscn")
var fireObj: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func remove():
	queue_free()

func ignite():
	if !fireObj:
		fireObj = fireScene.instantiate()
		add_child(fireObj)

func extinguish():
	if fireObj:
		fireObj.queue_free()
		fireObj = null
