extends Control

func _ready():
	MobileAds.connect("interstitial_failed_to_load", Callable(self, "_on_interstitial_failed_to_load"))
	MobileAds.connect("interstitial_loaded", Callable(self, "_on_interstitial_loaded"))
	MobileAds.connect("interstitial_failed_to_show", Callable(self, "_on_interstitial_failed_to_show"))
	MobileAds.connect("interstitial_opened", Callable(self, "_on_interstitial_opened"))
	MobileAds.connect("interstitial_clicked", Callable(self, "_on_interstitial_clicked"))
	MobileAds.connect("interstitial_closed", Callable(self, "_on_interstitial_closed"))
	MobileAds.connect("interstitial_recorded_impression", Callable(self, "_on_interstitial_recorded_impression"))

func _on_interstitial_loaded():
	MobileAds.show_interstitial()
	$Button.disabled = false
	print("_on_interstitial_loaded")

func _on_interstitial_failed_to_load(error_code ):
	print("_on_interstitial_failed_to_load:error_code:" + str(error_code))

func _on_interstitial_failed_to_show(error_code ):
	print("_on_interstitial_failed_to_show:error_code:" + str(error_code))

func _on_interstitial_closed():
	print("_on_interstitial_closed")

func _on_interstitial_opened():
	print("_on_interstitial_opened")

func _on_interstitial_clicked():
	print("_on_interstitial_clicked")
	
func _on_interstitial_recorded_impression():
	print("_on_interstitial_recorded_impression")

func _on_Button_pressed():
	print("_on_Button_pressed")
	$Button.disabled = true
	MobileAds.load_interstitial()
	
