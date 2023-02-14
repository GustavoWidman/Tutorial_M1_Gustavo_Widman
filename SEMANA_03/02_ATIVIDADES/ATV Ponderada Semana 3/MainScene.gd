extends Node2D

#definir variaveis
var input1
var input2
var input3

#definir arrays
var arrayPreDefined = ["String", 1, 1.2, false]
var arrayToBeDefined = []


#funcao que retorna um texto na tela
func returnPreDefText():
	#edita o texto do label, inserindo a array pre-definida com o separador ", " entre itens
	$PreDefRect/PreDefTextLabel.text = String(", ".join(arrayPreDefined))

#funcao que recebe um valor inserido pelo usuário e retorna na tela.
func returnUserText():
	#recebe e atribui os valores dos inputs a variaveis
	input1 = str($Input1.text)
	input2 = str($Input2.text)
	input3 = str($Input3.text)
	#insere os valores atribuidos acima na lista
	arrayToBeDefined.append(input1)
	arrayToBeDefined.append(input2)
	arrayToBeDefined.append(input3)
	
	#edita o texto do label, inserindo a array pre-definida com o separador ", " entre itens
	$UserRect/UserTextLabel.text = String(", ".join(arrayToBeDefined))


func _on_PreTextButton_pressed():
	returnPreDefText()


func _on_UserTextButton_pressed():
	returnUserText()
