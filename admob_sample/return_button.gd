extends Button

func _ready():
    pass # Replace with function body.

func _on_Button_pressed():
    var scene_main = load("res://main.tscn").instance()
    var parent = get_parent()
    get_tree().get_root().add_child(scene_main)
    get_tree().get_root().remove_child(parent)
