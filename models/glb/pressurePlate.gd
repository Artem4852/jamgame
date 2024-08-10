extends Node3D

@export var collider: CollisionShape3D
@export var plate: StaticBody3D
@export var bridge1: Node3D
@export var bridge2: Node3D
@export var bridge3: Node3D
@export var bridge4: Node3D
@export var bridges: Node3D
@export var particleSystem: GPUParticles3D

var broken = false

var appearingSpeed = 70

func _ready():
	pass

func check_for_overlaps():
	var area = collider.get_parent() as Area3D
	if area:
		var overlapping_bodies = area.get_overlapping_bodies()
		var n = 0;
		for body in overlapping_bodies:
			var tag = body.get_meta('tag', 'empty')
			if tag == 'crate' and int(body.linear_velocity.y) == 0 and not body.freeze:
				n += 1
		return n
			

func _process(delta):
	var overlaps = check_for_overlaps()
	if overlaps > 4: 
		broken = true
		particleSystem.emitting = true
	plate.position.y = clamp(-0.02 * overlaps, -0.1, 0)
	if not broken:
		if bridge1:
			var bridge1 = bridge1.get_child(0)
			if overlaps > 0:
				bridge1.position.y = clamp(bridge1.position.y+appearingSpeed*delta, -100, 0)
			else:
				bridge1.position.y = clamp(bridge1.position.y-appearingSpeed*delta, -100, 0)
		if bridge2:
			var bridge2 = bridge2.get_child(0)
			if overlaps > 1:
				bridge2.position.y = clamp(bridge2.position.y+appearingSpeed*delta, -100, 0)
			else:
				bridge2.position.y = clamp(bridge2.position.y-appearingSpeed*delta, -100, 0)
		if bridge3:
			var bridge3 = bridge3.get_child(0)
			if overlaps > 2:
				bridge3.position.y = clamp(bridge3.position.y+appearingSpeed*delta, -100, 0)
			else:
				bridge3.position.y = clamp(bridge3.position.y-appearingSpeed*delta, -100, 0)
		if bridge4:
			var bridge4 = bridge4.get_child(0)
			if overlaps > 3:
				bridge4.position.y = clamp(bridge4.position.y+appearingSpeed*delta, -100, 0)
			else:
				bridge4.position.y = clamp(bridge4.position.y-appearingSpeed*delta, -100, 0)
	else:
		var bridges_individual = bridges.get_children()
		for bridge in bridges_individual:
			var bridge_ch = bridge.get_child(0)
			bridge_ch.position.y = clamp(bridge_ch.position.y+appearingSpeed*delta, -100, 0)
