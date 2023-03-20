extends HBoxContainer

# Essa função é chamada quando um item é coletado na cena.
# O parâmetro "item" é o nó do item que foi coletado.
func _on_CollectArea_item_collected(item):
	# Verifica se o item coletado é "ItemA1"
	if item == "ItemA1":
		# Torna o nó "ItemA1" visível, atualizando o display dos itens coletados na tela
		$ItemA1.visible = true
	# Se não for "ItemA1", verifica se é "ItemA2"
	elif item == "ItemA2":
		# Torna o nó "ItemA2" visível, atualizando o display dos itens coletados na tela
		$ItemA2.visible = true
	# Se não for nenhum dos anteriores, verifica se é "ItemA3"
	elif item == "ItemA3":
		# Torna o nó "ItemA3" visível, atualizando o display dos itens coletados na tela
		$ItemA3.visible = true
