extends CanvasLayer

onready var player = get_tree().root.get_node ("Player")

func _ready():
	pass
	
func _process(delta):
	$Label.text = str (player.points)