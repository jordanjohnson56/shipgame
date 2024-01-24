extends Area2D

@export var speed: float = 600.0
@export var damage: float = 0.5
var explosion_scene = preload("res://explode_particles.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
    rotation = get_global_mouse_position().angle_to_point(position) + PI


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    position += Vector2(speed * delta, 0).rotated(rotation)


func explode():
    var particles = explosion_scene.instantiate()
    particles.position = position
    get_parent().add_child(particles)
    queue_free()


func _on_lifetime_timeout():
    queue_free()
