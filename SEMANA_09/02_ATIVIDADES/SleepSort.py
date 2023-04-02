import time
import threading

# algoritimo de ordenação por tempo de espera, sem usar qualquer tipo de recurso de ordenação ou comparação
def sleep_sort(numbers):
    start = time.time() # define uma variavel para o tempo inicial, usada para calcular o tempo total de execução
    sorted_numbers = []

    def add_number(number):
        time.sleep(number * 1e-3)
        sorted_numbers.append(number)
    for number in numbers:
        # Start a new thread to add the number to the sorted list
        threading.Thread(target=add_number, args=[number]).start()
        time.sleep(0.001) # add a small delay between adding each number to the sorted list
    # Wait for all threads to finish
    time.sleep(max(numbers) * 1e-3)

    end = time.time() # define uma variavel para o tempo final, usada para calcular o tempo total de execução

    print("Total time: ", (end - start)*1e3, "ms") # imprime o tempo total de execução em milissegundos
    return sorted_numbers

if __name__ == '__main__':
    lst = [1, 5, 3, 2, 4]
    print("Result: ", sleep_sort(lst))  