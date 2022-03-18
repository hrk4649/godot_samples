extends Control

func _input(event):
    pass
    if event is InputEventKey:
        var result = ""
        result += event.as_text()
        result += "\n"
        result += "scancode:" + str(event.scancode)
        $Label.text = result
        print(result)
