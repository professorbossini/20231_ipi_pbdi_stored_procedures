def somar(*parametros):
    # return sum(parametros)
    resultado = 0
    for valor in parametros:
        resultado += valor
    return resultado

print(somar(1))
print(somar(1, 2))
print(somar(1, 6, 5, 4, 3, 2, 1))
print(somar())


# def somar (a, b):
#     return a + b

# def somar (a, b, c):
#     return a + b + c


# print(somar(1, 2))

# print(somar(1, 2, 3))