extends CharacterBody2D

@export var speed = 100
@export var rotation_speed = 2.5

#var expl = preload("res://effects/explosion.tscn")

var rotation_direction = 0

func get_input():
	rotation_direction = Input.get_axis("left", "right")
	velocity = transform.x * Input.get_axis("down", "up") * speed

func _input(event):
	if event.is_action_pressed("action"):
		$Sprite.visible = false
		$SpriteAttack.visible = true
		$AttackTimer.start()
		var areas = $ActionArea.get_overlapping_areas()
		for area in areas:
			if !area.get_parent().has_meta("type"):
				continue
			if area.get_parent().get_meta("type") == "gate":
				var gate = area.get_parent()
				gate.passSingleEnemy()
				return
			elif area.get_parent().get_meta("type") == "toilet":
				var toilet = area.get_parent()
				toilet.clean()
				pass
			elif area.get_parent().get_meta("type") == "trash":
				var trash = area.get_parent()
				trash.remove()
			elif area.get_parent().get_meta("type") == "tent":
				var tent = area.get_parent()
				tent.remove()

	elif event.is_action_pressed("fire"):
		#var e = expl.instantiate()
		#e.position = get_global_mouse_position()
		#get_tree().root.add_child(e)

		$WaterParticles.emitting = true
	elif event.is_action_released("fire"):
		$WaterParticles.emitting = false

func _physics_process(delta):
	get_input()
	rotation += rotation_direction * rotation_speed * delta
	move_and_slide()
	if $WaterParticles.emitting:
		for area in $WaterArea.get_overlapping_areas():
			if area.get_parent().has_method("extinguish"):
				area.get_parent().extinguish()

func _on_attack_timer_timeout():
	$Sprite.visible = true
	$SpriteAttack.visible = false
