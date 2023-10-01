extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func passSingleEnemy():
	var enemyAreas = $Area2D.get_overlapping_areas()
	print(enemyAreas)
	$GateSprite.open()
	for enemyArea in enemyAreas:
		var enemy = enemyArea.get_parent()
		if enemy.pathDone:
			enemy.proceedIn()
