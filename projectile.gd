extends Area2D

@export var speed: float = 600.0
@export var damage: float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
    rotation = get_global_mouse_position().angle_to_point(position) + PI


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    position += Vector2(speed * delta, 0).rotated(rotation)


func _on_lifetime_timeout():
    queue_free()
