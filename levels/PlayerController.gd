extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const cameraRotationSpeed = 0.004

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var cameraPivot := $cameraPivot
@onready var camera := $cameraPivot/Camera3D

func _unhandled_input(event):
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed('ui_cancel'):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			cameraPivot.rotate_y(-event.relative.x * cameraRotationSpeed)
			camera.rotate_x(-event.relative.y * cameraRotationSpeed)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-30), deg_to_rad(60))

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (cameraPivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
