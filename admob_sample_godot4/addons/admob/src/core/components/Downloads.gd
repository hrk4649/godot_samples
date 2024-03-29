@tool
extends VBoxContainer

@onready var AdMobEditor : Control = find_parent("AdMobEditor")

@onready var godot_version : String = "v" + str(Engine.get_version_info().major) + "." + str(Engine.get_version_info().minor) + "." + str(Engine.get_version_info().patch)
var string_dont_have_connection := "[b]You don't have connection to the Server: %s, please verify your connection in order to Download[/b]"
var actual_downloading_file : String = ""
var downloaded_plugin_version : String = ""
var version_support : Dictionary

var android_dictionary : Dictionary = {
		"download_directory" : "res://addons/admob/downloads/android"
	} : 
		set(value):
			android_dictionary = value
			$TabContainer/Android/ChangeDirectoryHBoxContainer/DownloadDirectoryLabel.text =  current_dir_download_label % android_dictionary.download_directory

var ios_dictionary : Dictionary = {
		"download_directory" : "res://addons/admob/downloads/ios"
	} : 
		set(value):
			ios_dictionary = value 
			$TabContainer/iOS/ChangeDirectoryHBoxContainer/DownloadDirectoryLabel.text =  current_dir_download_label % ios_dictionary.download_directory

var current_dir_download_label = "Current Download Directory: %s"
var download_complete_message = "Download of %s completed! \n%s"

func _ready():
	$DontHaveConnectionPanelContainer/Label.text = string_dont_have_connection % $VerifyNetworkGithub.server_to_test

	if godot_version[godot_version.length()-1] == "0":
		godot_version = godot_version.substr(0, godot_version.length()-2)

	set_process(false)
	$TabContainer/Android/ChangeDirectoryHBoxContainer/DownloadDirectoryLabel.text =  current_dir_download_label % android_dictionary.download_directory
	$TabContainer/iOS/ChangeDirectoryHBoxContainer/DownloadDirectoryLabel.text =  current_dir_download_label % ios_dictionary.download_directory

func _process(delta):
	var bodySize = $TabContainer/HTTPRequest.get_body_size()
	var downloadedBytes = $TabContainer/HTTPRequest.get_downloaded_bytes()
	var percent = int(downloadedBytes*100/bodySize)
	$ProgressBar.value = percent


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	if response_code != 200:
		$AdviceAcceptDialog.dialog_text = "!!!DOWNLOAD FAILED!!!"
		$ProgressBar.value = 0
	else:
		$AdviceAcceptDialog.dialog_text = download_complete_message % [actual_downloading_file, downloaded_plugin_version]

	set_process(false)
	$AdviceAcceptDialog.popup_centered()


func _on_DownloadGoogleMobileAdsSdkiOS_pressed():
	var file_name = "googlemobileadssdkios.zip"
	var plugin_version = version_support.ios
	$TabContainer/HTTPRequest.download_file = ios_dictionary.download_directory + "/" + file_name
	$TabContainer/HTTPRequest.request("https://github.com/Poing-Studios/godot-admob-ios/releases/download/" + plugin_version + "/" + file_name)
	actual_downloading_file = file_name
	downloaded_plugin_version = "iOS Plugin Version: " + plugin_version

	set_process(true)

func _on_DownloadiOSTemplate_pressed():
	var file_name = "ios-template-" + godot_version + ".zip"
	var plugin_version = version_support.ios
	$TabContainer/HTTPRequest.download_file = ios_dictionary.download_directory + "/" + file_name
	$TabContainer/HTTPRequest.request("https://github.com/Poing-Studios/godot-admob-ios/releases/download/" + plugin_version + "/" + file_name)
	actual_downloading_file = file_name
	downloaded_plugin_version = "iOS Plugin Version: " + plugin_version
	
	set_process(true)

func _on_DownloadAndroidTemplate_pressed():
	var file_name = "android-template-" + godot_version + ".zip"
	var plugin_version = version_support.android
	$TabContainer/HTTPRequest.download_file = android_dictionary.download_directory + "/" + file_name
	$TabContainer/HTTPRequest.request("https://github.com/Poing-Studios/godot-admob-android/releases/download/" + plugin_version + "/" + file_name)
	actual_downloading_file = file_name
	
	downloaded_plugin_version = "Android Plugin Version: " + plugin_version
	
	set_process(true)


func _on_AndroidChangeDirectoryFileDialog_dir_selected(dir):
	self.android_dictionary.download_directory = dir

func _on_AndroidChangeDirectoryButton_pressed():
	$TabContainer/Android/ChangeDirectoryHBoxContainer/AndroidChangeDirectoryFileDialog.popup_centered()


func _on_iOSChangeDirectoryFileDialog_dir_selected(dir):
	self.ios_dictionary.download_directory = dir

func _on_iOSChangeDirectoryButton_pressed():
	$TabContainer/iOS/ChangeDirectoryHBoxContainer/iOSChangeDirectoryFileDialog.popup_centered()


func _on_AndroidOpenDirectoryButton_pressed():
	var path_directory = ProjectSettings.globalize_path(android_dictionary.download_directory)
	OS.shell_open(str("file://", path_directory))


func _on_iOSOpenDirectoryButton_pressed():
	var path_directory = ProjectSettings.globalize_path(ios_dictionary.download_directory)
	OS.shell_open(str("file://", path_directory))


func _on_verify_network_github_network_status_changed(value):
	if value == $VerifyNetworkGithub.CONNECTED:
		$TabContainer.visible = true
		$DontHaveConnectionPanelContainer.visible = false
	else:
		$TabContainer.visible = false
		$DontHaveConnectionPanelContainer.visible = true


func _on_VersionSupportedHTTPRequest_supported_version_changed(value_dictionary : Dictionary):
	version_support = value_dictionary
