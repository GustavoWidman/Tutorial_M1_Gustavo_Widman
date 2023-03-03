# Extendendo a classe Node2D
extends Node2D

# Declarando variáveis
var numero: int
var lista: Array = []
var nome: String
var cont: int = 0

# Função para coletar dados inseridos pelo usuário
func _on_Button_pressed():
	# Coletando número e nome inseridos pelo usuário
	numero = int($LineEdit.text.get_slice("/", 0))
	nome = str($LineEdit.text.get_slice("/", 1))

# Função para incrementar o número inserido pelo usuário e mostrar os resultados em uma lista
func _on_Button2_pressed():
	# Loop para incrementar o número e adicionar na lista
	for i in range(10):
		numero += i
		lista.append(numero)
	# Atualizando o texto do Label com a lista
	$ColorRect/Label.text = String(", ".join(lista))

# Função para mudar o nome do usuário de acordo com os dados da lista
# Se houver algum número ímpar o nome deve adicionar "baldo" ao final
func _on_Button3_pressed():
	# Loop para verificar se há algum número ímpar na lista
	for i in range(len(lista)):
		if lista[i] % 2 == 1:
			cont += 1
	# Verificando se há números ímpares na lista
	if cont != 0:
		nome = nome + "baldo"
	# Atualizando o texto do Label2 com o nome
	$ColorRect2/Label2.text = nome
