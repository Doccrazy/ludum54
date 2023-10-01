extends StaticBody2D

var occupiedBy: Node2D
var dirty = false
var fireObj: Node2D

var fireScene = preload("res://effects/fire.tscn")

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

func ignite():
	if !fireObj:
		fireObj = fireScene.instantiate()
		add_child(fireObj)

func extinguish():
	if fireObj:
		fireObj.queue_free()
		fireObj = null

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
