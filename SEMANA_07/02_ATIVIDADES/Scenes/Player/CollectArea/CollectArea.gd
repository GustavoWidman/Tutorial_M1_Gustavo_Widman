# O código abaixo é uma classe em GDScript que estende a classe Area2D. 
extends Area2D

# Define os sinais que esta classe emite
signal item_tracked(item) # Sinal emitido quando um item é rastreado
signal item_collected(item) # Sinal emitido quando um item é coletado
signal item_untracked # Sinal emitido quando nenhum item é rastreado

# Variáveis usadas para armazenar o item rastreado e os itens sobrepostos
var _tracked_item = null
var _overlapped_items = []

# Função chamada quando um evento de entrada é detectado
func _input(event):
	if event.is_action_pressed("collect"):
		collect_item(_tracked_item)

# Função para coletar o item rastreado
func collect_item(node):
	if not _tracked_item: # Se não houver item rastreado, não faça nada
		return
	emit_signal("item_collected", str(node).get_slice(":",0)) # Emite sinal de que um item foi coletado
	update_tracked_item() # Atualiza o item rastreado
	node.queue_free() # Libera o nó do item coletado da memória

# Função chamada quando um objeto entra na área da colisão deste objeto
func _on_area_entered(area):
	if str(area).get_slice("A",0) == "Item": # Se o objeto que entrou na área da colisão for um item
		_overlapped_items.append(area) # Adiciona o item à lista de itens sobrepostos
		update_tracked_item() # Atualiza o item rastreado

# Função chamada quando um objeto sai da área da colisão deste objeto
func _on_area_exited(area):
	if str(area).get_slice("A",0) == "Item": # Se o objeto que saiu da área da colisão for um item
		_overlapped_items.erase(area) # Remove o item da lista de itens sobrepostos
		update_tracked_item() # Atualiza o item rastreado

# Função que atualiza o item rastreado
# Esta função é chamada sempre que um objeto entra ou sai da área de colisão deste objeto
func update_tracked_item():
	if not _overlapped_items: # Se não houver itens sobrepostos, o item rastreado é nulo
		_tracked_item = null
		emit_signal("item_untracked") # Emite sinal de que nenhum item está sendo rastreado
	else:
		_tracked_item = _overlapped_items[0] # O item rastreado é o primeiro item na lista de itens sobrepostos
		emit_signal("item_tracked", _tracked_item) # Emite sinal de que um item está sendo rastreado

# Função chamada quando um botão é pressionado
func _on_TouchScreenButton_pressed():
	collect_item(_tracked_item) # Chama a função para coletar o item rastreado
