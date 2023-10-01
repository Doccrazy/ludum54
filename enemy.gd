extends Node2D

const SPEED = 40
var progressPixels: float = 0
var currentPath: Path2D
var nextPath: Path2D
var collisionCount = 0
var pathDone = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if collisionCount == 0:
		progressPixels += delta * SPEED
		transform = currentPath.curve.sample_baked_with_rotation(progressPixels, true)
		if (progressPixels >= currentPath.curve.get_baked_length()):
			pathDone = true

func initialize(start: Transform2D, spawnPath: Path2D, mainPath: Path2D):
	transform = start
	currentPath = spawnPath
	nextPath = mainPath

func proceedPath(newNextPath: Path2D = null):
	progressPixels = nextPath.curve.get_closest_offset(position)
	currentPath = nextPath
	nextPath = newNextPath
	pathDone = false

func _on_collider_body_entered(body):
	if body != get_node("StaticBody2D"):
		collisionCount += 1

func _on_collider_body_exited(body):
	if body != get_node("StaticBody2D"):
		collisionCount -= 1
