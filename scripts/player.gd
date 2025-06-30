extends CharacterBody3D

var camera: Camera3D
var head: Node3D 

@export var move_speed: float = 5.0
@export var jump_force: float = 5.0
@export var gravity: float = 9.0

@export var look_sens: float = 0.5
var min_x_rot: float = -85.0
var max_x_rot: float = 85.0
var mouse_dir: Vector2


func _ready() -> void:
	camera = get_node("Camera3D")
	head = get_node("Head")
	remove_child(camera)
	get_node("/root/Main").add_child.call_deferred(camera)
	
func _input(event):
	if event is InputEventMouseMotion:
		camera.rotation_degrees.x += event.relative.y * -look_sens
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, min_x_rot, max_x_rot)
		
		camera.rotation_degrees.y += event.relative.x * -look_sens
		
		
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

func _process(delta: float) -> void:
	camera.position = head.global_position
	
func _physics_process(delta: float) -> void:
	var input = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	
	velocity.x = input.x * move_speed
	velocity.z = input.y * move_speed
	
	move_and_slide()
