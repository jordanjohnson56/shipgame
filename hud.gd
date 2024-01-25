extends CanvasLayer

signal start_game

var time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
    reset()


func pause_menu():
    $Message.text = "PAUSED"
    $QuitButton.show()


func reset():
    $Message.text = "Pressure"
    $StartButton.show()
    $QuitButton.show()


func set_time(new_time):
    time = new_time
    var minutes = floor(time / 60)
    var seconds = time % 60
    $Time.text = "%01d:%02d" % [minutes, seconds]


func set_health(score):
    get_node("Health/Label").text = str(score)


func game_over():
    $Message.text = "GAME OVER"


func _on_seconds_timeout():
    set_time(time + 1)


func _on_start_button_pressed():
    hide_menu()
    set_time(0)
    start_game.emit()


func hide_menu():
    $StartButton.hide()
    $QuitButton.hide()
    $Message.text = ""


func _on_quit_button_pressed():
    get_tree().quit()
