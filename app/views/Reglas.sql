16 Atributos:
  Campañas (Status): Activa, Inactiva, Finalizada
  Clientes (Status): Ninguno, Potencial, Actual
  Clientes (StatusActual): Activo, Inactivo
  Clientes (Edad): Niño, Joven, Adulto, Anciano
  Clientes (Genero): Hombre, Mujer
  Clientes (Educación): Ninguna, Primaria, Secundaria, Preparatoria o Bachillerato, Licenciatura, Maestria o Doctorado
  Clientes (Ocupación): Estudiante, Labores del hogar, Profesionales por cuenta ajena, Profesionales por cuenta propia, Desempleado, Directivo, Cargos Intermedios, Otros
  Clientes (Estado civil): Soltero, Unión Libre, Casado, Divorciado, Viudo
  Clientes (Clase social): Baja, Media, Alta
  Emails (Status): Enviado, En espera, Leido
  Clientes (Tendencia): Primavera, Verano, Otoño, Invierno
  Clientes (Ocasión de compra): Ocasión ordinaria, Ocasión especial
  Mercados (Status): Objetivo, Activo, Inactivo
  Usuarios (Roles): Administrador, Jefe de Marketing, Promotor, Vendedor

Espacio de búsqueda
(3 x 2 x 4 x 2 x 6 x 8 x 5 x 5 x 3 x 3 x 7 x 9 x 4 x 2 x 3 x 4) = 3,135,283,200

Ejemplo

  Reglas (Lista de decisiones)

  Si Usuario.Rol = Administrador o Usuario.Rol = Jefe de Marketing y Mercado.Objetivo Entonces Crear.Camapaña

  --Potenciales o actuales
  Si Cliente.Edad = Joven y (Cliente.Genero = Hombre o Cliente.Genero = Mujer) y Cliente.Escuela = Licenciatura y Cliente.Ocupacion = Estudiante y Cliente.Estado_Civil = Soltero y Cliente.Clase_Social = Media y Cliente.Status = Ninguno Entonces Cliente.Status = Potencial

  --Estatus del cliente
  Si Cliente.Status = Actual y Cliente.Compras > 0 Entonces Cliente.StatusActual = Activo

  --Edad Cliente (Niño, Joven, Adulto Joven, Alduto Maduro, Anciano)
  Clientes.Birthday (Fecha_nacimiento)
  If Cliente.Edad >= 0 AND Cliente.Edad < 12 Then Cliente.Cliente = Niño(a)
  If Cliente.Edad >= 12 AND Cliente.Edad < 18 Then Cliente.Cliente = Joven
  If Cliente.Edad >= 18 AND Cliente.Edad < 35 Then Cliente.Cliente = Adulto Joven
  If Cliente.Edad >= 35 AND Cliente.Edad < 59 Then Cliente.Cliente = Adulto Maduro
  If Cliente >= 60 Then Cliente.Cliente = Anciano

  0 a 11 -> Niños (as)
  12 a 17 -> Jovenes
  18 a 34 -> Adulto Joven
  35 a 59 -> Adulto Maduro
  60 -> Ancianos (as)

  --Ingresos por tamaño de familia, y estado civil


  --Clase Social se determina por:
  -- Ocupación, Educación, Familia, Estado_Civil Ingresos
  If (Cliente.Ocupacion = Desempleado OR Cliente.Ocupacion = Otros OR Cliente.Ocupacion = Labores del hogar) AND (Cliente.Educación = Niguna OR Cliente.Educación = Primaria o Cliente.Educación = Secundaria) Then Cliente.Clase_Social = Baja

  If (Cliente.Ocupacion = Cargos Intermedios OR Cliente.Ocupacion = Profesionales por cuenta propia OR Cliente.Ocupacion = Profesionales por cuenta ajena) AND (Cliente.Educación = Primaria OR Cliente.Educación = Preparatoria o Bachillerato Cliente.Educación.Licenciatura OR Cliente.Educación = Doctorado o Maestria) Then = Cliente.Clase_Social = Media

  If Cliente.Ocupacion = Directivo AND (Cliente.Educación = Licenciatura OR Cliente.Educación = Maestria o Doctorado) Then Cliente.Clase_Social = Alta

  --Campañas (Activa, Inactiva, Finalizada)
  If Campañas.Date_Start <= Campañas.Now AND Campañas.Date_End >= Campañas.Now Then Campañas.Status = Activa
  If Campañas.Date_Start > Campañas.Now Then Campañas.Status = Inactiva
  If Campañas.Date_End < Campañas.Now Then Campañas.Status = Finalizada



foreign key (table_name_id) references table_names(id),
