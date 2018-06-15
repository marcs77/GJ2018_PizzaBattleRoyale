extends CanvasLayer

var player

func _ready():
	player = get_parent().get_parent()
	
func _process(delta):
	$Municion.text = str (player.points)
	$Vida.text = str(player.health)