extends Control

func _ready():
	pass # Replace with function body.

func _on_Button1_pressed():
	var scene_banner = load("res://main_banner.tscn").instantiate()
	get_tree().get_root().add_child(scene_banner)
	get_tree().get_root().remove_child(self)

func _on_Button2_pressed():
	var scene_interstitial = load("res://main_interstitial.tscn").instantiate()
	get_tree().get_root().add_child(scene_interstitial)
	get_tree().get_root().remove_child(self)

func _on_Button3_pressed():
	var scene_reward = load("res://main_reward.tscn").instantiate()
	get_tree().get_root().add_child(scene_reward)
	get_tree().get_root().remove_child(self)
