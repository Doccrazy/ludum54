extends Node2D

@export var objects1: Array[PackedScene]
@export var objects2: Array[PackedScene]
@export var objects3: Array[PackedScene]
@export var objects4: Array[PackedScene]
@export var objects5: Array[PackedScene]

const MAX_COORD = pow(2,31)-1
const MIN_COORD = -MAX_COORD
var boundingBox: Rect2 # your polygon bounding box (Rect2)

func minv(curvec,newvec):
	return Vector2(min(curvec.x,newvec.x),min(curvec.y,newvec.y))
func maxv(curvec,newvec):
	return Vector2(max(curvec.x,newvec.x),max(curvec.y,newvec.y))

func on_change_my_poly():
	var min_vec = Vector2(MAX_COORD,MAX_COORD)
	var max_vec = Vector2(MIN_COORD,MIN_COORD)
	var poly = get_node("../GroundPoly")
	for v in poly.polygon:
		min_vec = minv(min_vec,v)
		max_vec = maxv(max_vec,v)
	boundingBox = Rect2(min_vec,max_vec-min_vec)

# Called when the node enters the scene tree for the first time.
func _ready():
	on_change_my_poly()
	spawn(objects1, 30)
	spawn(objects2, 10)
	spawn(objects3, 6)
	spawn(objects4, 7)
	spawn(objects5, 1)
	
func spawn(objects: Array[PackedScene], count: int):
	var poly = get_node("../GroundPoly")
	var paths = get_node("../Paths").get_children()
	for i in range(count):
		var objIdx = randi_range(0, objects.size() - 1)
		var objScene = objects[objIdx]
		var spawnPoint = randomPoint(poly, paths)
		var node = objScene.instantiate() as Node2D
		node.position = spawnPoint
		node.scale = Vector2(0.2, 0.2)
		add_child(node)
		
func randomPoint(poly: Polygon2D, paths: Array[Node]):
	while true:
		var pos = Vector2(randf_range(boundingBox.position.x, boundingBox.end.x), randf_range(boundingBox.position.y, boundingBox.end.y))
		if Geometry2D.is_point_in_polygon(pos, poly.polygon) && \
		  Geometry2D.is_point_in_polygon(pos + Vector2(10, 0), poly.polygon) && \
		  Geometry2D.is_point_in_polygon(pos + Vector2(0, 10), poly.polygon) && \
		  Geometry2D.is_point_in_polygon(pos + Vector2(-10, 0), poly.polygon) && \
		  Geometry2D.is_point_in_polygon(pos + Vector2(0, -10), poly.polygon):
			var isClearOfPath = true
			for path in paths:
				var closest = path.curve.get_closest_point(pos)
				if (closest.distance_to(pos) < 30):
					isClearOfPath = false
			if isClearOfPath:
				return pos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
