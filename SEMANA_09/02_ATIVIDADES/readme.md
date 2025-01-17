Problema proposto no Adalove:<br>
++++++++++++++++++++++++++++++++++++++<br>
Dado os seguintes algoritmos (https://github.com/Intelihub/Tutorial_M1/tree/main/SEMANA_09/02_ATIVIDADES), responda qual a complexidade deles?

Também, crie um algoritmo que recebe 10 números do usuário e ordene de formar crescente.

Coloque na resposta do Adalove a complexidade (Use a notação Big-O) dos algoritmos e o link para seu algoritmo.
++++++++++++++++++++++++++++++++++++++

São duas atividades:<br>

1- Identificar o custo dos algoritmos abaixo baseando-se no Autoestudo: Análise de Complexidade de Algoritmos<br>
2-Criar um algoritmo que receba 10 números e ordene-os de forma crescente, dentro do Godot.<br>

Lembre-se de:<br>
-Comentar seu código<br>
-Justificar sua resposta de complexidade para cada algoritmo abaixo<br>

Sua resposta no Adalove deve conter:<br>
-A complexidade e justificativa para cada algoritmo abaixo<br>
-O link para seu github com o projeto do Godot com o algoritmo criado<br>
```
#Algoritmo 1
n=0
for i in range(0,100):
  n+=1
  print(n)

// o algoritimo acima tem complexidade O(n) pois ele executa uma operação de soma e uma de impressão, e isso é feito 100 vezes, ou seja, o número de operações é proporcional ao número de iterações. (resumidamente, um unico for, entao a complexidade é O(n))

#Algoritmo 2
nome="TEO"
vet_nome=["T", "E", "O","B", "A", "L", "D", "O"]
while(nome!= "TEOBALDO"):
  while(len(nome)<8):
    nome+=vet_nome[len(nome)]
    print(nome)

// o algoritimo acima tem complexidade O(n²) pois ele executa uma operação de soma e uma de impressão, e isso é feito 100 vezes, ou seja, o número de operações é proporcional ao número de iterações. (resumidamente, dois whiles, entao a complexidade é O(n²))

#Algoritmo 3
k=100
l=1000000000
soma=k+l
print(soma)

// o algoritimo acima tem complexidade O(1) pois ele executa uma operação de soma e uma de impressão, e isso é feito 100 vezes, ou seja, o número de operações é proporcional ao número de iterações. (resumidamente, nenhum for ou while etc, entao a complexidade é O(1))

#Algoritmo 4
def binary_search(vetor, menor_indice, maior_indice, elemento_procurado):
   if maior_indice >= menor_indice:      
      indice_do_meio = (menor_indice+maior_indice) // 2
      if vetor[indice_do_meio] == elemento_procurado:
        return indice_do_meio
       
      elif vetor[indice_do_meio] > elemento_procurado:
        return binary_search(vetor, maior_indice, indice_do_meio - 1, elemento_procurado)
       
      else:
        return binary_search(vetor, indice_do_meio + 1, maior_indice, elemento_procurado)

// o algoritimo acima tem complexidade O(log n) pois ele executa uma operação de soma e uma de impressão, e isso é feito 100 vezes, ou seja, o número de operações é proporcional ao número de iterações. (resumidamente, o algoritimo é recursivo, entao a complexidade é O(log n))

#Algoritmo 5
m=0
n=1000
for i in range (0,n):
  for k in range (0,n):
    for l in range(0,n):
      print(m)
      m+=1
```
// o algoritimo acima tem complexidade O(n³) pois ele executa uma operação de soma e uma de impressão, e isso é feito 100 vezes, ou seja, o número de operações é proporcional ao número de iterações. (resumidamente, três fors, entao a complexidade é O(n³))