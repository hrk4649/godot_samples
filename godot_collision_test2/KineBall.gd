extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var gravity = Vector3(0,-0.15,0)

var velocity = Vector3(0,0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func get_input():
    # Detect up/down/left/right keystate and only move when pressed.
#    velocity = Vector2()
    if Input.is_action_pressed('ui_right'):
        velocity.x = 1
    if Input.is_action_pressed('ui_left'):
        velocity.x = -1
    if Input.is_action_pressed('ui_down'):
        velocity.z = 1
    if Input.is_action_pressed('ui_up'):
        velocity.z = -1
    if Input.is_action_pressed('ui_accept'):
        velocity.y += 1
#    velocity = velocity.normalized() * speed


func _physics_process(delta):
    get_input()
    velocity += gravity
    var vel_delta = velocity * delta
    var collision = move_and_collide(vel_delta)
    if collision:
        print("collision:" + str(collision))
        print("collider:" + str(collision.collider.name))
        var bounce_rate = 0.85
        if collision.collider is StaticBody and collision.collider.physics_material_override != null:
            bounce_rate = collision.collider.physics_material_override.bounce
#        print("bounce_rate:" + str(bounce_rate))
#        print("position:" + str(collision.position))
#        print("normal:" + str(collision.normal))
#        print("travel:" + str(collision.travel))
#        print("remainder:" + str(collision.remainder))
#        # change velocity as reflection
#        print("velocity:" + str(velocity))
#        print("normal:" + str(collision.normal))
#        # velocity = velocity.reflect(collision.normal)
            var bounce = velocity.bounce(collision.normal)
#        var reflect = velocity.reflect(collision.normal)
#        print("bounce:" + str(bounce))
#        print("reflect:" + str(reflect))
            velocity = bounce * bounce_rate
            pass
