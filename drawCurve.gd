@tool
extends Line2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Engine.is_editor_hint():
		var path = get_parent() as Path2D
		var curve = path.curve
		var curvePoints = curve.tessellate()
		points = curvePoints
