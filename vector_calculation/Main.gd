extends Spatial



func _ready():
    pass
    calc_result_by_vector3()

func calc_result_by_vector3():
    var ball = $Ball
    var ball_velocity = $BallVelocity
    var player = $Player
    var target = $Target

    var vec_velo_ball = ball_velocity.global_transform.origin - ball.global_transform.origin
    var vec_player_ball = player.global_transform.origin - ball.global_transform.origin
    var proj = vec_player_ball.project(vec_velo_ball)
    var result_origin = ball.global_transform.origin + proj
    
    target.global_transform.origin = result_origin

func calc_result_by_plane():
    var ball = $Ball
    var ball_velocity = $BallVelocity
    var player = $Player
    var target = $Target

    # calc a plane on which ball and ball velocity are located
    var plane_ball = Plane(ball.global_transform.origin, 
        ball.global_transform.origin + Vector3.UP,
        ball_velocity.global_transform.origin)
    var result_origin = plane_ball.project(player.global_transform.origin)

    target.global_transform.origin = result_origin
