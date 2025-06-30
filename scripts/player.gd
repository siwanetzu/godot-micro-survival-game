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
	pass

func _process(delta: float) -> void:
	camera.position = head.global_position
	
func _physics_process(delta: float) -> void:
	pass
	
