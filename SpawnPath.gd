extends Path2D

@export var enemyScene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	_on_timer_timeout()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	print("Spawn")
	if !get_node("../ClearArea").has_overlapping_areas():
		var enemy = enemyScene.instantiate() as Node2D
		var start = curve.sample_baked_with_rotation(0)
		var mainPaths = get_node("../Paths").get_children()
		var tents = get_node("../LevelObjects").tents
		var trash = get_node("../LevelObjects").trash
		enemy.initialize(start, self, mainPaths[randi_range(0, mainPaths.size() - 1)], get_node("../GroundPoly"), tents[randi_range(0, tents.size() - 1)], trash)
		get_node("../LevelObjects").add_child(enemy)
