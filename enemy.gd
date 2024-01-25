extends Area2D

signal died

@export var max_health = 2
@export var speed = 50.0
@export var healthbar_width = 32
var health
var target
var death_particles_scene = preload("res://enemy_death_particles.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
    health = max_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if target != null:
        position += Vector2(speed * delta, 0).rotated(get_angle_to(target.position))


func _on_area_entered(area):
    if "bullet" in area.get_groups():
        # subtract bullet damage from health
        health -= area.damage
        # explode bullet
        area.explode()
        # check if dead
        if health <= 0:
            var particles = death_particles_scene.instantiate()
            particles.position = position
            get_parent().add_child(particles)
            died.emit()
            queue_free()
        else:
            # update healthbar
            var bar_size = (health / max_health) * healthbar_width
            $RemainingHealth.size.x = floor(bar_size)
