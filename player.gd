extends CharacterBody2D

@export var speed = 400
@export var rotation_speed = 2.5

const GATE_DISTANCE = 50

var rotation_direction = 0

func get_input():
	rotation_direction = Input.get_axis("left", "right")
	velocity = transform.x * Input.get_axis("down", "up") * speed

func _input(event):
	if event.is_action_pressed("action"):
		var areas = $ActionArea.get_overlapping_areas()
		for area in areas:
			if area.get_parent().get_meta("type") == "gate":
				var gate = area.get_parent()
				gate.passSingleEnemy()
				return
			elif area.get_parent().get_meta("type") == "toilet":
				var toilet = area.get_parent()
				toilet.clean()
				pass
			elif area.get_parent().get_meta("type") == "tent":
				var tent = area.get_parent()
				tent.remove()

func _physics_process(delta):
	get_input()
	rotation += rotation_direction * rotation_speed * delta
	move_and_slide()
