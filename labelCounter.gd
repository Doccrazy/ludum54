extends Panel

@export var metaType: String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var allItems = get_parent().get_node("LevelObjects").get_children()
	var count = 0
	for item in allItems:
		if item.has_meta("type") && item.get_meta("type") == metaType:
			count += 1
	$Label.text = "x " + str(count)
