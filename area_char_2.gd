extends Area2D

###############################################################################
# Script de mensagem para interagir com NPC's e objetos. Você pode adicionar  #
# um variável para ele parar quando estiver interagindo.                      #
#                                                                             #
# Autor: Gold Angel                                                           #
# Data: Dia 08 de Janeiro de 2023, 15:25                                      #
# Agradecimentos/Thanks to KoBeWi                                             #
###############################################################################

# Declaração das variáveis
var pagina = 0
var total_paginas = 1
var proxima_pagina
var colisao_player = false
var primeira_pagina = true
var finalizar_texto
				 #page 0              #page 1
var mensagem = ["Hello! How are you?", "Good adfasdasdasdas"]
onready var texto_mensagem = get_parent().get_node("area_char_2/message_box/message")
onready var exibir_caixa_mensagem = get_parent().get_node("area_char_2/message_box")
onready var rabbit = get_parent().get_node("rabbit/char_rabbit")
onready var rabbit_stop = get_parent().get_node("rabbit")
onready var interaction_name_kinematicbody2D = get_parent().get_node("rabbit/colidir")

# Função mostrar a mensagem
func show_message():
	exibir_caixa_mensagem.visible = true
	texto_mensagem.bbcode_enabled = true
	texto_mensagem.set_bbcode(mensagem[pagina])
	texto_mensagem.show()

# Função esconder a mensagem
func hide_message():
	exibir_caixa_mensagem.visible = false
	texto_mensagem.hide()
	texto_mensagem.visible_characters = -1

# Função interagir com objetos e NPC's
func interacao():
	if Input.is_action_just_pressed("ui_accept") && (primeira_pagina == true) && interaction_name_kinematicbody2D.is_colliding() && (rabbit.animation == "padrao"):
		exibir_caixa_mensagem.visible = true
		pagina = 0
		$sound.stream_paused = false
		while (texto_mensagem.visible_characters) <= (texto_mensagem.text.length()):
			texto_mensagem.visible_characters += 1
			$sound.play()
			yield(get_tree().create_timer(0.1), "timeout")
			show_message()
		yield(get_tree().create_timer(0.2), "timeout")

		proxima_pagina = true
		primeira_pagina = false

# Próxima página. Para mais páginas acrescentar no topo do script
	if Input.is_action_just_released("ui_accept") && proxima_pagina == true:
		if (pagina < total_paginas) && (texto_mensagem.visible_characters) >= (texto_mensagem.text.length()):
			texto_mensagem.visible_characters = -1
			pagina = pagina + 1
			$sound.stream_paused = false
			proxima_pagina = false
		if (proxima_pagina == false) && (Input.is_action_just_released("ui_accept")):
			while (texto_mensagem.visible_characters) <= (texto_mensagem.text.length()):
				texto_mensagem.visible_characters += 1
				$sound.play()
				yield(get_tree().create_timer(0.1), "timeout")
				show_message()
		if (pagina > 1):
			show_message()
		if (pagina >= total_paginas) && (texto_mensagem.visible_characters) >= (texto_mensagem.text.length()):
			finalizar_texto = true

#Fim da mensagem
	if (Input.is_action_just_released("ui_accept")) && (finalizar_texto == true):
		$sound.stream_paused = true
		texto_mensagem.visible_characters = -1
		hide_message()
		$sound.stop()
		yield(get_tree().create_timer(0.3), "timeout")
		primeira_pagina = true
		finalizar_texto = false

func _physics_process(_delta):
	interacao()
