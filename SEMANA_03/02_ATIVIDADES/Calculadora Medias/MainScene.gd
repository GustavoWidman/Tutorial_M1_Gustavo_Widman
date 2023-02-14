extends Node2D

var numeroAlunos
var nota1
var nota2
var mediaNota
var alunoAtual
var arrayNotas = []

func _ready():
	$Input2.visible = false
	$Input3.visible = false
	
	alunoAtual = 0
	
func processar_notas():
	nota1 = float($Input2.text)
	nota2 = float($Input3.text)
	#limpa o texto dos inputs 2 e 3
	$Input2.text = ""
	$Input3.text = ""
	
	mediaNota = (nota1 + nota2)/2
	
	arrayNotas.push_back(mediaNota)
	print(mediaNota)
	
func _on_Button_pressed():
	numeroAlunos = int(get_node("Input1").text)
	if numeroAlunos > 0 and alunoAtual == 0:
		alunoAtual = 1
		$Input2.visible = true
		$Input3.visible = true
		$ColorRect/RichTextLabel.text = "INSIRA AS NOTAS DAS PROVAS DO ALUNO " + String(alunoAtual)
	
	elif alunoAtual != numeroAlunos:
		processar_notas()
		alunoAtual += 1
		$ColorRect/RichTextLabel.text = "INSIRA AS NOTAS DAS PROVAS DO ALUNO " + String(alunoAtual)
	elif alunoAtual == numeroAlunos:
		processar_notas()
		print(arrayNotas)
		print("Finsihed")
		$ColorRect/RichTextLabel.text = "AS MEDIAS DOS ALUNOS FORAM, RESPECTIVAMENTE " + String(", ".join(arrayNotas))
	else:
		$ColorRect/RichTextLabel.text = "O NUMERO DE ALUNOS DEVE SER MAIOR DO QUE 0 E INTEIRO"

	
