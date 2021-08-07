extends Spatial

func _ready():
    $AnimationPlayer.play("Bend")

func _on_AnimationPlayer_animation_finished(anim_name):
    $AnimationPlayer.play("Bend")
