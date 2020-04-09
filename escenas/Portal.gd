extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var direcciones=["192.168.1.0/24","172.16.0.0/16"]

# Called when the node enters the scene tree for the first time.
func _ready():
	var tabla=""
	
	for i in direcciones:
		tabla=tabla+i+"\n"
	$Viewport/etiqueta.text=tabla


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
