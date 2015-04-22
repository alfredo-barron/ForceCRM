<?php

Técnica: Segementación.

Tipo de Cliente:
Si (Ventas == 0) es Potencial/Contacto
Si no entonces es Actual
Si Tipo de Clientes Actual

El 20% de nuestros clientes facturan aproximadamente el 80% de las ventas de nuestra compañia y, por tanto, el trato y atencion que se debe prestar a este selectivo modelo de clientes debe ser diferente.

Una segmentación ABC es una forma estrategica de conocer a los clientes para asi poder profundizar y obtener el maximo aprovechamiento de los mismos.

Clientes A: son los mejores clientes que acumulando sus ventas llegan hasta el 20% de la venta de la compañia. Generalmente son un numero reducido.

Clientes B: son aquellos clientes que acumulan ventas entre el 20% y 50%. Con este segmento hay que intentar mantenerlos y hacer lo posible para pasarlos a A.

Clientes C: son el resto de los clientes y generalmente muy numerosos y su grado de confianza es menor.

-> Ventas: Ordenar de mayor a menor

Clasificación ABC
ID|Cliente|Ventas|Porcentaje de Ventas|Ventas acumuladas|Porcentaje de ventas acumuladas|Tipo
1  -------  600      40%                      600                40%                      B
2  -------  500      33.33%                  1100                73.33%                   C
3  -------  200      13.33%                  1300                86.66%                   C
4  -------  150      10%                     1450                96.66%                   C
5  -------   50       0.334%                 1500                100%                     C
------------------------------------------------------------------------------------------------
  Total  SUM(1500)  SUM(100%)

   Total      Total%
   1500 es el 100%
   Venta
   600 es el "X"%

   (600 * 100)/1500 = X

   Ventas[i] = Ventas + Ventas[i]
   %Ventas[i] = %Ventas + %Ventas[i]

   Si (%Ventas <= 0 AND %Ventas => 20)
    Entonces Tipo de Cliente es ClienteA
   Sino (%Ventas > 20 AND %Ventas => 50)
    Entonces Tipo de Cliente es ClienteB
   Sino (%Ventas > 50)
    Entonces Tipo de Cliente es ClienteC

  Si (ClientesA == 0)
    Entonces Trabajar con ClientesB y ClientesC
  Si (ClientesA != 0)
    Entonces Trabajar con ClientesB y Clasificar ClientesA

  Si (ClientesB == 0)
    Entonces Trabajar con ClientesC
  Si (Clientes != 0)
    Entonces Clasificar ClientesB

  Si (ClientesC == 0)
    Entonces Promotores y Vendedores Buscar Clientes
  Si (ClientesC != 0)
    Entonces Trabajar y Clasificar ClientesC

  //Clase social se obtiene de la educacion, ocupacion e ingresos
  Si ((Educacion == Ninguna OR Educacion == Primaria OR Educacion == Secundaria) AND (Ocupacion == Desempleado OR Ocupacion == Estudiante OR Ocupacion == Labores del hogar)) Entonces Clase_Social es Baja

  Si ((Educacion == Preparatoria o Bachillerato OR Educacion == Licenciatura OR Educacion == Maestria o Doctorado) AND (Ocupacion == Profesionales por cuenta ajena OR Ocupacion == Profesionales por cuenta propia OR Ocupacion == Cargos intermedios)) Entonces Clase Social es Media

  Si ((Educacion == Licenciatura OR Educacion == Maestria o Doctorado) AND (Ocupacion == Directivo)) Entonces Clase Social es Alta

  //Ingresos se obtiene con estatus civil y tamaño de familia



  --Trabajo de Gobierno
  --Trabajo de Educacion
  --Trabajo de Salud
  --Fuerzas armadas


  --Estudiante
  --Desempleado
  --Labores del hogar
  --Profesionales por cuenta ajena
  --Profesionales por cuenta propia
  --Cargos intermedios
  --Directivos
  --Otros

