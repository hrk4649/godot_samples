extends Control

func _ready():
	MobileAds.connect("banner_loaded", Callable(self, "_on_banner_loaded"))
	MobileAds.connect("banner_failed_to_load", Callable(self, "_on_banner_failed_to_load"))
	MobileAds.connect("banner_opened", Callable(self, "_on_banner_opened"))
	MobileAds.connect("banner_clicked", Callable(self, "_on_banner_clicked"))
	MobileAds.connect("banner_closed", Callable(self, "_on_banner_closed"))
	MobileAds.connect("banner_recorded_impression", Callable(self, "_on_banner_recorded_impression"))
	MobileAds.connect("banner_destroyed", Callable(self, "_on_banner_destroyed"))

func _on_banner_loaded():
	pass
	print("_on_banner_loaded")

func _on_banner_destroyed():
	pass
	print("_on_banner_destroyed")

func _on_banner_failed_to_load(error_code):
	pass
	print("_on_banner_failed_to_load:error_code:" + str(error_code))

func _on_banner_opened():
	pass
	print("_on_banner_opened")

func _on_banner_clicked():
	pass
	print("_on_banner_clicked")

func _on_banner_closed():
	pass
	print("_on_banner_closed")

func _on_banner_recorded_impression():
	pass
	print("_on_banner_recorded_impression")

func _on_Button_toggled(button_pressed):
	if button_pressed:
		pass
		MobileAds.load_banner()
	else:
		pass
		MobileAds.destroy_banner()
