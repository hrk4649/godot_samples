extends Node2D

# for creating instances of Piece scene
export (PackedScene) var Piece

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var numOfPiece = 9

# true if the left button of mouse is pressed
var isLeftButtonPressed = false

# Vector2 instance that is the position where the mouse cursole is on the piece
var grabbedPiecePosition = null

# Piece instance that is grabbed
var grabbedPiece = null

func get_initial_position(idx = 0):
	var widthPiece = 100
	var heightPiece = 100
	var num = int(sqrt(numOfPiece))
	var x = (idx % num) * widthPiece * 1.05
	var y = int(idx / num) * heightPiece * 1.05
	return Vector2(x,y)

func get_picture_position(idx = 0):
	var widthPiece = - 100
	var heightPiece = - 100
	var num = int(sqrt(numOfPiece))
	var x = (idx % num) * widthPiece
	var y = int(idx / num) * heightPiece
	return Vector2(x,y)

# Called when the node enters the scene tree for the first time.
func _ready():
	for idx in range(0, numOfPiece):
		# create an instace of Piece node
		var p = Piece.instance()
		# set the position of the Piece node
		p.set_position(get_initial_position(idx))
		# set the position of TextureRect named Picture to display the part of the image.
		p.get_node("Picture").set_position(get_picture_position(idx))
		add_child(p)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			#print_debug("InputEventMouseButton:" + str(event.pressed))
			isLeftButtonPressed = event.pressed
			if isLeftButtonPressed == false:
				grabbedPiece = null
				grabbedPiecePosition = null
				return
			var children = get_children()
			for child in children:
				# find the piece under the mouse cursol
				if child.get_rect().has_point(event.position):
					grabbedPiece = child
					# change the order of this child in parent to show on top
					remove_child(grabbedPiece)
					add_child(grabbedPiece)
					# keep the position where the mouse cursole is on the piece
					grabbedPiecePosition = Vector2(
						get_local_mouse_position().x - grabbedPiece.get_rect().position.x,
						get_local_mouse_position().y - grabbedPiece.get_rect().position.y)
	if event is InputEventMouseMotion:
		if isLeftButtonPressed 	and grabbedPiece != null and grabbedPiecePosition != null:
			
			# move the piece to follow the mouse cursol.
			var pos = Vector2(
				event.position.x - grabbedPiecePosition.x,
				event.position.y - grabbedPiecePosition.y)
			grabbedPiece.set_position(pos)
