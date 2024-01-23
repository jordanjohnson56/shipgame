extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
    $Message.text = ""


func set_health(score):
    $Health.text = str(score)


func game_over():
    $Message.text = "GAME OVER"
