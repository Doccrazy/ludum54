extends Node2D

var fireScene = preload("res://effects/fire.tscn")
var fireObj: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func passSingleEnemy():
	var enemyAreas = $Area2D.get_overlapping_areas()
	$GateSprite.open()
	for enemyArea in enemyAreas:
		if enemyArea.name == "EnemyArea":
			var enemy = enemyArea.get_parent()
			if enemy.pathDone:
				enemy.proceedIn()

func ignite():
	if !fireObj:
		fireObj = fireScene.instantiate()
		add_child(fireObj)

func extinguish():
	if fireObj:
		fireObj.queue_free()
		fireObj = null
