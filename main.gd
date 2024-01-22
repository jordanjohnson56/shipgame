extends Node

var projectile = preload("res://projectile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    # close game with escape
    if Input.is_action_pressed("close_game"):
        get_tree().quit()

    # Fire when clicked
    if Input.is_action_pressed("fire") and $FireCooldown.is_stopped():
        var shot = projectile.instantiate()
        shot.position = $Player.position
        add_child(shot)
        $FireCooldown.start()
        $FireSound.play()
