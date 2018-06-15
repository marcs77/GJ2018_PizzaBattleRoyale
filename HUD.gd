extends CanvasLayer

var player

func _ready():
	player = get_parent().get_parent()
	
func _process(delta):
	$Label.text = str (player.points)