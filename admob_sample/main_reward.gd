extends Control

func _ready():
    MobileAds.connect("rewarded_ad_failed_to_load", self, "_on_rewarded_ad_failed_to_load")
    MobileAds.connect("rewarded_ad_loaded", self, "_on_rewarded_ad_loaded")
    MobileAds.connect("rewarded_ad_failed_to_show", self, "_on_rewarded_ad_failed_to_show")
    MobileAds.connect("rewarded_ad_opened", self, "_on_rewarded_ad_opened")
    MobileAds.connect("rewarded_ad_clicked", self, "_on_rewarded_ad_clicked")
    MobileAds.connect("rewarded_ad_closed", self, "_on_rewarded_ad_closed")
    MobileAds.connect("rewarded_ad_recorded_impression", self, "_on_rewarded_ad_recorded_impression")

    # MobileAds.connect("rewarded_user_earned_rewarded", self, "_on_rewarded_user_earned_rewarded")
    MobileAds.connect("user_earned_rewarded", self, "_on_user_earned_rewarded")

func _on_rewarded_ad_loaded():
    print("_on_rewarded_ad_loaded")
    MobileAds.show_rewarded()

func _on_rewarded_ad_failed_to_load(error_code):
    print("_on_rewarded_ad_failed_to_load: %s" % error_code)

func _on_rewarded_ad_opened():
    print("_on_rewarded_ad_opened")

func _on_rewarded_ad_closed():
    print("_on_rewarded_ad_closed")

func _on_rewarded_ad_clicked():
    print("_on_rewarded_ad_clicked")

func _on_rewarded_ad_failed_to_show():
    print("_on_rewarded_ad_failed_to_show")

func _on_rewarded_ad_recorded_impression():
    print("_on_rewarded_ad_recorded_impression")

func _on_user_earned_rewarded(currency, amount):
    print("_on_user_earned_rewarded:(currency,amount)=(%s, %s)" % [currency, amount])

func _on_SHOW_pressed():
    MobileAds.load_rewarded()

