extends Node2D

const PATH_SPEED = 100
const WANDER_SPEED = 20
const WAIT_ANGER = 10
const TENT_PROBABILITY = 0.1 # per second after arriving at destination

var progressPixels: float = 0
var destinationPixels: float
var currentPath: Path2D
var nextPath: Path2D
var collisionCount = 0
var pathDone = false
var happiness: float = 100
var wandering = false
var tentPlaced = false
var tentScene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$HealthBarNode/HealthBar.value = max(happiness, 15)
	if collisionCount == 0 && currentPath:
		progressPixels += delta * PATH_SPEED
		transform = currentPath.curve.sample_baked_with_rotation(progressPixels, true)
		if (progressPixels >= currentPath.curve.get_baked_length()):
			pathDone = true
	if (collisionCount > 0 || pathDone) && currentPath:
		happiness -= WAIT_ANGER*delta
	if destinationPixels && progressPixels > destinationPixels && !wandering:
		startRandomWander()
	if wandering:
		translate(Vector2(0, -WANDER_SPEED * delta).rotated(rotation))

func initialize(start: Transform2D, spawnPath: Path2D, mainPath: Path2D, tent: PackedScene):
	transform = start
	currentPath = spawnPath
	nextPath = mainPath
	tentScene = tent

func proceedIn():
	progressPixels = nextPath.curve.get_closest_offset(position)
	currentPath = nextPath
	destinationPixels = randf_range(nextPath.curve.get_baked_length() * 0.1, nextPath.curve.get_baked_length())
	pathDone = false

func startRandomWander():
	currentPath = null
	pathDone = false
	wandering = true
	rotation_degrees = randf_range(0, 360)
	$WanderTimer.wait_time = randf_range(2, 10)
	$WanderTimer.start()
	if !tentPlaced:
		$TentTimer.start()

func placeTent():
	tentPlaced = true
	$TentTimer.stop()
	var tent = tentScene.instantiate()
	tent.position = position
	tent.scale = Vector2(randf_range(0.15, 0.25), randf_range(0.15, 0.25))
	get_parent().add_child(tent)
	
func _on_collider_body_entered(body):
	if body != get_node("StaticBody2D"):
		collisionCount += 1

func _on_collider_body_exited(body):
	if body != get_node("StaticBody2D"):
		collisionCount -= 1

func _on_wander_timer_timeout():
	startRandomWander()

func _on_tent_timer_timeout():
	if randf() < TENT_PROBABILITY:
		placeTent()
