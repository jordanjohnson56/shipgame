extends Area2D

signal hurt
signal died

@export var max_health = 3
var health


# Called when the node enters the scene tree for the first time.
func _ready():
    health = max_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    # Set rotation based on mouse position
    look_at(get_global_mouse_position())
    # check if dead
    if health <= 0:
        hide()
        $CollisionPolygon2D.disabled = true
        died.emit()


func take_damage():
    health -= 1
    hurt.emit()


func _on_area_entered(area):
    if "enemy" in area.get_groups():
        take_damage()
        area.queue_free()
