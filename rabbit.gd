extends KinematicBody2D

# Declaração das vairáveis
var rapidez = 80
var velocidade = Vector2.ZERO

onready var rabbit = $char_rabbit # O nome do nó do herói
var parar_rabbit

func pegar_teclas():
	# Detecta se as teclas das setas do teclado foram pressionadas
	velocidade = Vector2.ZERO
	if Input.is_action_pressed('ui_right'):
		rabbit.play("padrao")
		velocidade.x += 1
	if Input.is_action_pressed('ui_left'):
		rabbit.play("padrao")
		velocidade.x -= 1
	if Input.is_action_pressed('ui_left') && Input.is_action_pressed("ui_down"):
		rabbit.play("")
		velocidade.x = 0
		velocidade.y = 0
	if Input.is_action_pressed('ui_down'):
		rabbit.play("padrao")
		velocidade.y += 1
	if Input.is_action_pressed('ui_right') && Input.is_action_pressed("ui_down"):
		rabbit.stop()
		velocidade.x = 0
		velocidade.y = 0
	if Input.is_action_pressed('ui_up'):
		rabbit.play("padrao")
		velocidade.y -= 1
	if Input.is_action_pressed('ui_right') && Input.is_action_pressed("ui_up"):
		rabbit.play("")
		velocidade.x = 0
		velocidade.y = 0
	if Input.is_action_pressed('ui_left') && Input.is_action_pressed("ui_up"):
		rabbit.play("")
		velocidade.x = 0
		velocidade.y = 0
	if velocidade.length() > 0:
		velocidade = velocidade.normalized() * rapidez
		rabbit.play()
	else:
		rabbit.stop()

func _physics_process(delta):
	pegar_teclas()
	return move_and_collide(velocidade * delta)
