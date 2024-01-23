extends Node

var projectile_scene = preload("res://projectile.tscn")
var enemy_scene = preload("res://enemy.tscn")
var game_started = false

# Called when the node enters the scene tree for the first time.
func _ready():
    $EnemySpawnTimer.start()
    $HUD.set_health($Player.health)
    game_started = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    # close game with escape
    if Input.is_action_pressed("close_game"):
        get_tree().quit()

    # Fire when clicked
    if Input.is_action_pressed("fire") and $FireCooldown.is_stopped():
        var shot = projectile_scene.instantiate()
        shot.position = $Player.position
        add_child(shot)
        $FireCooldown.start()
        $FireSound.play()


func spawn_enemy():
    var enemy = enemy_scene.instantiate()
    # set enemy position
    var spawn_point = get_node("EnemySpawns/EnemySpawnPoint")
    spawn_point.progress_ratio = randf()
    enemy.position = spawn_point.position
    # set enemy's target
    enemy.target = $Player
    # create enemy
    add_child(enemy)


func game_over():
    game_started = false
    $HUD.game_over()


func _on_player_hurt():
    $HUD.set_health($Player.health)


func _on_enemy_spawn_timer_timeout():
    if game_started:
        spawn_enemy()
