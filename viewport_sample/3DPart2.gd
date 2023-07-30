extends Spatial

func _process(delta):
    $Corn.rotate_x(0.3 * delta)
    $Corn.rotate_z(0.3 * delta)
