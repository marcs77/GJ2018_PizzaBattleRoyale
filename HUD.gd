extends CanvasLayer

var player

func _ready():
	player = get_node ("../Player")
	
func _process(delta):
	$Label.text = str (player.points)