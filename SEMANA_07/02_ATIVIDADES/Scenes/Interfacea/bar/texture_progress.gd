extends TextureProgress

# Esta função é chamada sempre que o valor máximo da barra é alterado
# O parâmetro 'maximum' é o novo valor máximo da barra
func _on_Bar_maximum_changed(maximum):
	
	# Atribuímos o valor máximo da barra à variável 'max_value'
	max_value = maximum
