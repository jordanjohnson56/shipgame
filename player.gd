extends Area2D

signal hurt
signal died

@export var max_health = 3
var health = max_health
var active = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    # Set rotation based on mouse position
    look_at(get_global_mouse_position())


func enable():
    health = max_health
    show()
    active = true


func take_damage():
    health -= 1
    hurt.emit()
    # check if dead
    if health <= 0:
        hide()
        active = false
        died.emit()


func _on_area_entered(area):
    if active and "enemy" in area.get_groups():
        take_damage()
        area.queue_free()
