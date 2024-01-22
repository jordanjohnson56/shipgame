extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    # Set rotation based on mouse position
    #var mouse_position = get_viewport().get_mouse_position()
    #var viewport_center = get_viewport_rect().get_center()
    #var direction = viewport_center - mouse_position
    #rotation = -direction.angle_to(Vector2.DOWN)
    look_at(get_global_mouse_position())
