extends Node2D

func _ready():
    pass

func _on_VideoPlayer_finished():
    pass # Replace with function body.
    print("play again")
    $VideoPlayer.play()
