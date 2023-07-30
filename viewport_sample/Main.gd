extends Node2D

var current_angle = 0
var speed_angle = 3
var radius = 50
var center = Vector2(120, 120)

func _process(delta):

    process_tr1_tr2()
    process_tr3()
    #process_tr3_2()

func process_tr1_tr2():
    #var img = get_viewport().get_texture().get_data()
    var img = $ViewportContainer/Viewport.get_texture().get_data()
    img.flip_y()
    # Convert Image to ImageTexture.
    var tex = ImageTexture.new()
    tex.create_from_image(img)

    var size = Vector2(200,150)
    var atlas_tex1 = AtlasTexture.new()
    atlas_tex1.atlas = tex
    atlas_tex1.region = Rect2(Vector2(0,0),size)
    $TextureRect1.texture = atlas_tex1

    var atlas_tex2 = AtlasTexture.new()
    atlas_tex2.atlas = tex
    atlas_tex2.region = Rect2(Vector2(200,150),size)
    $TextureRect2.texture = atlas_tex2

func process_tr3():
    pass
    #var img = $ViewportContainer2/Viewport.get_texture().get_data()
    var img = $Viewport.get_texture().get_data()
    img.flip_y()
    # Convert Image to ImageTexture.
    var tex = ImageTexture.new()
    tex.create_from_image(img)

    var size = Vector2(200,150)
    var atlas_tex = AtlasTexture.new()
    atlas_tex.atlas = tex
    atlas_tex.region = Rect2(Vector2(100,75),size)
    $TextureRect3.texture = atlas_tex

func process_tr3_2():
    pass
    var txt = $Viewport.get_texture()

    var size = Vector2(200,150)
    var atlas_tex = AtlasTexture.new()
    atlas_tex.atlas = txt
    atlas_tex.region = Rect2(Vector2(100,75),size)
    $TextureRect3.texture = atlas_tex
