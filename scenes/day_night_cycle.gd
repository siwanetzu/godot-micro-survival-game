extends Node3D

var time: float
@export var day_length: float = 20.0
@export var start_time: float = 0.3
var time_rate: float

var sun : DirectionalLight3D
@export var sun_color: Gradient
@export var sun_intensity: Curve


func _ready() -> void:
	time_rate = 1.0 / day_length
	time = start_time
	
	sun = get_node("Sun")
	
func _process(delta: float) -> void:
	time += time_rate * delta
	
	if time > 1.0:
		time = 0.0
		
	sun.rotation_degrees.x = time * 360 + 90
	sun.light_color = sun_color.sample(time)
	
