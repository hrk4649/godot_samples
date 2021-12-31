extends KinematicBody

var move_speed = 5.0
var rotate_speed_deg = 3.0

func _ready():
    pass # Replace with function body.

func _process(delta):
    """
    get joy-pad statuses and move player
    """
    pass
    # https://docs.godotengine.org/ja/stable/tutorials/inputs/controllers_gamepads_joysticks.html#which-input-singleton-method-should-i-use
    var vector_left = Input.get_vector("stick_l_left", "stick_l_right", "stick_l_forward", "stick_l_back")

    var vector_right = Input.get_vector("stick_r_left", "stick_r_right", "stick_r_forward", "stick_r_back")

    rotate1(vector_right, delta)
    move2(vector_left, vector_right, delta)

func rotate1(vector_right, delta):
    """
    rotate with axises of player's local coordination
    """
    var rotation = rotation_degrees
    #rotation.x += rotate_speed_deg * vector_right.y
    rotation.y += rotate_speed_deg * - vector_right.x
    rotation_degrees = rotation
    
func move2(vector_left, vector_right, delta):
    """
    move player with consideration to player's direction
    """
    var vel = Vector3(vector_left.x, 0, vector_left.y) * move_speed * delta
    # rotate velocity with local rotation.y
    # print("move2:rotation.y:"+str(rotation.y))
    vel = vel.rotated(Vector3.UP, rotation.y)
    
    global_transform.origin += vel

func move1(vector_left, delta):
    var vel = Vector3(vector_left.x, 0, vector_left.y) * move_speed * delta
    global_transform.origin += vel
