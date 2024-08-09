extends Node3D

@export var collider: CollisionShape3D
@export var plate: StaticBody3D
@export var bridge1: StaticBody3D
@export var bridge2: StaticBody3D
@export var bridge3: StaticBody3D
@export var bridge4: StaticBody3D

func _ready():
	pass

func check_for_overlaps():
	var area = collider.get_parent() as Area3D
	if area:
		var overlapping_bodies = area.get_overlapping_bodies()
		var n = 0;
		for body in overlapping_bodies:
			var tag = body.get_meta('tag')
			if tag == 'crate' and int(body.linear_velocity.y) == 0:
				print("Overlapping with Crate ", n)
				n += 1
		return n
			

func _process(delta):
	var overlaps = check_for_overlaps()
	plate.position.y = clamp(-0.02 * overlaps, -0.1, 0)
	if bridge1:
		if overlaps > 1:
			bridge1.position.y == -0.045
		else:
			bridge1.position.y == -100
