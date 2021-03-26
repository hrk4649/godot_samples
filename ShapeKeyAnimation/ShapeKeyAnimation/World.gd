extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# keep playing animation
	if $GreenHead/AnimationPlayer.is_playing() == false:
		# choose an animation to play
		var animations = $GreenHead/AnimationPlayer.get_animation_list()
		var idx = randi() % animations.size()
		var to_play = animations[idx]
		$GreenHead/AnimationPlayer.play(to_play)
	pass
