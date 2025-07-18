extends Node3D

var time: float
@export var day_length: float = 20.0
@export var start_time: float = 0.3
var time_rate: float

# sun
var sun : DirectionalLight3D
@export var sun_color: Gradient
@export var sun_intensity: Curve

# moon
var moon : DirectionalLight3D
@export var moon_color: Gradient
@export var moon_intensity: Curve

# ambient and sky
@export var ambient_intensity: Curve
@export var sky_energy: Curve

# environment
var env: Environment
var sky_material: ProceduralSkyMaterial
@export var sky_top_color: Gradient
@export var sky_horizon_color: Gradient


func _ready() -> void:
	time_rate = 1.0 / day_length
	time = start_time
	
	sun = get_node("Sun")
	moon = get_node("Moon")
	
	var world_env = get_node("WorldEnvironment")
	env = world_env.environment
	
	var sky_res = env.sky
	if sky_res and sky_res.sky_material is ProceduralSkyMaterial:
		sky_material = sky_res.sky_material
	
	
func _process(delta: float) -> void:
	time += time_rate * delta
	
	if time > 1.0:
		time = 0.0
		

	# sun
	sun.rotation_degrees.x = time * 360 + 90
	sun.light_color = sun_color.sample(time)
	sun.light_energy = sun_intensity.sample(time)
	
	# moon 
	moon.rotation_degrees.x = time * 360 + 270
	moon.light_color = moon_color.sample(time)
	moon.light_energy = moon_intensity.sample(time)
	
	# ambient energy
	env.ambient_light_energy = ambient_intensity.sample(time)

	# sky energy
	if sky_material:
		sky_material.energy_multiplier = sky_energy.sample(time)

	# night sky
	sky_material.sky_top_color = sky_top_color.sample(time)
	sky_material.sky_horizon_color = sky_horizon_color.sample(time)
