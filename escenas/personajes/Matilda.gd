extends KinematicBody

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#signal andar()
#signal rotar_derecha()
#signal rotar_izquierda()
#signal esperar()

signal fin_de_movimiento()

export var velocidad_andar=100
export var andar_temporizador=1
export var parar_temporizador=1

var direccion=Vector3(0,0,1)

enum ESTADOS {parado,andando,muriendo,bailando,rotando_derecha,rotando_izquierda}

var estado=ESTADOS.parado

# Called when the node enters the scene tree for the first time.
func _ready():
	#get_node("../HUD/GridContainer/bAndar").connect("andar",self,"andar")
	pass # Replace with function body.

func esperar():
	estado=ESTADOS.parado
	$Temporizador.start(parar_temporizador)
	
func rotar_derecha():
	estado=ESTADOS.rotando_derecha
	$AnimationPlayer.play("rotar-derecha")

func rotar_izquierda():
	estado=ESTADOS.rotando_izquierda
	$AnimationPlayer.play("rotar-izquierda")

func andar():
	$Temporizador.start(andar_temporizador)
	estado=ESTADOS.andando
	$AnimationPlayer.play("andando")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	
	match estado:
		ESTADOS.andando:
			direccion=get_global_transform().basis.z.normalized()
			direccion.y=-1
			var mover=move_and_slide(velocidad_andar*direccion*delta)
			
#			if mover.y<0:
#				print(mover)
			
func parar():
	estado=ESTADOS.parado
	$AnimationPlayer.play("default")

func _on_Temporizador_timeout():
	$Temporizador.stop()
		
	match estado:
		ESTADOS.andando, ESTADOS.parado, ESTADOS.rotando_derecha,	ESTADOS.rotando_izquierda:
			parar()
			emit_signal("fin_de_movimiento")
		
			
			
func _on_animation_finished(anim_name):
	
	match anim_name:
		"rotar-derecha":
			
			rotate(Vector3.UP,-PI/2)
			print("Fin rotar derecha")
			print("Rotado a derecha?")
			emit_signal("fin_de_movimiento")

			
		"rotar-izquierda":
			rotate(Vector3.UP,PI/2)
			print("Fin rotar izquierda")
			print("Rotado a izquierda?")
			emit_signal("fin_de_movimiento")
			
