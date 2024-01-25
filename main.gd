extends Node

@export var initial_enemy_timer: float = 1.0
var crosshair = preload("res://art/crosshair.png")
var projectile_scene = preload("res://projectile.tscn")
var enemy_scene = preload("res://enemy.tscn")
var game_started = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    # close game with escape
    if Input.is_action_pressed("close_game"):
        get_tree().quit()

    if game_started:
        # Fire when clicked
        if Input.is_action_pressed("fire") and $FireCooldown.is_stopped():
            var shot = projectile_scene.instantiate()
            shot.position = $Player.position
            add_child(shot)
            $FireCooldown.start()
            play_fire_sound()


func start_game():
    $Player.enable()
    $EnemySpawnTimer.wait_time = initial_enemy_timer
    $EnemySpawnTimer.start()
    $Seconds.start()
    $HUD.set_health($Player.health)
    Input.set_custom_mouse_cursor(crosshair, Input.CURSOR_ARROW, Vector2(16,16))
    game_started = true


func spawn_enemy():
    var enemy = enemy_scene.instantiate()
    # set enemy position
    var spawn_point = get_node("EnemySpawns/EnemySpawnPoint")
    spawn_point.progress_ratio = randf()
    enemy.position = spawn_point.position
    # set enemy's target
    enemy.target = $Player
    # connect death to death sound
    enemy.died.connect(play_enemy_death_sound)
    # create enemy
    add_child(enemy)


func game_over():
    $EnemySpawnTimer.stop()
    $Seconds.stop()
    $HUD.game_over()
    Input.set_custom_mouse_cursor(null)
    game_started = false
    $GameOverSound.play()
    await get_tree().create_timer(3).timeout
    $HUD.reset()
    get_tree().call_group("enemy", "queue_free")


func _on_player_hurt():
    $HUD.set_health($Player.health)
    var particles = $HitParticles.duplicate()
    particles.emitting = true
    particles.position = $Player.position
    particles.finished.connect(particles.queue_free)
    add_child(particles)
    $PlayerDamageSound.play()


func _on_difficulty_timer_timeout():
    var new_wait_time = clamp($EnemySpawnTimer.wait_time - 0.05, 0.05, 1)
    $EnemySpawnTimer.wait_time = new_wait_time
    # Add one second to difficulty timer so difficulty doesn't ramp up too quickly
    $DifficultyTimer.wait_time += 1


func play_fire_sound():
    # Pick random fire sound
    var child_index = randi_range(0, $FireSounds.get_child_count() - 1)
    var fire_sound = $FireSounds.get_child(child_index)
    fire_sound.play()


func play_enemy_death_sound():
    $EnemyDeathSound.play()
