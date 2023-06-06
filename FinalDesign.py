import networkx as nx #Libreria para grafos y redes (markov)

#-------------------------------------------------------------------------- REGLAS DE INFERENCIA
reglas = [
    #Regla 1 => Si el paciente tiene cambios de ánimo y dificultad para dormir, entonces puede tener depresión
    (["cambios de animo", "dificultad para dormir"], "Depresion"), 

    #Regla 2 => Si el paciente presenta ansiedad y ataques de pánico, entonces puede tener ansiedad
    (["preocupacion extrema", "ataques de panico"], "Trastorno de ansiedad"),

    #Regla 3 => Si el paciente muestra episodios_de_tristeza_extrema y aislamiento social, entonces puede  tener trastorno bipolar
    (["episodios de tristeza extrema", "episodios de euforia"], "Trastorno bipolar"),

    #Regla 4 => Si el paciente tiene alucinaciones y delirios, entonces puede tener esquizofrenia
    (["alucinaciones", "delirios", "amnesia", "aislamiento social", "arranques de ira", "comportamientos impulsivos"], "Esquizofrenia"),

    #Regla 5 => Si el paciente tiene dificultades de concentración y falta de interés, entonces puede tener TDAH (Trastorno por déficit de atención e hiperactividad)
    (["dificultades de concentracion", "falta de interes"], "TDAH_Trastorno por Déficit de Atención e Hiperactividad"),

    #Regla 6 => Si el paciente muestra comportamiento compulsivo y obsesiones, podría tener trastorno obsesivo compulsivo (TOC)
    (["comportamiento_compulsivo", "obsesiones"], "TOC_Trastorno Obsesivo Compulsivo")   
    
]

#-------------------------------------------------------------------------- REDES DE MARKOV
#Los valores de probabilidad acordes serian elegidos por medio de un estudio más extenso de cada una de las enfermedades, en este caso ese colocaron de manera hipotetica
red_markov = nx.DiGraph() #Crear una red de Markov con los estados con probabilidades de transición 
red_markov.add_nodes_from(["normal", "depresion", "trastorno_de_ansiedad", "trastorno_bipolar", "esquizofrenia", "tdah", "toc"])
red_markov.add_edge("normal", "depresion", weight=0.1) #El valor 0.05 indica que hay un 5% de probabilidad de pasar de un estado normal a un estado de depresion
red_markov.add_edge("normal", "trastorno_de_ansiedad", weight=0.15)
red_markov.add_edge("normal", "trastorno_bipolar", weight=0.05)
red_markov.add_edge("normal", "esquizofrenia", weight=0.02)
red_markov.add_edge("normal", "tdah", weight=0.08)
red_markov.add_edge("normal", "toc", weight=0.1)
red_markov.add_edge("depresion", "trastorno_de_ansiedad", weight=0.2)
red_markov.add_edge("depresion", "trastorno_bipolar", weight=0.15)
red_markov.add_edge("depresion", "esquizofrenia", weight=0.05)
red_markov.add_edge("depresion", "tdah", weight=0.1)
red_markov.add_edge("depresion", "toc", weight=0.15)
red_markov.add_edge("trastorno_de_ansiedad", "depresion", weight=0.15)
red_markov.add_edge("trastorno_de_ansiedad", "trastorno_bipolar", weight=0.1)
red_markov.add_edge("trastorno_de_ansiedad", "esquizofrenia", weight=0.03)
red_markov.add_edge("trastorno_de_ansiedad", "tdah", weight=0.12)
red_markov.add_edge("trastorno_de_ansiedad", "toc", weight=0.2)
red_markov.add_edge("trastorno_bipolar", "depresion", weight=0.1)
red_markov.add_edge("trastorno_bipolar", "trastorno_de_ansiedad", weight=0.12)
red_markov.add_edge("trastorno_bipolar", "esquizofrenia", weight=0.05)
red_markov.add_edge("trastorno_bipolar", "tdah", weight=0.08)
red_markov.add_edge("trastorno_bipolar", "toc", weight=0.1)
red_markov.add_edge("esquizofrenia", "depresion", weight=0.08)
red_markov.add_edge("esquizofrenia", "trastorno_de_ansiedad", weight=0.1)
red_markov.add_edge("esquizofrenia", "trastorno_bipolar", weight=0.15)
red_markov.add_edge("esquizofrenia", "tdah", weight=0.05)
red_markov.add_edge("esquizofrenia", "toc", weight=0.08)
red_markov.add_edge("tdah", "depresion", weight=0.08)
red_markov.add_edge("tdah", "trastorno_de_ansiedad", weight=0.1)
red_markov.add_edge("tdah", "trastorno_bipolar", weight=0.05)
red_markov.add_edge("tdah", "esquizofrenia", weight=0.08)
red_markov.add_edge("tdah", "toc", weight=0.1)
red_markov.add_edge("toc", "depresion", weight=0.1)
red_markov.add_edge("toc", "trastorno_de_ansiedad", weight=0.15)
red_markov.add_edge("toc", "trastorno_bipolar", weight=0.1)
red_markov.add_edge("toc", "esquizofrenia", weight=0.08)
red_markov.add_edge("toc", "tdah", weight=0.1)


def diagnostico_RI(sintomas): #Función de diagnostico con reglas de inferencia
    for condiciones, resultado in reglas: #Se aplicaran reglas de inferencia para el diagnostico
        if all(sintoma in sintomas for sintoma in condiciones):
            return resultado
    
    return diagnostico_RM(sintomas) #Sino se determina por medio de reglas de inferencia se usan redes de markov

def diagnostico_RM(sintomas): #Función de diagnostico con redes de markov
    probabilidades = {} #Se calcula el diagnostico por medio de la probabilidad de cambio de transición
    estado_actual = "normal" #el estado inicial es normal

    for sintoma in sintomas:
        prox_estado = red_markov.successors(estado_actual) #Para obtener el siguiente estado
        probabilidades = {}
        for estado in prox_estado:
            probabilidades[estado] = red_markov[estado_actual][estado]['weight'] #Toma la probabilidad indicada en la creacion de la red de markov
        estado_actual = max(probabilidades, key=probabilidades.get)
    
    return estado_actual

def diagnostico_main(): #Función para imprimir las preguntas y el diagnostico
    sintomas = []
    
    print("\n\nMINI S.E. MENTAL HEALT")
    print("Ingrese los síntomas uno por uno. Ingrese 'fin' al terminar.")
    
    while True:
        sintoma = input("Síntoma: ")
        if sintoma == "fin":
            break
        sintomas.append(sintoma)
    
    diagnostico = diagnostico_RI(sintomas)
    
    print("El diagnóstico para los síntomas ingresados es:", diagnostico)
    print("\n\n\n")
    
diagnostico_main()