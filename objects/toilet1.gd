extends StaticBody2D

var occupiedBy: Node2D
var dirty = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func occupy(node: Node2D):
	if !occupiedBy && !dirty:
		occupiedBy = node
		occupiedBy.lockIn()
		$AnimationPlayer.play("busy")
		$BusyTimer.start()

func clean():
	if dirty:
		$SpriteClean.visible = true
		$SpriteDirty.visible = false
		dirty = false

func _on_busy_timer_timeout():
	$AnimationPlayer.play("RESET")
	occupiedBy.releaseLock()
	occupiedBy = null
	dirty = true
	$SpriteClean.visible = false
	$SpriteDirty.visible = true
	$ShitParticles.emitting = true

func _on_area_2d_area_entered(area):
	if area.name == "EnemyArea":
		occupy(area.get_parent())
