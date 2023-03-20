extends TextureRect

# Aqui estamos definindo uma variável privada chamada _offset
var _offset

# Aqui estamos definindo uma função interna chamada _ready que será chamada assim que o objeto for criado
func _ready():
	# Aqui estamos definindo o valor da variável _offset como sendo um objeto Vector2 que tem a metade da largura do retângulo como sua coordenada x e uma distância de 20 pixels acima do topo do retângulo como sua coordenada y
	_offset = Vector2(rect_size.x / 2, - rect_size.y - 20.0)

# Aqui estamos definindo uma função chamada _on_CollectArea_item_untracked que será chamada quando um item não for rastreado pelo coletor
func _on_CollectArea_item_untracked():
	# Aqui estamos tornando o objeto invisível
	visible = false

# Aqui estamos definindo uma função chamada _on_CollectArea_item_tracked que será chamada quando um item for rastreado pelo coletor
func _on_CollectArea_item_tracked(item):
	# Aqui estamos tornando o objeto visível
	visible = true
	# Aqui estamos definindo a posição do objeto como sendo a posição global do item adicionada do valor da variável _offset
	rect_position = item.global_position + _offset
