-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 22-04-2015 a las 10:04:41
-- Versión del servidor: 5.5.43-0ubuntu0.14.04.1
-- Versión de PHP: 5.5.9-1ubuntu4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `crm`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `campaings`
--

CREATE TABLE IF NOT EXISTS `campaings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_by` int(11) NOT NULL,
  `name` text NOT NULL,
  `date_start` date DEFAULT NULL,
  `date_end` date DEFAULT NULL,
  `status` text COMMENT 'Activa, Inactiva, Finalizada',
  `target` text NOT NULL,
  `description` text NOT NULL,
  `duration` int(11) DEFAULT NULL,
  `date_created` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_campaings_1_idx` (`created_by`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Campañas' AUTO_INCREMENT=20 ;

--
-- Volcado de datos para la tabla `campaings`
--

INSERT INTO `campaings` (`id`, `created_by`, `name`, `date_start`, `date_end`, `status`, `target`, `description`, `duration`, `date_created`) VALUES
(16, 4, 'Primavera - Verano', '2015-04-30', '2015-07-15', 'En espera', 'Rebajas del 50% en sandalias', 'Sandalias', 76, '2015-04-12'),
(17, 4, 'Jovenes Emprendores', '2015-04-01', '2015-04-30', 'Activa', 'Atraer jovenes que busquen nuevos horizontes', 'Jovenes', 28, '2015-04-12'),
(18, 4, 'Estrellas del universo', '2015-04-15', '2015-04-17', 'En espera', 'Toda joyeria para dama con un 5% de descuento', 'Joyas', 3, '2015-04-12'),
(19, 4, 'Dias azules', '2015-02-01', '2015-02-10', 'Finalizada', 'Ofrecer a las chicas blusas de color azul', 'Azul ', 10, '2015-04-12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `campaing_team`
--

CREATE TABLE IF NOT EXISTS `campaing_team` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `teams_id` int(11) NOT NULL,
  `campaings_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_teams_has_campaings_campaings1_idx` (`campaings_id`),
  KEY `fk_teams_has_campaings_teams1_idx` (`teams_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `customers`
--

CREATE TABLE IF NOT EXISTS `customers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `last_name` text NOT NULL,
  `birthday` date DEFAULT NULL,
  `gender` varchar(1) NOT NULL,
  `email` text NOT NULL,
  `telephone` text,
  `street` text NOT NULL,
  `number` int(11) NOT NULL,
  `postcode` int(11) DEFAULT NULL,
  `place` text NOT NULL,
  `city` text NOT NULL,
  `entity` text NOT NULL,
  `type` int(11) DEFAULT NULL,
  `job` int(11) DEFAULT NULL,
  `school` int(11) DEFAULT NULL,
  `status_civil` int(11) DEFAULT NULL,
  `sons` int(11) DEFAULT NULL,
  `status_social` int(11) DEFAULT NULL,
  `status` text NOT NULL,
  `date_created` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_customers_1_idx` (`job`),
  KEY `fk_customers_2_idx` (`postcode`),
  KEY `fk_customers_3_idx` (`school`),
  KEY `fk_customers_4_idx` (`type`),
  KEY `fk_customers_5_idx` (`status_civil`),
  KEY `fk_customers_6_idx` (`status_social`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Clientes' AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `customers`
--

INSERT INTO `customers` (`id`, `name`, `last_name`, `birthday`, `gender`, `email`, `telephone`, `street`, `number`, `postcode`, `place`, `city`, `entity`, `type`, `job`, `school`, `status_civil`, `sons`, `status_social`, `status`, `date_created`) VALUES
(1, 'Alfredo', 'Barrón Rodríguez', '1992-09-11', 'H', 'alfreedobarron@gmail.com', '4813918309', 'Magnolia', 412, 79020, 'Guadalupe', 'Ciudad Valles', 'San Luis Potosí', NULL, 1, 4, 1, 0, NULL, '', '2015-04-22 05:12:33'),
(2, 'Alberto', 'Guerrero Vazquez', '1993-04-29', 'H', 'betho182@gmail.com', '4811216418', 'Diana', 201, 79068, 'Del Carmen', 'Ciudad Valles', 'San Luis Potosí', NULL, 1, 4, 1, 1, NULL, '', '2015-04-22 05:39:31');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `customer_team`
--

CREATE TABLE IF NOT EXISTS `customer_team` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `team_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_teams_has_customers_customers1_idx` (`customer_id`),
  KEY `fk_teams_has_customers_teams1_idx` (`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `emails`
--

CREATE TABLE IF NOT EXISTS `emails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_by` int(11) NOT NULL,
  `campaings_id` int(11) NOT NULL,
  `date_send` date DEFAULT NULL,
  `subject` text CHARACTER SET latin1 NOT NULL,
  `content` text CHARACTER SET latin1 NOT NULL,
  `status` varchar(45) DEFAULT NULL COMMENT 'Enviado, En espera, Leido',
  PRIMARY KEY (`id`),
  KEY `fk_emails_1_idx` (`created_by`),
  KEY `fk_emails_2_idx` (`campaings_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `features`
--

CREATE TABLE IF NOT EXISTS `features` (
  `id` int(11) NOT NULL,
  `feature1` text CHARACTER SET latin1,
  `feature2` text CHARACTER SET latin1,
  `feature3` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jobs`
--

CREATE TABLE IF NOT EXISTS `jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text CHARACTER SET latin1 NOT NULL,
  `salary` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- Volcado de datos para la tabla `jobs`
--

INSERT INTO `jobs` (`id`, `name`, `salary`) VALUES
(1, 'Estudiante', NULL),
(2, 'Labores del hogar', NULL),
(3, 'Profesionales por cuenta ajena', NULL),
(4, 'Profesionales por cuenta propia', NULL),
(5, 'Desempleado', NULL),
(6, 'Directivo', NULL),
(7, 'Cargos Intermedios', NULL),
(8, 'Trabajadores de gobierno', NULL),
(9, 'Trabajadores de educación', NULL),
(10, 'Trabajadores de salud', NULL),
(11, 'Fuerzas armadas', NULL),
(12, 'Otros', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `postcodes`
--

CREATE TABLE IF NOT EXISTS `postcodes` (
  `id` int(11) NOT NULL,
  `place` text CHARACTER SET latin1 NOT NULL,
  `city` text CHARACTER SET latin1 NOT NULL,
  `entity` text CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `postcodes`
--

INSERT INTO `postcodes` (`id`, `place`, `city`, `entity`) VALUES
(78000, 'San Luis Potosí Centro', 'San Luis Potosí', 'San Luis Potosí'),
(78008, 'Oficina Federal de Hacienda', 'San Luis Potosí', 'San Luis Potosí'),
(78009, 'Palacio de Gobierno del Estado de San Luis Potosí', 'San Luis Potosí', 'San Luis Potosí'),
(78037, 'La Paz;Privada Caracol', 'San Luis Potosí', 'San Luis Potosí'),
(78038, 'Tlaxcala', 'San Luis Potosí', 'San Luis Potosí'),
(78040, 'Rinconada de Santiago;Hidalgo', 'San Luis Potosí', 'San Luis Potosí'),
(78048, 'Juan Alvarez', 'San Luis Potosí', 'San Luis Potosí'),
(78049, 'Privada Residencial Real de Alvarez;Villas de Pedro Moreno;Santiago del Río;Santiago del Río;Fresnos del Río;Huerta Real;Residencial las Moras;Privada Altamirano;Conjunto Pedro Moreno', 'San Luis Potosí', 'San Luis Potosí'),
(78100, 'La Matamoros;Mártires de La Revolución;Sáuz;Huachichiles;Rubén Jaramillo;Peñasco;Andalucía;Tercera Chica;Ricardo Flores Magón;Nueva Creación;Villas del Vergel;Molinos del Rey;Torremolinos;Los Magueyes;Valle San José;Terremoto;Barrio Vergel;Los Alcatraces', 'San Luis Potosí', 'San Luis Potosí'),
(78103, 'Milpillas', 'San Luis Potosí', 'San Luis Potosí'),
(78106, 'La Morena', 'San Luis Potosí', 'San Luis Potosí'),
(78107, 'La Tuna', 'San Luis Potosí', 'San Luis Potosí'),
(78109, 'Las Flores;Los Girasoles;Villa de Las Flores II', 'San Luis Potosí', 'San Luis Potosí'),
(78110, 'Imperio Azteca;Garita de Saltillo;San Arturo;El Oasis;Imperio Azteca 2da. Sección;División del Norte;El Saucito;San Fernando;Villas del Roble;Árbol del Gallo;Lucio Cabañas', 'San Luis Potosí', 'San Luis Potosí'),
(78115, 'Santa Rosa', 'San Luis Potosí', 'San Luis Potosí'),
(78116, 'Los Salazares 2a Sección;Rinconadas;La Cruz;Camino Real;El Sauzalito;Rinconada 3ra Sección;Jardines del Sauzal;Jardines del Río;San Angel Inn 3a Sección;Privada San Angelín;San Angel Inn', 'San Luis Potosí', 'San Luis Potosí'),
(78117, 'La Angostura;Jardines de María Cecilia;Granjas La Estrella;María Cecilia 2a Sección;Plan Ponciano Arriaga;María Cecilia 1a Sección;Los Pinos;Villas de Santiago;Villas del Ajusco;Rinconadas de María Cecilia;El Arenal;Maravillas;María Cecilia 3a Sección', 'San Luis Potosí', 'San Luis Potosí'),
(78120, 'San Angel II;San Angel III;Santa Cristina;Privada Vista Hermosa;Fuentes del Sauce;Las Brisas;Los Limones;Buenos Aires;San Angel I;Wenceslao Victoria;Villas del Rosedal;La Forestal;Hidalgo;Residencial Villerias;Condado Sauzal;El Rosedal', 'San Luis Potosí', 'San Luis Potosí'),
(78130, 'Hacienda del Mezquital 2a Sección;Hacienda de Juan Pablo 2a. Sección;Morelos;Rural Atlas;Verde Valle;Hacienda de Juan Pablo 1a. Sección;Jardines del Bosque;Luis Donaldo Colosio;Valle Escondido;Rinconada El Mezquital;El Mezquital;Lomas del Mezquital;Hacienda del Mezquital;Arboledas Jacarandas;Valle Escondido II;Valle del Mezquital;Vistas del Sol;San Miguel;Los Olivos', 'San Luis Potosí', 'San Luis Potosí'),
(78133, 'Villas de Buenos Aires I;Villas de Buenos Aires II;Paseo de las Arboledas;Villas de Buenos Aires III', 'San Luis Potosí', 'San Luis Potosí'),
(78135, 'Privada San Gabriel;Bosques de Jacarandas', 'San Luis Potosí', 'San Luis Potosí'),
(78136, 'Salinas de Gortari;Villas de Jacarandas;Privada de los Arroyo;Hacienda de Santiago;Valle de Jacarandas;Casanova;Valle del Campestre;Lomas del Mezquital 2da;Lomas del Mezquital 3ra. Sección;Jardines de Jacarandas;San Joaquín;Las Julias;Valle de Jacarandas II;Gutiérrez Barrios', 'San Luis Potosí', 'San Luis Potosí'),
(78137, 'La Hacienda;Hacienda de Jacarandas;Hacienda de Jacarandas II;Valle del Tecnológico', 'San Luis Potosí', 'San Luis Potosí'),
(78140, 'Arboledas Tangamanga;Norte;Privada de Bugambilias;Industrial Aviación;Retornos', 'San Luis Potosí', 'San Luis Potosí'),
(78143, 'Tercera Grande;Las Palmas;Moctezuma;Rinconadas del Parque;Colonial 20 de Noviembre;El Terremoto;Pedroza;Ecuestre;Las Morenas;Potosí Río Verde;El Peñol;Canterías;San Sebastián;Campesina Norte', 'San Luis Potosí', 'San Luis Potosí'),
(78144, 'Villas del Saucito II;Las Granjas;Lomas del Río;Naranjos;Las Margaritas;Valle Verde;Villas del Saucito I;Santa Inés;Las Torres de México;Privada de los Agaves', 'San Luis Potosí', 'San Luis Potosí'),
(78145, 'Tecnológico II;Lomas del Campestre;Tecnológico III;Jacarandas INFONAVIT', 'San Luis Potosí', 'San Luis Potosí'),
(78146, 'Tecnológico;Lomas del Camino;Lomas del Sol', 'San Luis Potosí', 'San Luis Potosí'),
(78147, 'Camelinas;Los Molinos;San Humberto;San Alberto', 'San Luis Potosí', 'San Luis Potosí'),
(78148, 'Jacarandas', 'San Luis Potosí', 'San Luis Potosí'),
(78150, 'FOVISSSTE;Morales INFONAVIT;Las Piedras;Santa Lucía', 'San Luis Potosí', 'San Luis Potosí'),
(78153, 'Arboledas del Campestre;Albino García;Privada San Carlos;Villa Campestre;Eucaliptos Campestre;Campestre de Golf;Campestre San Luis', 'San Luis Potosí', 'San Luis Potosí'),
(78154, 'Lomas de Morales;Los Pirules;Verde Campestre;Nuevo Morales;Morales Campestre', 'San Luis Potosí', 'San Luis Potosí'),
(78165, 'Muñoz', 'San Luis Potosí', 'San Luis Potosí'),
(78170, 'Aeropuerto;Los Reyes;Los Reyitos;Las Joyas 2;El Cortijo;Las Palomas;Pedro Moreno;San Juan;Rinconada de Las Arboledas;Privada Alfonsina Storni', 'San Luis Potosí', 'San Luis Potosí'),
(78173, 'Del Bosque;Industrial Aviación 2a Sección;Privada Felipe Ángeles;San Guillermo;Tláloc', 'San Luis Potosí', 'San Luis Potosí'),
(78174, 'Privada Benito Juárez;Villas Vicenza;Los Álamos;Juan del Jarro;Residencial Ogarrio;Residencial San Martín;Damián Carmona;Los Vergeles;Villa San Carlos;Guanos;Misión de Santiago', 'San Luis Potosí', 'San Luis Potosí'),
(78175, 'Hacienda de Bravo;Rinconada de las Flores;Del Río;La Moreña;Puente del Río;Villa de las Flores', 'San Luis Potosí', 'San Luis Potosí'),
(78176, 'Manuel José Othón INFONAVIT;Matehuala;San Javier;Privada Jacarandas;Condesa', 'San Luis Potosí', 'San Luis Potosí'),
(78177, 'García Diego', 'San Luis Potosí', 'San Luis Potosí'),
(78178, 'San Pedro', 'San Luis Potosí', 'San Luis Potosí'),
(78180, 'Morales', 'San Luis Potosí', 'San Luis Potosí'),
(78183, 'Villa Magna', 'San Luis Potosí', 'San Luis Potosí'),
(78200, 'Del Valle;Fuentes del Bosque', 'San Luis Potosí', 'San Luis Potosí'),
(78209, 'Del Parque', 'San Luis Potosí', 'San Luis Potosí'),
(78210, 'Bellas Lomas;Lomas 1a Secc;Los Filtros;Las Cumbres;Loma Alta;Lomas 2a Sección', 'San Luis Potosí', 'San Luis Potosí'),
(78213, 'Primavera Morales;Residencial Morales;Burócratas del Estado', 'San Luis Potosí', 'San Luis Potosí'),
(78214, 'Loma Verde;Miravalle;Villantigua', 'San Luis Potosí', 'San Luis Potosí'),
(78215, 'Loma Dorada;Lomas del Tecnológico;Club de Golf la Loma', 'San Luis Potosí', 'San Luis Potosí'),
(78216, 'Lomas 4a Sección;Santa Mónica;Lomas 4a Sección;Horizontes Residencial;Lomas 3a Secc', 'San Luis Potosí', 'San Luis Potosí'),
(78217, 'Lomas del Pedregal', 'San Luis Potosí', 'San Luis Potosí'),
(78218, 'Villas del Pedregal;Nueva Rinconada de los Andes;Rinconada Andes 2da Sección;Las Haciendas;Rinconada de los Andes;La Loma;Conjunto Victoria', 'San Luis Potosí', 'San Luis Potosí'),
(78219, 'Lomas de los Filtros', 'San Luis Potosí', 'San Luis Potosí'),
(78220, 'Busqueta;Polanco;Residencial El Dorado;Lindavista', 'San Luis Potosí', 'San Luis Potosí'),
(78230, 'Zacatecas;Bugambilias;La Victoria;Los Ángeles;Villas Vallarta;Villas de Anáhuac;Atlas', 'San Luis Potosí', 'San Luis Potosí'),
(78233, 'Moderna', 'San Luis Potosí', 'San Luis Potosí'),
(78234, 'La Arboleda', 'San Luis Potosí', 'San Luis Potosí'),
(78235, 'Privada las Huertas;La Huerta;Arboleda de Tequisquiapan', 'San Luis Potosí', 'San Luis Potosí'),
(78236, 'Vista Verde', 'San Luis Potosí', 'San Luis Potosí'),
(78238, 'Valle de Tequisquiapan', 'San Luis Potosí', 'San Luis Potosí'),
(78239, 'Privada El Campanario;Las Garzas;Valle de Santiago;Llamaradas;Las Norias;San Rafael;Rinconada San Juan', 'San Luis Potosí', 'San Luis Potosí'),
(78240, 'Avenida;El Sol;Virreyes', 'San Luis Potosí', 'San Luis Potosí'),
(78250, 'Parque España;Valle de Bravo;Tequisquiapan;Vista Hermosa;Privada Álamos;Jardines de La Rivera;Tequisquiapan;Cap. Caldera;Valle de Bravo II', 'San Luis Potosí', 'San Luis Potosí'),
(78258, 'Lago Azul', 'San Luis Potosí', 'San Luis Potosí'),
(78259, 'Secretaria de Agricultura Ganadería y Desarrollo Rural', 'San Luis Potosí', 'San Luis Potosí'),
(78260, 'Foresta de Tequis;Las Águilas;Rinconada de los Cipreses', 'San Luis Potosí', 'San Luis Potosí'),
(78268, 'Prados de San Luis', 'San Luis Potosí', 'San Luis Potosí'),
(78269, 'Tangamanga', 'San Luis Potosí', 'San Luis Potosí'),
(78270, 'Burócrata;Jardín;Fundadores;Cuauhtémoc;Río Azul', 'San Luis Potosí', 'San Luis Potosí'),
(78280, 'Benigno Arriaga;Jardines del Estadio;Del Real;Estadio;Alamitos;ISSSTE;Himno Nacional', 'San Luis Potosí', 'San Luis Potosí'),
(78290, 'Universitaria;Viveros', 'San Luis Potosí', 'San Luis Potosí'),
(78294, 'Garita de Jalisco;Colinas del Parque', 'San Luis Potosí', 'San Luis Potosí'),
(78295, 'Alpes;Desarrollo del Pedregal;Sierra Azúl;Privadas del Pedregal', 'San Luis Potosí', 'San Luis Potosí'),
(78298, 'Acacias', 'San Luis Potosí', 'San Luis Potosí'),
(78300, 'Ferrocarrilera;Popular;Joya de Luna;Constitución', 'San Luis Potosí', 'San Luis Potosí'),
(78306, 'Deportivo FFCC', 'San Luis Potosí', 'San Luis Potosí'),
(78307, 'Jalapa', 'San Luis Potosí', 'San Luis Potosí'),
(78308, 'Arenal;España', 'San Luis Potosí', 'San Luis Potosí'),
(78309, 'Avantram;Nuevo España;Nueva Industrial Mexicana;Villas de México;Industrial Mexicana;Avenida México', 'San Luis Potosí', 'San Luis Potosí'),
(78310, 'Montecillo;Librado Rivera;San Luis', 'San Luis Potosí', 'San Luis Potosí'),
(78318, 'San Antonio;Manuel José Othón;Glorieta', 'San Luis Potosí', 'San Luis Potosí'),
(78319, 'Insurgentes', 'San Luis Potosí', 'San Luis Potosí'),
(78320, 'Francisco I Madero;El Paseo', 'San Luis Potosí', 'San Luis Potosí'),
(78328, 'Nuevo Paseo', 'San Luis Potosí', 'San Luis Potosí'),
(78330, 'Bolívar;Bellavista;Independencia', 'San Luis Potosí', 'San Luis Potosí'),
(78338, 'De La Rosa', 'San Luis Potosí', 'San Luis Potosí'),
(78339, 'San Miguelito', 'San Luis Potosí', 'San Luis Potosí'),
(78340, 'Eucaliptos;San Juan de Guadalupe;Guadalupe;Encanto;Julián Carrillo;Las Gaviotas;Jardines de Nuevo Paseo;Niños Héroes', 'San Luis Potosí', 'San Luis Potosí'),
(78342, 'Cereso San Luis Potosí', 'San Luis Potosí', 'San Luis Potosí'),
(78348, 'Campesina', 'San Luis Potosí', 'San Luis Potosí'),
(78349, 'San Sebastián', 'San Luis Potosí', 'San Luis Potosí'),
(78350, 'Revolución;Santa Fe Sur;San Luis Rey;Rinconada Valparaíso', 'San Luis Potosí', 'San Luis Potosí'),
(78356, 'Valle del Santuario', 'San Luis Potosí', 'San Luis Potosí'),
(78357, 'Ricardo Flores Magón', 'San Luis Potosí', 'San Luis Potosí'),
(78358, 'Torres del Santuario;Villa Rica', 'San Luis Potosí', 'San Luis Potosí'),
(78359, 'San Juan de Guadalupe', 'San Luis Potosí', 'San Luis Potosí'),
(78360, 'Gral. Ignacio Martínez;Prof. Graciano Sanchez;Mercado;Privada Circuito Platina;Apostólica;Prof. Graciano Sanchez 2a Sección;5 de Mayo', 'San Luis Potosí', 'San Luis Potosí'),
(78363, 'Universidad Politécnica de San Luis Potosí', 'San Luis Potosí', 'San Luis Potosí'),
(78364, 'La Ladrillera;Las Flores;Tierra Blanca;Tierra Blanca', 'San Luis Potosí', 'San Luis Potosí'),
(78365, 'Campestre Juan Silos', 'San Luis Potosí', 'San Luis Potosí'),
(78366, 'Los Arquitos', 'San Luis Potosí', 'San Luis Potosí'),
(78367, 'Primavera', 'San Luis Potosí', 'San Luis Potosí'),
(78368, 'Xicotencatl', 'San Luis Potosí', 'San Luis Potosí'),
(78369, 'Balcones del Valle;Himno Nacional 2a Secc', 'San Luis Potosí', 'San Luis Potosí'),
(78370, 'Progreso;6 de Junio', 'San Luis Potosí', 'San Luis Potosí'),
(78377, 'Dalias del Llano;Del Llano', 'San Luis Potosí', 'San Luis Potosí'),
(78378, 'Españita', 'San Luis Potosí', 'San Luis Potosí'),
(78379, 'Las Pilitas;Pedregal del Valle;Valle del Potosí;Anáhuac;San Manuel', 'San Luis Potosí', 'San Luis Potosí'),
(78380, 'Lomas de Bellavista;Satélite Francisco I Madero;Simón Diaz;Bellas Lomas;El Santuario;Prados Satélite;Segunda Sección de Bellas Lomas;Lomas de la Virgen', 'San Luis Potosí', 'San Luis Potosí'),
(78384, 'La Constanza;Lomas de Satélite;Tepeyac', 'San Luis Potosí', 'San Luis Potosí'),
(78385, 'Nuevo Progreso;Simón Diaz INFONAVIT;Residencial Salk;Agua Real;Circuito Santa Clara;Residencial del Bosque;Residencial Salk II;Agua Sal;Valle de Las Rosas;Los Pinos;Valle del Progreso;Puerta de Piedra;Simón Diaz Aguaje;Privada Rinconada del Progreso', 'San Luis Potosí', 'San Luis Potosí'),
(78387, 'San Leonel', 'San Luis Potosí', 'San Luis Potosí'),
(78388, 'Constituyentes', 'San Luis Potosí', 'San Luis Potosí'),
(78389, '5 de Febrero;Villa Española;Colorines;Privada Españita;Diagonal;Golondrinas;Los Olivos', 'San Luis Potosí', 'San Luis Potosí'),
(78390, 'Villas del Sol;Rastro;Ricardo B Anaya;Condominios Florencia;Unidad Ponciano Arriaga 3a Sección;Hermenegildo J. Aldana;Prados Glorieta;Abastos 2000;Praderas del Real 2da Sección;Mayamil;Viveros La Libertad;Del Sol;Centro de Abastos;Jardines de Oriente;Jaime Torres Bodet;Providencia;Santa Fe Oriente', 'San Luis Potosí', 'San Luis Potosí'),
(78391, 'Centro Sct San Luis Potosí', 'San Luis Potosí', 'San Luis Potosí'),
(78394, 'Rancho Viejo 1a Secc;Prados Sección Oriente;Las Palmas;Seminario La Misión;Prados San Vicente 2a Secc;Azteca;El Palmar;Misión del Palmar;Villa de Las Torres;Villa Molinos;San Jorge;Rancho Viejo 2a Secc;La Libertad;La Libertad;Silos Zona Dorada;Del Río;Abastos INFONAVIT;La Libertad 1a Secc;Prados San Vicente 3a Secc;Cecilia Occely;Jardines del Rosario;San Cristóbal;Seminario 2000;Enramadas;Ciudad 2000 INFONAVIT;La Libertad 2a Secc;Las Mercedes;Jardines de La Libertad;San Xavier;Praderas del Real;Los Silos;Libertad de México;Los Molinos;Ejido de La Libertad;Arco Iris;El Portal', 'San Luis Potosí', 'San Luis Potosí'),
(78395, 'Arroyos Joya de San Elías;Dalias;Cerrada de las Flores;Providencia Real;Industrias;Zona Industrial;El Bosquecito;Don Miguel;Dalias II;Industrial San Luis', 'San Luis Potosí', 'San Luis Potosí'),
(78396, 'José de Gálvez;Prados San Vicente;Ricardo B Anaya 2a Secc;Residencial Cumbres;Villa Jardín;Minas del Real;Los Almendros II;Obispado;Estrella de Oriente;Los Almendros I', 'San Luis Potosí', 'San Luis Potosí'),
(78397, 'Los Lagos;Poza Real;Villa Delicias;La Esperanza;Nueva Orquídea;Orquídea;Los Olivos;Casanova;Alquerías de Pozos;El Mesón;San Francisco de los Pozos;El Pueblito;Santa Barbara;Las Cruces;Jardines del Edén;Pozos Residencial;Los Aguilares;Gran Morada;Villa Andrea;Alta Vida;Bosques de Linda Vista', 'San Luis Potosí', 'San Luis Potosí'),
(78398, 'Palmar Chico;Misión Loreto;Bosques Esmeralda;Arroyos;San Salvador;Trojes del Sur;Laureles del Sur;Oriental;El Aguaje;Arboledas del Real;Nuestra Señora de La Salud;Antorchistas de Chimalhuacán;Juan Sarabia;Flores del Aguaje;Enrique Flores Magón;Girasoles;El Aguaje;Español;Monte Pío;Aguaje;Los Arbolitos INFONAVIT;Aguaje 2000;El Triangulo;Cumbres de Las Ceibas', 'San Luis Potosí', 'San Luis Potosí'),
(78399, 'Central;Jardines del Sur;Conjunto Rubí;Valle de Dalias;Colonial El Quijote;Nuevo Valle Dorado;Glorieta Central;Esmeralda;Las Joyas;Residencial Dalias;Valle Dorado;Naranjal de Valle Dorado;Residencial las Minas;Rinconada de Valle Dorado;San Patricio;Capricornio;Holanda;Jardines del Sur 2a Sección;Talleres', 'San Luis Potosí', 'San Luis Potosí'),
(78400, 'Angostura El Saucito;Mezquital;Maravillas;Rancho Lourdes;San Juan de la Cruz;Santa Teresa;La Melada;Macarenos;Loma Prieta;La Morita;Las Jarrillas;Pozo Uno el Huizache;Salitrera;Santa Julia;Unidad Benito Juárez (La Chora);Rancho las Flores;Covadonga;El Jacal;Guardiola (El Rosario);El Carril;El Santuario;Rancho el Polvito;San Juan;Cerritos de Zavala;Centzontle;Jesús María;Zamorilla;Pozo Dos el Huizache;Rancho San Blas;Aurelio Arriaga Cárdenas;Bugambilias;El Malacate;El Manzo;Rancho el Nazareno;Rancho Lourdes;Ejido de Bocas (Las Tablitas);Los Conejos;Mezquite Quemado;Noria del Padre;Palmas Grandes;Rancho Nuevo (Rancho Tres Hermanos);Rancho San Agustín', 'San Luis Potosí', 'San Luis Potosí'),
(78403, 'La Huaracha;Las Escobas;El Ranchito;Gonzalitos;La Caldera;La Mesita Verde;El Cascarón;El Granjenal;La Calera (San Cayetano);Palomas;El Gato;La Barranca;El Salto;La Sauceda;Santo Domingo;El Viboriento;Barajas;Las Cuijas (Chaute);Rancho Cañón del Sauz;El Bosque (El Cascarón);La Alameda', 'San Luis Potosí', 'San Luis Potosí'),
(78404, 'Tepozán;El Jaralito;El Huizache;La Encina;Las Lomitas;El Blanco;El Mulato;Cieneguita;El Potrero la Lobera;El Ranchito;Los Llanos;Tanque Cieneguita;La Estancita;Los Coyotes', 'San Luis Potosí', 'San Luis Potosí'),
(78405, 'El Varal;Los Gómez;Peñas Altas;Cerro de la Virgen (San Juan de Bocas);El Ancón;El Celebro;Las Pozas;San José de los Cenizos;Tepozán;Bocas (Estación Bocas);San Antonio;Ejido San Rafael;La Mesita;Los Rebajes;San José;San Rafael Uno (El Cañón);El Temporal;La Pedrera;Angostura;El Cascarón (La Mesita)', 'San Luis Potosí', 'San Luis Potosí'),
(78406, 'Los Ramos (Ejido San Juanico Grande);Tanque de Alemán;Campo Alegre;Julio Meza Hernández;Estación Pinto;La Villita;Tanque de la Cruz;Cuatro Vientos (Buenos Aires);Lamparito;El Refugio;Peñasco;Tanquecito de Mendoza;Charco Blanco;Lechuguillas;Palma de la Cruz;Tanque el Mezquite;Los Cajones;El Rebaje;Luisa López Puente', 'San Luis Potosí', 'San Luis Potosí'),
(78407, 'San Rafael Número Dos;Rancho San Antonio;La Casa Orillera (Pozo Cinco);Rancho San Francisco;González;Pozo Dos;Llanitos Verdes;Pozo Cinco;Pozo Cuatro Blanco de Bocas;Pozo Dos Ramitos Verdes;Los Verdes;Palmar de las Flores (El Pozo Seis);Rancho Milán (San Carlos);La Manta;El Chaparral;Los Pinos [Lubricantes y Servicios];Rancho el Gallo (San Carlos);Terroncitos (Los Contreras);Terrones (Sangre de Cristo);San Isidro (Ejido de González)', 'San Luis Potosí', 'San Luis Potosí'),
(78410, 'Los Rodríguez;El Arbolito;El Pozo la Lagunita;El Retiro;Pozo Terrero;Tanque Blanco;Tanque de Palmas;Terrero y Anexas;Las Manguitas;Terrero Norte;Yerbabuena;Los Urbanos;La Mantequilla;El Coro (Fracción la Mantequilla);Mano Blanca;La Loma;La Presita de las Águilas;Lagunita del Berrendo (Los Desmontes);Palmeras;Rancho Arriba;Los Muñiz', 'San Luis Potosí', 'San Luis Potosí'),
(78413, 'Colonia Insurgentes;El Charquillo (Capulines);La Casa Colorada;Colonia los Salazares (Las Pulcatras);Salazares;Capulines;San José de Buenavista;Rancho la Ilusión (Cerro del Coloradito);Wenceslao', 'San Luis Potosí', 'San Luis Potosí'),
(78414, 'Eulalio Cortinas;Ismael García;Mariano García Tovar;Pedro Pérez (Ejido Maravillas);Rancho la Herradura;San Juanico Chico;San Juanico el Grande;El Garambullal (Camino Hondo);Los García;Rancho los Olivos;Tanque el Huizache;Tomás Hernández (Ejido de Maravillas);Gerardo Coronado (Ejido Maravillas);Pozo Número Uno (Ejido Maravillas);Fracción la Angostura Norte;Modelo [Gasera];Rubén García Pérez;Agustín Chávez Ramírez;Colonia la Estrella;Fracción Milpillas;Ignacio Vázquez (Ejido Maravillas);Torres de Maravillas;Leopoldo Llanas Ortiz;Rinconada;Jesús Socorro Camacho (Ejido Maravillas);María Justa Pérez Barbosa (Ejido Maravillas);Ruperto Muñoz Hernández;Colonia la Unión;Colonia de Comité Movimiento Amplio Popular;Fracción los Graneros;Los Vargas;Nieves García Santillán;Porfirio Muñoz;Tanque Uresti', 'San Luis Potosí', 'San Luis Potosí'),
(78415, 'El Minguinero;Josefina Arias (Ejido Milpillas);San Luis Potosí (Ponciano Arriaga);Jorge Ramos;Rancho de Fermín;El Hacha', 'San Luis Potosí', 'San Luis Potosí'),
(78416, 'La Amapola;San Sebastián', 'San Luis Potosí', 'San Luis Potosí'),
(78418, 'Mesa de los Conejos;El Potosí [Centro Deportivo];Pozuelos;Casa Blanca;Revolución;El Peaje [Centro Acuícola];Escalerillas;Las Pilitas', 'San Luis Potosí', 'San Luis Potosí'),
(78419, 'La Cruz', 'San Luis Potosí', 'San Luis Potosí'),
(78420, 'Barrio Casanova;Nogalia;Rancho Casanova;Rancho de la Palma Gacha;El Real;Francisco Morales Aranda;La Pasadita;Maico (Guillermo Ortega);San Nicolás de los Jassos;Bosques la Florida;Las Granjas;El Jagüey;El Pozo de Santa Rita (El Zacatón);José Vargas;Rancho el Olvido;Ojo de Agua;La Marcela;Potosino [Club];Rancho las Águilas;Rancho Tanque Tenorio;Arturo Medina (Rancho Seis Hermanos);Las Brechas;Rancho el Sacrificio;Rancho los Borregos', 'San Luis Potosí', 'San Luis Potosí'),
(78421, 'Villa de Pozos;Tanque El Jaguey;Laguna de Santa Rita;San Miguel de La Colina', 'San Luis Potosí', 'San Luis Potosí'),
(78423, 'José Inés Vargas;La Presilla;Los Blancos (Enrique Tapia);Panalillo;Rancho San Antonio (El Castañón);Rancho el Mineral (Rancho el Carmen);Ciudad Satélite;Emeterio Buendía;Santa Rosa;Miguel Barral Pontones;Rancho las Maravillas', 'San Luis Potosí', 'San Luis Potosí'),
(78424, 'Noria de San José;García;San Antonio;El Lindero (Santiago Gutiérrez Alvizu);Bosque de las Flores;El Guerrero;Francisco Ponce (La Noria);Rancho MG;Eusebio Rodríguez (La Noria)', 'San Luis Potosí', 'San Luis Potosí'),
(78425, 'La Pila;El Jaralito;El Banco;La Pila (Pascual Alvarado);Los Abuelos;Ninguno [Comedor 57];Olivia Martínez Mata;Cerritos la Pila;Lamberto Alvarado Gutiérrez;Moisés García Loredo;Rancho las Bombas', 'San Luis Potosí', 'San Luis Potosí'),
(78426, 'El Ranchito;Arroyos;Joyas del Aguaje;El Terrero Sur;Emiliano Zapata;La Pila;La Libertad;El Peñón;Rancho la Gloria Escondida;Jarillas de Gómez;Fracción el Aguaje;La Pila (Ángel Ligas);El Zapote (San Juan de Guadalupe);La Cantera', 'San Luis Potosí', 'San Luis Potosí'),
(78427, 'Cañada del Lobo;Ninguno [Campamento CONAGUA];Tierra Blanca Uno;El Maguey Blanco', 'San Luis Potosí', 'San Luis Potosí'),
(78430, 'San Gerardo;Los Olivos;Villas de Soledad;Las Flores;Soledad de Graciano Sanchez Centro;María Fernanda;Las Capillas;Escontria;El Zapote;Francisco Villa;La Rivera;San Juanita;Textil;Rinconada de las Flores;Las Canteras;Las Huertas;Privada Nuestra Señora de La Soledad;Luis Donaldo Colosio;Priv. Centenario;Villas del Sol;Ma. Laura;Puerta Real;Expropiación Petrolera;Los Ángeles;Pipila;Las Higueras;Los Pirules;Residencial Las Flores;Rancho Nuevo;Arboledas de Soledad;16 de Septiembre;Residencial Los Laureles;Buenaventura;Fracción Rivera', 'Soledad de Graciano Sánchez', 'San Luis Potosí'),
(78432, 'El Laurel;El Márquez;Bosques del Márquez', 'Soledad de Graciano Sánchez', 'San Luis Potosí'),
(78433, 'La Constancia;Las Arboledas;San Felipe;San José Bellavista;San José II;Valle de Bellavista;Las Américas;Cerrada de Milán;La Misión;Privada San Lorenzo;Santo Tomás;Hacienda del Barranco;Priv. Fresnos;Cda. San Marino;Potrero de Adentro;San José;La Cofradía;Privada de Los Pinos;Urbana Morelos;Los Fresnos;La Raza;Santa Lucía;Villas de San Lorenzo;Privada San Jorge;Vizcaya;Urbana Arboledas 2a. Sección;Cerrada de Roma;Morelos;Piquito de Oro;Lomas de San Felipe;Valle de Santiago;Valle del Ecuestre;Las Hadas;Santa Teresa;Covadonga;Residencial Santiago', 'Soledad de Graciano Sánchez', 'San Luis Potosí'),
(78434, 'Providencia;La Flama;Hogares Populares Pavón;San Andrés;Magdalena;Escobillal;La Lomita;Hacienda las Margaritas;El Barranco;Niños Héroes;Residencial Pavón;Jardín Chapultepec;Priv. Iturbide;La Lomita 3ra Sección;Privada Chapultepec;Arcos de San Pedro;Villa Fontana;Rancho Pavón INFONAVIT;Pavón II;Villas de San Pedro;Real Providencia;Cerrada Del Real;Central;San Francisco;La Loma;Privada San Pedro;Urbana Central de Maquinaria;Pavon 3a Sección;La Lomita 2da Sección;Cerrada de las Huertas;El Morro;San Pedro INFONAVIT;Valle del Rocio;La Virgen;Hacienda San Miguel;Villas del Morro;Rinconada de San Pedro;Los Agaves;Conjunto las Aves;La Huerta;Rinconada Chapultepec', 'Soledad de Graciano Sánchez', 'San Luis Potosí'),
(78435, 'Las Palmas;San Antonio INFONAVIT;Quintas de Don Roberto;Valle de San Isidro;Los Puentes;Bosques de San Francisco;Cerrada del Bosque;San Francisco;La Hormiga', 'Soledad de Graciano Sánchez', 'San Luis Potosí'),
(78436, 'Azaleas;Gral. Genovevo Rivas Guillen;Puente Real;Hogares Ferrocarrileros 3a Secc;Real del Bosque;Villas de San Francisco;Fidel Velázquez;Praderas del Maurel;Bugambilias;Las Canteras;Los Álamos;Gral. Genovevo Rivas G 2a Sección;Nuevo Testamento;Rancho Blanco;El Polvorín;Villas Glorieta;Gral. Genovevo Rivas G 3a Sección;Misión de San Pedro;Quintas Soledad;Hogares Ferrocarrileros 1a Secc;San Antonio;Hogares Ferrocarrileros 2a Secc;5o Plano de la Genovevo Rivas Guillén;San Francisco de Asís Norte', 'Soledad de Graciano Sánchez', 'San Luis Potosí'),
(78437, 'Benito Juárez;Rural W;Nueva Reforma;Francisco Sarabia;Jardines del Valle;Unidad Ponciano Arriaga 2a Secc;21 de Marzo;Hermenegildo J Aldana;Unidad Ponciano Arriaga;Santa Mónica;Graciano Sanchez;San Francisco de Asís;El Lavadero;Nuevo Foresta;Villas del Potosí;Reforma;Unidad Militar Foresta;El Laurel;Jardines de Oriente', 'Soledad de Graciano Sánchez', 'San Luis Potosí'),
(78438, 'Colinas del Bosque;Villas de Foresta;Quintas de La Hacienda 3a Secc;Del Bosque;Emiliano Zapata;Privada Hacienda La Estancia;Privada Hacienda San Mateo;Los Hornos;Foresta;La Sierra;Bosques de Oriente 1a Secc;Conjunto del Real;Hacienda de las Cruces;Villas del Cactus;Prados de Soledad;Quintas de La Hacienda 2;Villas del Sol;Bosque Real;Primero de Mayo 2a. Sección;Privada Hacienda de San Agustín;Rinconada del Palmar;Valle del Altiplano 2a. Secc.;Rinconada de Los Hornos;Arboledas II;El Tanquesito;Real de San Pedro II;Roberto Cervantes;Privada San Sebastián;Rancho La Libertad;Valle del Cactus;Valle del Altiplano;Valle del Huizache;Quintas de La Hacienda;Hacienda de los Morales;Valle de Las Dunas;Derechos Humanos;Privada Hacienda Guadalupe;Rancho Blanco;Los Gómez;San Rafael;Villa Alborada;Arboledas de Oriente;Real de San Pedro;Villa Jardín;Jardines del Sol;Privada Hacienda Cocoyoc;San Rafael;Valle de Garambullos;Hogares Obreros;Los Cactus;Rinconada B Anaya;Rinconada de Cactus;Valle del Maguey;Primero de Mayo;San Luis 1;Privadas de las Haciendas;Puerta del Sol;Hacienda del Potrero;Privada Hacienda San Gabriel;La Libertad;Bosques de Oriente 2a Secc;Privada de La Libertad;Privada Santa Fe;Sierra Bonita;Valle del Agave;Privada Quinta El Márquez;Santa Cruz', 'Soledad de Graciano Sánchez', 'San Luis Potosí'),
(78439, 'La Purísima (Fracción la Purísima);Agustina Castro;Contreras Rojas;El Dorado;Ex-Hacienda Escondida de Santa Ana;Jesús Medina Silva;Juan Tenorio Ramírez;Juana López Orozco;Las Capillas;Los Noyola;Pozo de Luna Dos (La Portada);Rancho el Refugio (Luciano Gaytán);Rancho San Andrés (El Ranchito);Rancho San Pedro;San Gerardo;San Rafael;Santo Tomás;Ximonco [Empacadora de Carnes];Enrique Estrada (La Concha);La Tinaja (Ex-Hacienda la Tinaja);Barbechos de Guadalupe;Del Potosí [Centro Recreativo y Social];Ejido Soledad;Ejido Soledad (Severiano Tristán Saldaña);El Arenal;El Ocho;El Ramillete (Parcela el Ramillete);El Vivero (Ejido Margaritas);Fraccionamiento Ejido de Palma;Fraccionamiento Hacienda de Santo Tomás;Francisca Herrera Rocha;Higinio Oviedo Cuadros;Irineo Gallardo;Javier Escalante;José Carmen Hernández Moncada;Minas de San Pedro;Morales Martínez;Rancho DAHRS;Rancho los Muchachos;Rancho Santa Ana;San Bartolo;Triturados Pétreos de San Luis [Trituradora];Zamora;Albino Pérez;Cayetano Loredo Tenorio;División del Norte Primera Sección;El Olvido;Francisco de Alba (Rancho San José);Juana Uresti;La Cruz del Siglo;La Victoria;Lourdes Zamarrón;Rancho Cordelia;Rancho Hermanos Galarza;San Vicente;Santa Rosa;Sebastián Gaytán Moreno;Palma de La Cruz;Antonio Vázquez Cuevas (Rancho los Noyola);AUMA [Granja Avícola];Ejido de Rinconada (Benito Buendía Álvarez);El Garitón (Ramón Miranda);El Nono;Eulogio Rincón;Fraccionamiento Santo Tomás 2;Granja el Nogal;Hacienda de Pozo de Luna;Higinio Torres Hernández;Juan Acosta Sierra (Ejido Soledad);La Jaloma (La Esperanza) [Sociedad Agrícola];La Zorra;Los Adobes;Rancho las Cuatas (Santa Fe);Rancho las Lomas;Rancho los Buendía;Rancho los Chetes;Rancho Martínez;El Huizache;Ejido los Gómez;Antonio Castro Tristán;Ejido el Zapote;Ejido el Zapote (Los Olivos);El Garambullal Dos;Granja Antonio;Granja los Ángeles [Club de Golf];Huerta Velázquez;Joel Corpus Gaytán;Julián Loredo Guerrero (El Vapor);La Cardona (Barbechos);Leovigildo Tello;Los Vázquez;Rancho Don Carmen;Rancho Juárez;Rancho Loredo;San Agustín (El Ranchito);San José;San Martín;Santana de Flores;Antonio Aguiñaga Piñón;Bernardino Juárez;División del Norte Segunda Sección;El Diamante (El Tízar);El Paraíso;El Veintiocho (Crucero la Tinaja);Eustacio Sierra Granja;Evaristo Velázquez;Granja José Luis Velázquez;Huerta la Victoria;La Cruz;La Esmeralda;La Noria;Luis Gallardo;Monte Granado;Parcela Don Federico;Rancho Mendoza;Zamorita;General Cándido Navarro (Laguna Seca);Estación Techa;San José del Barro;Juana Cordero Armendárez;La Soledad;Las Margaritas;Parcela Ejidal María Santos;Ranchito (Jesús Arias);Rancho de Gerardo Gallego;Rancho de la Gringa;Rancho la Crucita;Rancho la Ilusión;Rancho los Mendoza;Rancho Palomo;Rivera Asociados [Granja Avícola];Ximonco [Granja Porcina];Zona de Riego Valle de San Francisco;El Mezquite;Estación Ventura;El Jaralito;Enrique Ochoa;Huerta de los Coreño;Huerta la Palapa;La Cuenca [Sociedad Agrícola];Paula Castillo Castillo;Rancho el Sacrificio;Rancho la Esperanza;Rancho la Esperanza (Filiberto Briseño);Rancho Rodríguez;San José (El Tízar);Tanque el Aguaje', 'Soledad de Graciano Sánchez', 'San Luis Potosí'),
(78440, 'Cerro de San Pedro', 'Cerro de San Pedro', 'San Luis Potosí'),
(78443, 'Jesús María', 'Cerro de San Pedro', 'San Luis Potosí'),
(78444, 'Monte Caldera', 'Cerro de San Pedro', 'San Luis Potosí'),
(78445, 'Cuesta de Campa', 'Cerro de San Pedro', 'San Luis Potosí'),
(78446, 'El Tecolote;Divisadero;Calderón', 'Cerro de San Pedro', 'San Luis Potosí'),
(78447, 'La Zapatilla;La Sabanilla (Portezuelo);Joyita de La Cruz;Portezuelo', 'Cerro de San Pedro', 'San Luis Potosí'),
(78448, 'Campestre Real del Potosí;Planta del Carmen (El Ocho);Los Gómez Lado Oriente;Granjas de San Francisco;Granjas de San Pedro;Granjas de la Florida', 'Cerro de San Pedro', 'San Luis Potosí'),
(78450, 'Ahualulco del Sonido 13;Los Magueyes;Julián Carrillo;Lomas de la Soledad', 'Ahualulco', 'San Luis Potosí'),
(78453, 'San Francisco de los Chávez (Potrerillos);Arroyo Blanco;El Novillo;La Trinidad;El Pastillo;Los Cerritos;El Soldadillo;San José;San Juan de la Hija;El Tepozán;Potrerillos;Potrero Agua Bendita;Casita Blanca;El Saucito;Loma del Becerro;Tomates;El Epazote;La Palma;El Tulillo;El Tulillo (San Nicolás);Paredes', 'Ahualulco', 'San Luis Potosí'),
(78454, 'Estación Ipiña;El Aguaje;La Pila;Las Puertas;Los Llanitos;Majada Alta;Nopales Altos;Las Pilas;Cieneguita (Cieneguilla);El Mezquite;La Cañada de la Cruz;Francisco Guevara Sifuentes;Ojo de Agua del Llano;Puerto de Duques;La Encarnación;Rancho Alegre;La Candelaria;Milpillas;El Paso de la Aguja;Las Enramadas', 'Ahualulco', 'San Luis Potosí'),
(78455, 'San Antonio Ojo de Agua;Tanque el Puerto;El Salitre;San Salvador;El Zapote (Cerrito Blanco);Los Árboles (Colonia de la Cruz);Colonia de la Cruz;El Salto;La Soledad;Tierra Prieta;Ejido del Centro;Tanque Cañón del Puerto;La Tinaja;Rincón de Yerbabuena;Cañada Grande (El Bosque);Cañón de Yerbabuena;Cañada Grande;Yerbabuena', 'Ahualulco', 'San Luis Potosí'),
(78456, 'Cochinillas;La Higuera;Puente Mina Blanca;Coyotillos;Estancia del Arenal (Arenal Viejo);Las Taponas;Cerrito de Rojas;El Temascal;Santa Teresa;Santa Petronilas;San Juan (San Juan de Coyotillos);Arenal de Morelos;El Zapatero;Pedregal;La Mesa', 'Ahualulco', 'San Luis Potosí'),
(78457, 'Rancho de la Cruz;El Garabatillal;El Pachoncito;El Rosal;Cerro Blanco;El Durazno;Paso Bonito;La Parada;San Ignacio;Clavellinas;La Crucita;Rancho Viejo;Barrancas;La Mezclita;Las Mangas;Las Trancas;Mina Blanca', 'Ahualulco', 'San Luis Potosí'),
(78460, 'Colonia Emiliano Zapata (El Chamizal);Colonia Guadalupes;Tanque Grande (Las Mesas);Puerta de Tinajuela;Valle Umbroso;Las Mangas Dos;La Jacoba;Tanque las Tortugas;San Francisco (Lomas de San Francisco)', 'Mexquitic de Carmona', 'San Luis Potosí'),
(78463, 'La Cuenca;San Pedro Ojo Zarco;Puerto de Providencia;Colonia Progreso;Huizachillos;San Salvador;Ejido los Rodríguez (Potrero el Chaparral);Cañada Grande', 'Mexquitic de Carmona', 'San Luis Potosí'),
(78464, 'Los Rojas;Palmar Segundo;Los Pérez;Los Rodríguez;Salitrillo;Ejido de Moras;Lechuguillas;Tanque Grande;Buenavista;El Tepozán;La Cabra;Los Vanegas;Fracción Ojo de Pinto;Jacalillos;Los Vázquez;Los Uribe;Venadito', 'Mexquitic de Carmona', 'San Luis Potosí'),
(78465, 'Los Retes;Los Hernández;Agua Señora;Cerrito de Maravillas;El Rodeo;Maravillas;Matancillas;Monte Obscuro;Los Coronado;Las Moras;Los Moreno;Cerrito de Estanzuela;Colonia Primero de Enero;Estanzuela;La Colorada;Cerrito de Jaral', 'Mexquitic de Carmona', 'San Luis Potosí'),
(78466, 'Ojo de Agua;Morales y San Rafael;Los Órganos;El Palmar Primero;Derramaderos;Comunidad Corte Primero;Comunidad de Corte Segundo;El Carrillo', 'Mexquitic de Carmona', 'San Luis Potosí'),
(78467, 'Colonia Molino del Carmen;Orilla del Río;El Bravo;Benito Juárez;San Rafael;Rincón del Porvenir;Lagunillas;Estación Justino;El Carrizal', 'Mexquitic de Carmona', 'San Luis Potosí'),
(78470, 'Paisanos;El Jaralito;La Cruz;Milpillas;Suspiro Picacho;Los López;La Loma;Cruces y Carmona;Paso Blanco;La Campana', 'Mexquitic de Carmona', 'San Luis Potosí'),
(78473, 'El Arbolito;Ranchería de Guadalupe;Juan Manuel;Salitrillo;Contreras;Agua Prieta;El Entronque;El Cerrito;Ejido Milpillas;La Cueva;Los Jiménez;Rincón de San José;Román Hernández Jacobo;Cenicera', 'Mexquitic de Carmona', 'San Luis Potosí'),
(78474, 'Cañaditas;Cañón de Ojo Zarco;Los Puertecitos;Colonia Álvaro Obregón;La Presita;San Agustin;El Olmo;Fracción Salitrera;Jarillas;Ojo Zarco de Arista;Temaxcalillo;La Matanza', 'Mexquitic de Carmona', 'San Luis Potosí'),
(78475, 'Ejido Miguel Hidalgo;Cerro Prieto;Tanque la Pintada;Morelos;La Loma de la Cruz', 'Mexquitic de Carmona', 'San Luis Potosí'),
(78476, 'Barbecho;Rivera;Ignacio Allende;Pollitos;La Tapona;Estancita', 'Mexquitic de Carmona', 'San Luis Potosí'),
(78477, 'Guadalupe Victoria;Iglesia del Desierto', 'Mexquitic de Carmona', 'San Luis Potosí'),
(78480, 'Mexquitic Centro', 'Mexquitic de Carmona', 'San Luis Potosí'),
(78483, 'El Llanito;Lomas del Pedregal', 'Mexquitic de Carmona', 'San Luis Potosí'),
(78484, 'Bellavista', 'Mexquitic de Carmona', 'San Luis Potosí'),
(78485, 'Revolución', 'Mexquitic de Carmona', 'San Luis Potosí'),
(78486, 'La Paya', 'Mexquitic de Carmona', 'San Luis Potosí'),
(78487, 'San Marcos Carmona', 'Mexquitic de Carmona', 'San Luis Potosí'),
(78490, 'Ayun;El Montecillo;Clara Cordova;Villa de Arriaga Centro;San Miguelito', 'Villa de Arriaga', 'San Luis Potosí'),
(78493, 'El Charquito;El Con de San Bernardo;El Saucito;Estanque el Colorado;Jaramas;Los Alamitos (El Chacual);San José;San Juan de Guadalupe;El Saucito (San Isidro);Providencia de los Hernández;San Bartolo;San Isidro (San Camilo);San Isidro de los Duarte;Franco;La Paila (Maravillas);Pablo Martínez;Rancho el Carmen;Rancho Guadalupe;San Agustín;San Antonio de los Méndez;San Isidro;La Manga;La Mocha;La Soledad;San Ignacio;San José;San Rafael de los Martínez;San Luis Gonzaga;Santa Rosa de Gallinas;Conitos;Santa Clara de los Bordos;El Zorrillo;José Valadez;La Purísima;Llano de la Purísima;Merced López;San Francisco (San Francisco de los Rentería);San José de Gracia;San Juan de las Cuadras;San Rafael (Los Duarte);Tanque Nuevo (Rancho Seco);El Trompillo;Cono San Carlos;La Virgen;Las Cuadras;San Antonio de los López;San Jerónimo;San Juan de Guadalupe;San Pedro;San Rafael de la Laguna;Santa Rita;El Águila;El Con;La Bastilla;La Soledad (Andrés Cano Rentería);Refugio de los Campos (La Soledad)', 'Villa de Arriaga', 'San Luis Potosí'),
(78494, 'La Chancla;Los Joyancos;Puerta de las Chivas (El Palmar);Colonia los Manueles;El Patol;La Lugarda;Tanque de San Juan;La Cieneguita;El Refugio del Jardín;Ex-Hacienda de Santiago;La Luz (Los Gutiérrez);Santa Lucía;El Pastor;Colonia la Laborcilla;El Patolito;Colonia Palomas;El Jardín de los Cuéllar (Puerta el Jardín);Los Conos', 'Villa de Arriaga', 'San Luis Potosí'),
(78495, 'San José de La Purísima;El Mezquital;Anacleto Betancourt;El Nivel;Las Norias Anexo el Mezquital (Las Mangas);Rancho el Milagro;San Miguelito;San Antonio;Saucillo;Ojo de Agua de Juan Pérez;Puerto Espino;El Tepetate;Colonia Guadalupe Victoria (Fátima);Saucillo (La Joya);Francisco I. Madero;Florencio Ruiz', 'Villa de Arriaga', 'San Luis Potosí'),
(78496, 'San Francisco;El Carmen;La Puerta del Terrero;Emiliano Zapata;Rancho Santa Teresa;El Jacalón;Jardín de los Matas;La Boda;La Candelaria;San Benito;El Jardín;La Troje', 'Villa de Arriaga', 'San Luis Potosí'),
(78497, 'Agua Gorda de los Patos;Arcadio Juárez;El Cuervo;El Pirulito;Juan Ordaz;Las Rebuscas;San Elías;Anexo al Tepetatillo;Juan Ramón Almendárez Galván;La Manga;La Troje;El Cuartillo;Fraccionamiento el Rosario;La Loma;Los Pelones;El Saucito;El Tepetatillo;Ex-Hacienda San José del Maguey;San Juan;San Pablo;Colonia la Luz;El Garambullo;La Cruz (Armando Campos);Santa Ana (Los Cones);Arnulfo Vázquez Camarillo;San Antonio Puerta del Refugio;San Elías;San Elías;Melchor;San Isidro (San José de Fátima);San José de Fátima;La Laguna Verde;La Puerta del Refugio;La Puerta del Rosario;Providencia', 'Villa de Arriaga', 'San Luis Potosí'),
(78498, 'Santiago', 'Villa de Arriaga', 'San Luis Potosí'),
(78500, 'San José de La Punta;Vanegas', 'Vanegas', 'San Luis Potosí'),
(78502, 'Presa de Santana', 'Vanegas', 'San Luis Potosí'),
(78503, 'Zaragoza;Huertecillas', 'Vanegas', 'San Luis Potosí'),
(78508, 'San Juan de Vanegas;Vanegas de Abajo', 'Vanegas', 'San Luis Potosí'),
(78510, 'El Salado', 'Vanegas', 'San Luis Potosí'),
(78511, 'El Tepetate', 'Vanegas', 'San Luis Potosí'),
(78512, 'El Gallo;San Vicente', 'Vanegas', 'San Luis Potosí'),
(78513, 'Tanque de López', 'Vanegas', 'San Luis Potosí'),
(78514, 'Noria de Jesús;El Salto Colorado;San Juan de La Cruz', 'Vanegas', 'San Luis Potosí'),
(78520, 'Valle Verde;Valle Verde 3ra. Sección;Cedral Centro;La Luz', 'Cedral', 'San Luis Potosí'),
(78523, 'Progresistas;Santa Fe;del Valle;Villa de Los Sillares', 'Cedral', 'San Luis Potosí'),
(78524, 'La Unión;Escritores;El Dólar', 'Cedral', 'San Luis Potosí'),
(78525, 'Los Cedros;Del Bosque;Lázaro Cárdenas;Josefa Ortíz de Dominguez;Antorchista;Villa Las Palmas;Emiliano Zapata', 'Cedral', 'San Luis Potosí'),
(78526, 'Domingo Soto;San Antonio', 'Cedral', 'San Luis Potosí'),
(78527, 'Fco I Madero;Antigua Guayulera;Progreso;La Victoria', 'Cedral', 'San Luis Potosí'),
(78530, 'Francisco Gloria;Rancho San Isidro;La Concordia (Lorenzo Guerrero);Nueva Rosita;Rancho la Joya;San José del Ramillete;San Isidro;La Candelaria;Rancho Paso del Norte;Noria de San Pedro;Buenavista;El Jobián;Rancho Maricar;Rancho San Martín;Rancho Santa Martha;San Francisco;Santa Isabel;Rancho San Ángel;San José de la Porra;El Consuelo;El Llano;Rancho Santa Rosa;Santa Fe;Noria de Dolores;Rancho las Vegas;San Ignacio del Carmen', 'Cedral', 'San Luis Potosí'),
(78533, 'Gallos Blancos;Presa Verde;Ejido Hidalgo', 'Cedral', 'San Luis Potosí'),
(78534, 'San Mateo;La Joya de Elías;San Antonio del Sotol;El Llano del Pinto;Mesa de los Molina;Palo Blanco;Casa Ejidal Santa Rita del Sotol;El Mirador', 'Cedral', 'San Luis Potosí'),
(78535, 'Casa Blanca (Majada Ejido Zamarripa);La Joya;La Pinta;Tanque Nuevo;San Lorenzo;Zamarripa;Santa Rita de Sotol;Santa Catarina;La Joyita;La Candelaria;Rancho Nuevo', 'Cedral', 'San Luis Potosí'),
(78536, 'La Rinconada;Loma Linda;Refugio de Saladito;Saltillito;San Rafael;La Crucita;Lagunillas;San Rafael de los Facundos;Cerro de Flores;Ejido Victoria San Manuel;Perpetuo Socorro;La Esperanza;Héctor Ávila;Progreso;Rancho San Benito;La Boquilla;La Estancia;Los Orozco;San Antonio de los Montoya;El Saladito;El Espíritu;Salitrillos del Refugio;El Saucito;Rancho San Francisco;San Pablo;Rancho Viejo;Jesús María;El Cuarejo', 'Cedral', 'San Luis Potosí'),
(78537, 'La Perla (Nogalar);Rancho la Rinconada;El Carmen;El Sauz;La Cruz;Santa Teresa;El Pequeño;Rancho Santo Domingo;Entronque del Real;El Blanco;Fraccionamiento Llanos de San Gabriel;Rancho el Cono del Progreso;Rancho Vallarta;Refugio de las Monjas', 'Cedral', 'San Luis Potosí'),
(78540, 'Santa María del Refugio;Los Azules;Charco Largo;Castañón;Los Pames', 'Catorce', 'San Luis Potosí'),
(78543, 'La Borrega;Rancho Nuevo;El Tecolote;Las Amapolas', 'Catorce', 'San Luis Potosí'),
(78544, 'La Mesa;San Francisco del Refugio;Cerrito de la Piedra;El Rayito;Valle Verde;Los Negritos;La Cardoncita;Tanque de Arenas', 'Catorce', 'San Luis Potosí'),
(78545, 'Tanque de Dolores;Las Cabecitas;Tanque Charco Cercado;El Duraznillo', 'Catorce', 'San Luis Potosí'),
(78546, 'Lavaderos;Ejido las Lechuzas [COPLAMAR];El Refugio de Coronados;Perros Duros;Loma Blanca;San Rafael de Torres;El Pozo Viejo;Estación Wadley;Estación Catorce', 'Catorce', 'San Luis Potosí'),
(78547, 'Cerrito Blanco;Las Margaritas;Boquilla de Barrabás', 'Catorce', 'San Luis Potosí'),
(78550, 'Real de Catorce', 'Catorce', 'San Luis Potosí'),
(78553, 'Camposanto', 'Catorce', 'San Luis Potosí'),
(78554, 'Guadalupe', 'Catorce', 'San Luis Potosí'),
(78555, 'Purisíma(Coyotera)', 'Catorce', 'San Luis Potosí'),
(78560, 'El Salto;San Cristóbal;Los Cuatro Caminos;La Palma;La Pila;Los Catorce;Ojo de Agua;Agua Blanca;Desmontes de Catorce (Los Tahonitas);Las Auras;Refugio de los Amayas;Poblazón;Viborillas;La Cañada;San José de los Quintos;San José de Milpitas', 'Catorce', 'San Luis Potosí'),
(78563, 'San Antonio de la Cruz;Ave María;Mina de Concepción;El Potrero;El Espolón;Potrerillos;Tahonitas del Salto;El Refugio (La Luz)', 'Catorce', 'San Luis Potosí'),
(78564, 'El Mastranto;El Garabato;San Juan de Matanzas;Alamitos de los Diaz;La Leona;Santa Cruz de Carretas;Las Relaciones;Las Adjuntas;El Barranco', 'Catorce', 'San Luis Potosí'),
(78565, 'San José de Coronados;San Antonio de Coronados;Guadalupe del Carnicero (La Maroma);Vigas de Coronado;Jesús de Coronados;Ranchito de Coronados', 'Catorce', 'San Luis Potosí'),
(78566, 'Alamaritos de Coronados;Becerras;Los Ojitos de Agua;Los Rayos;Bedao;El Jordán;El Oreganal;El Pastor de Coronados;La Lagunita (Maguey Mocho);Real de Maroma;El Puerto de San Jacobo;Los Huíngaros;Tahonas del Jordán;La Alberca;La Cieneguita de Sosa;Las Adjuntas;El Magueyal;El Vergel;La Milpita;Tierras Negras;Mesa del Venado', 'Catorce', 'San Luis Potosí'),
(78567, 'La Cantera;El Huizachal;Las Sevillas;Santa Cruz del Mogote', 'Catorce', 'San Luis Potosí'),
(78570, 'Cañada Verde;Emiliano Zapata (Las Canteras);Ejido Juárez Dos;Fernando López Bustos;Los Corrales;Porfirio Montelongo González;San Francisco de los Ejidos;La Clarinera (Antonio Aldape);Paulino Cabrero (Los Ejidos);Pedro Aguilar;Ceferino Sánchez Ontiveros;Huerta la Providencia (Rancho Dallemese);Las Isabeles;Francisco González;La Joyita (Los Corrales);Ojito Santa Cruz;Leocadio Berino;Rebombeo del Cerrito de Tunas', 'Charcas', 'San Luis Potosí'),
(78573, 'Mina Tiro General;Los López;Jorge Castañeda;Congregación de Dolores (Las Quince Letras);El Rincón (Timoteo Pérez);La Zapatilla;Las Tinajitas;Los Jaboncillos;Rincón Verde;San Onofre;Los Gavilanes;Ejido Juárez;La Medalla', 'Charcas', 'San Luis Potosí'),
(78574, 'San Francisco de los Álamos;Charco Prieto;Las Ánimas;Efraín González Galván;El Reventón;Gregorio Hernández;Noria de Guadalupito;El Saucito;Pocitos;Puerta la Verdolaga', 'Charcas', 'San Luis Potosí'),
(78575, 'San Francisco;Elorza;Fátima;La Tinaja;San José;Tanque de Don Santiago;Rancho los Álamos;Guadalupito;Ignacio Aldama;La Embargada', 'Charcas', 'San Luis Potosí'),
(78576, 'El Clérigo;Cerro Prieto;Los Callejones;Laborcilla;Ojo de Agua;San Julián Santa María;Tanque de Santa Ana;Álvaro Obregón (Estación los Charcos);Santa Ana de Zaragoza;Rancho el Rodeo;Rancho el Caño;El Rastrero (La Noria);Juan Hernández', 'Charcas', 'San Luis Potosí'),
(78577, 'Chupaderos;Agapito Mendoza;El Orito;Gualupe;Noria Pinta;El Sauz;El Tepozán;La Negrita;Maravillas;Pame (El Llano);Noria de Gutiérrez (José María Morelos);El Lucero;El Membrillo;Morelos;Nopales Altos;El Capulín;El Perdido;Fracción Palmas (Palmas);Los Desmontes;Majada las Tordillas;San Diego;Buenavista;El Terrero (Ejido Charcas);Fracción el Capulín;Garabatillo;Puerto del Lechuguillero;Rincón Blanco;San Rafael;Guapilillas;La Trinidad;Labor de la Cruz;Pro Año;Puerto Colorado;Rancho Alegre;El Pame;La Laguna de los Caballos;La Sancheña;Las Vivianas;Tunalillo;San Antonio de las Huertas;El Águila;La Estancia;Puerto de Ramos;San José', 'Charcas', 'San Luis Potosí'),
(78578, 'El Cedazo;Salitrillos;La Lomita;La Presita;San Antonio;San Martín;El Bajío;Majadita Blanca;San Juan del Tuzal;El Rayo', 'Charcas', 'San Luis Potosí'),
(78580, 'El Zacatonal;Genaro Bustos Ramírez;La Barranca;Paso del Mezquite (Cerro Blanco);Calabacillas;Nabor Moreno;Tinajuelas;Charco Verde;Santa Cruz;Cerro Prieto;La Esperanza;San Felipe', 'Charcas', 'San Luis Potosí'),
(78583, 'Buenavista;Cañón de Lajas;Hermelinda Moreno Sánchez;Los Aguilares;Salinillas;Vicente Guerrero (Las Escobas);Lo de Acosta;Cerro Gordo;Los San Pedros;Clavellina;El Malpaso;El Tucanazo;Elidio Lázaro Esquivel;Isidro Cázares Rodríguez;San Elías;San Francisco de Asís del Campo Real;San José de la Cruz;La Quinta (La Hacienda);Liborio Rodríguez Gasca;San Antonio de Puente;El Saucito;Noria del Cerro Gordo;Antonio Vázquez;Joaquín Cansino;Santa Fe (Las Curras)', 'Charcas', 'San Luis Potosí'),
(78584, 'Miguel Hidalgo;Francisco I. Madero;Aquiles Serdán;Estación Berrendo;El Astillero;El Entronque;Estación Laguna Seca;La Cueva de la Nicha;San Joaquín', 'Charcas', 'San Luis Potosí'),
(78585, 'Abundio Moreno;Coyotillos San Pablo;Los Álamos;El Hospital;Cerrito de Piedras;El Refugio;Fabián Bernal;Francisco Bustos;Potrero Lo de Acosta (Mala Noche);Lajas;Las Atravesadas;Rincón del Muerto;El Arenal;El Frailesco;El Macareno;Coyotillos;Juan Bernal;Ricardo Bernal;Sacramento Arellano;Majadas Viejas;Las Palomas;Lo de Acosta (La Pulga);Majada de Chon;Tanque San Bartolo;Cerro Blanco;Coyotillillos;Francisco Bernal;Vidal Moreno', 'Charcas', 'San Luis Potosí'),
(78586, 'Juan Ramírez;Las Minas Coloradas;Prisciliano Rodríguez;El Rosario;El Estañero (Cleto Ramírez);El Divisadero;Mesa Verganza (Chiquihuitillo);Mesa Redonda;Mesa Verganza', 'Charcas', 'San Luis Potosí'),
(78587, 'Cerro San Agustín;El Venadito;Rancho Guadalupe;Guadalupe Victoria;La Leona;Las Minitas;El Mosco;El Pedernal;Purísima Concepción;Arroyo el Borrego;Cerro de Magdalenas;El Diamante;El Soyate;El Venadero;La Lajilla;La Vieja;El Pedernal (Fermín Hernández Cardona);El Tanque (Ramón Vázquez);La Barranca;Loma del Mosco;Mesa del Julianito;San Antonio;Presa de Santa Gertrudis;Rancho Herradura el Tres', 'Charcas', 'San Luis Potosí'),
(78590, 'Charcas Centro', 'Charcas', 'San Luis Potosí'),
(78593, 'Charcas;Aviación', 'Charcas', 'San Luis Potosí'),
(78594, 'Siglo XXI;Cruz del Siglo', 'Charcas', 'San Luis Potosí'),
(78595, 'Estación;El Mezquite;Chipinque;El Caiman;Magisterial', 'Charcas', 'San Luis Potosí'),
(78596, 'Santa María;Potrerillos;La Peregrina', 'Charcas', 'San Luis Potosí'),
(78597, 'La Luz;INFONAVIT;IMMSA;Lomas de Santa María;La Esperanza;El Minero;El Mineral;Clavellina;El Grasero', 'Charcas', 'San Luis Potosí'),
(78600, 'Salitrillos;Juárez', 'Salinas', 'San Luis Potosí'),
(78601, 'Reforma;Triana', 'Salinas', 'San Luis Potosí'),
(78602, 'Punteros;Diego Martín;La Mesilla;Jacalón;Palma Pegada', 'Salinas', 'San Luis Potosí'),
(78603, 'Santa María', 'Salinas', 'San Luis Potosí'),
(78604, 'Azogueros;San Antonio de la Paz;El Potro', 'Salinas', 'San Luis Potosí'),
(78605, 'Noria de Cañas', 'Salinas', 'San Luis Potosí'),
(78609, 'El Alegre', 'Salinas', 'San Luis Potosí'),
(78610, 'San Isidro Peñón Blanco;Conejillo;Peñón Blanco', 'Salinas', 'San Luis Potosí'),
(78612, 'El Estribo', 'Salinas', 'San Luis Potosí'),
(78620, 'Salinas de Hidalgo Centro', 'Salinas', 'San Luis Potosí'),
(78622, 'Santa Cruz;Santa Cruz;San Agustin;Santo Niño;Palmar de los Sacerdotes;Satélite;La Paz;La Cruz;Santa Cruz', 'Salinas', 'San Luis Potosí'),
(78623, 'Santo Niño', 'Salinas', 'San Luis Potosí'),
(78624, 'La Huerta;San Isidro', 'Salinas', 'San Luis Potosí'),
(78625, 'La Curva;El Mirador;San Juan;La Gasolinera;La Joya', 'Salinas', 'San Luis Potosí'),
(78626, 'San Pablo', 'Salinas', 'San Luis Potosí'),
(78630, 'Santo Domingo', 'Santo Domingo', 'San Luis Potosí'),
(78633, 'Bajío del Ciriaco;El Taponcito;El Sabino;El Dorado;El Herradero (Adalberto Dávila Ortíz);El Ranchito (Francisco Flores);Santa Cecilia (Nicolás García);Juan Sarabia (Centro Ovino);La Sabanilla 3', 'Santo Domingo', 'San Luis Potosí'),
(78634, 'Nicolás Mata;Cerritos de Bernal;La Esperanza (Hermanos de la Torre);La Independencia (Ernesto Muñoz);Rita Frías Gutiérrez;El Tepetate;El Colorado (Luz Muñoz);Rancho San José (Los Cuatillos);Peña Tercera;Los Pachones', 'Santo Domingo', 'San Luis Potosí'),
(78635, 'José Dávila Castro (El Encino);Guanajuato;El Encino;San Antonio de los Garza;El Rosario;San Miguel;El Soyate (Loma del Soyate);San Francisco;El Carmen (El Papalote);La Tapona', 'Santo Domingo', 'San Luis Potosí'),
(78636, 'José Villanueva;La Victoria;El Bozal;La Calandria;La Merced;Las Huertas;Hacienda el Indio;Nueva Rosita;El Gavilán;Alfonso García;Antonio López', 'Santo Domingo', 'San Luis Potosí'),
(78637, 'El Matambo;La Yerbabuena;El Rodeo (Las Negritas);Las Vegas (San Agustín);El Castillo (El Salto de Contreras);El Relicario;Rodrigo Becerra', 'Santo Domingo', 'San Luis Potosí');
INSERT INTO `postcodes` (`id`, `place`, `city`, `entity`) VALUES
(78638, 'El Jardín;Socorro de Dios;El Sentón (Santiago Moreno);La Coyotera (Adalberto Dávila);Santa Efigenia;El Refugio;Loma Bonita;San Matías;Rancho Cinco Hermanos (La Tapona);Santa María del Mezquite;San Nicolás;Abundancia;La Esperanza;Congregación de Santo Domingo;La Flor;La Tinaja;Morelos', 'Santo Domingo', 'San Luis Potosí'),
(78639, 'Laguna la Cardona;La Rastrerita;San Martín (Jaime Esquivel Castro);La Botoncita;San Juan de Dios', 'Santo Domingo', 'San Luis Potosí'),
(78640, 'El Mezquite Verde;El Rosalito (Laguna del Muerto);Santa Fe (Abel Rodríguez Quiroz);La Ventura (El Grullo);Potrero del Muerto;Santa Matilde;El Convento;El Lobo Grande;El Lobo Chico;Santa Cecilia (Mario Rodríguez Quiroz)', 'Santo Domingo', 'San Luis Potosí'),
(78643, 'San Juan del Salado;San Dionisio;Caldereta;Providencia;Cerrito el Tejón;Cerro el Tezontle;Los Remedios', 'Santo Domingo', 'San Luis Potosí'),
(78644, 'San Vicente Banderillas', 'Santo Domingo', 'San Luis Potosí'),
(78645, 'La Larga;Illescas;Charco Colorado;Las Papas;Gámez', 'Santo Domingo', 'San Luis Potosí'),
(78646, 'San José Calihuey;Rancho San Antonio;Palma Mocha;Jesús María', 'Santo Domingo', 'San Luis Potosí'),
(78647, 'Santa Clara;Zancarrón;El Chaparro;Santa María;El Arenal;San Antonio Banderillas;El Capisallo', 'Santo Domingo', 'San Luis Potosí'),
(78649, 'San Antonio del Mezquite;Zaragoza (Pozo Salado);Las Palomas;San Simón', 'Santo Domingo', 'San Luis Potosí'),
(78660, 'Dulce Grande;El Barril', 'Villa de Ramos', 'San Luis Potosí'),
(78665, 'El Naranjal', 'Villa de Ramos', 'San Luis Potosí'),
(78670, 'Hernandez;San Martín', 'Villa de Ramos', 'San Luis Potosí'),
(78671, 'El Toro', 'Villa de Ramos', 'San Luis Potosí'),
(78680, 'Sáuz de Calera;Salitral de Carreras', 'Villa de Ramos', 'San Luis Potosí'),
(78681, 'El Zacatón', 'Villa de Ramos', 'San Luis Potosí'),
(78685, 'La Dulcita', 'Villa de Ramos', 'San Luis Potosí'),
(78689, 'Noria del Gato', 'Villa de Ramos', 'San Luis Potosí'),
(78690, 'La Herradura;Ramos Villa', 'Villa de Ramos', 'San Luis Potosí'),
(78695, 'Yoliatl', 'Villa de Ramos', 'San Luis Potosí'),
(78696, 'San Francisco', 'Villa de Ramos', 'San Luis Potosí'),
(78697, 'San Pablo;Santa Lucía', 'Villa de Ramos', 'San Luis Potosí'),
(78700, 'Baltazar Martínez;Lindavista;Matehuala Centro', 'Matehuala', 'San Luis Potosí'),
(78710, 'Privada Las Haciendas;Ferrocarrilera;Llano Luz;Bugambilias;Obrera;Villas La Forestal;Residencial Los Cedros', 'Matehuala', 'San Luis Potosí'),
(78712, 'Bella Gaviota', 'Matehuala', 'San Luis Potosí'),
(78715, '22 de Mayo;Las Palmas;Los Pinos;Antorchistas;La Finca II;Las Américas', 'Matehuala', 'San Luis Potosí'),
(78716, 'Las Mercedes II;La Granja', 'Matehuala', 'San Luis Potosí'),
(78717, 'Florida II;Llano Azul;La Finca', 'Matehuala', 'San Luis Potosí'),
(78720, 'Guadalupe Tepeyac;Privada San Benito;San Miguel;Los Pinos Poniente;Residencial Los Andes;Privada Hacienda Las Palmas;Residencial San Agustín;Antares;Magisterial los Reyes;Magisterial María Luisa Castillo;Kildun I;Guadalupe;Lic. Luis Echeverría Alvarez', 'Matehuala', 'San Luis Potosí'),
(78721, 'FOVISSSTE', 'Matehuala', 'San Luis Potosí'),
(78722, 'Colinas de La Paz;Hidalgo;FOVISSSTE Modulo II;Los Arcos;Bollería', 'Matehuala', 'San Luis Potosí'),
(78723, 'INFONAVIT', 'Matehuala', 'San Luis Potosí'),
(78724, 'Los Magueyes de La Piedra;Fidel Velázquez;Minerales;Prod Betania', 'Matehuala', 'San Luis Potosí'),
(78725, 'Jardines de Ojo de Agua;Ojo de Agua;Emiliano Zapata;La Florida', 'Matehuala', 'San Luis Potosí'),
(78726, 'Ollería', 'Matehuala', 'San Luis Potosí'),
(78727, 'Valle Dorado', 'Matehuala', 'San Luis Potosí'),
(78730, 'El Pineño;Lázaro Cárdenas;Forestal;San Isidro;Luis N Morones;Palma de Romero;El Pineño', 'Matehuala', 'San Luis Potosí'),
(78740, 'República', 'Matehuala', 'San Luis Potosí'),
(78743, 'Unidad Antorchista', 'Matehuala', 'San Luis Potosí'),
(78745, 'Benito Juárez;República;Manuel Moreno Torres;Las Vegas', 'Matehuala', 'San Luis Potosí'),
(78746, 'Aviación', 'Matehuala', 'San Luis Potosí'),
(78747, 'Ojo de Agua', 'Matehuala', 'San Luis Potosí'),
(78750, 'San Miguelito;Juárez', 'Matehuala', 'San Luis Potosí'),
(78759, 'Santa Lucina;Las Cumbres', 'Matehuala', 'San Luis Potosí'),
(78760, 'Las Mercedes;El Fraile;Nogales;Las Arboledas;Santa Martha', 'Matehuala', 'San Luis Potosí'),
(78769, 'Electricistas;España', 'Matehuala', 'San Luis Potosí'),
(78770, 'Lagunita', 'Matehuala', 'San Luis Potosí'),
(78779, 'La Dichosa;Valle de La Dichosa', 'Matehuala', 'San Luis Potosí'),
(78780, 'Gral. Rivas Guillen;Paraíso;Niños Héroes', 'Matehuala', 'San Luis Potosí'),
(78783, 'Las Hadas;Lupita;San José;Libertad', 'Matehuala', 'San Luis Potosí'),
(78784, 'Bustamante II;Carlos Jonguitud Barrios INFONAVIT;De León;San Antonio;San Angel;Loma Alta', 'Matehuala', 'San Luis Potosí'),
(78785, 'Del Bosque;del Bosque;El Mirador', 'Matehuala', 'San Luis Potosí'),
(78786, 'Guadalupe', 'Matehuala', 'San Luis Potosí'),
(78787, 'La Puerta del Río', 'Matehuala', 'San Luis Potosí'),
(78788, 'Viveros', 'Matehuala', 'San Luis Potosí'),
(78789, 'Jardín;Bustamante III;Vistahermosa', 'Matehuala', 'San Luis Potosí'),
(78790, 'Matehuala;Olivar de las Animas;La Conejera', 'Matehuala', 'San Luis Potosí'),
(78792, 'El Gallo', 'Matehuala', 'San Luis Potosí'),
(78793, 'San Ramón', 'Matehuala', 'San Luis Potosí'),
(78796, 'La Providencia', 'Matehuala', 'San Luis Potosí'),
(78797, 'Altamira', 'Matehuala', 'San Luis Potosí'),
(78798, 'Ánimas;La Concepción;Las Mitras', 'Matehuala', 'San Luis Potosí'),
(78799, 'El Encanto', 'Matehuala', 'San Luis Potosí'),
(78800, 'Estanque de Agua Buena;Santa Cruz;Tanque Colorado;Sacramento;San Antonio de las Barrancas;San José de las Trojes;Los Pocitos;Noria de La Cabra;El Mezquite', 'Matehuala', 'San Luis Potosí'),
(78801, 'Guadalupe de los Paz;Parritas;Arroyito de Agua;La Caja;La Minita', 'Matehuala', 'San Luis Potosí'),
(78802, 'Ojo de Agua;Carbonera;Rancho Nuevo', 'Matehuala', 'San Luis Potosí'),
(78803, 'Palmarito;La Peña;Cerrito Blanco;San José de La Viuda', 'Matehuala', 'San Luis Potosí'),
(78804, 'Zaragoza', 'Matehuala', 'San Luis Potosí'),
(78805, 'Buenavista;La Gavia', 'Matehuala', 'San Luis Potosí'),
(78808, 'Cereso Matehuala SLP', 'Matehuala', 'San Luis Potosí'),
(78810, 'Encarnación de Abajo', 'Matehuala', 'San Luis Potosí'),
(78811, 'San Francisco Caleros;La Joya', 'Matehuala', 'San Luis Potosí'),
(78812, 'Santa Ana;Noria de los Conos;Palmas', 'Matehuala', 'San Luis Potosí'),
(78814, 'Piedra Blanca;El Herrero;Guerrero', 'Matehuala', 'San Luis Potosí'),
(78815, 'Sarabia;Maravillas', 'Matehuala', 'San Luis Potosí'),
(78816, 'Santa Lucía', 'Matehuala', 'San Luis Potosí'),
(78818, 'La Luz', 'Matehuala', 'San Luis Potosí'),
(78819, 'Concepción;San José de Ipoa', 'Matehuala', 'San Luis Potosí'),
(78820, 'El Carmen', 'Matehuala', 'San Luis Potosí'),
(78821, 'Pastoriza', 'Matehuala', 'San Luis Potosí'),
(78822, 'San José del Plan', 'Matehuala', 'San Luis Potosí'),
(78824, 'San José de los Guajes;16 de Septiembre', 'Matehuala', 'San Luis Potosí'),
(78827, 'San Miguel', 'Matehuala', 'San Luis Potosí'),
(78830, 'La Paz Centro', 'Villa de la Paz', 'San Luis Potosí'),
(78833, 'Guiche;Depto. de la Cruz', 'Villa de la Paz', 'San Luis Potosí'),
(78834, 'La Esperanza;San José', 'Villa de la Paz', 'San Luis Potosí'),
(78835, 'Real de Minas', 'Villa de la Paz', 'San Luis Potosí'),
(78836, 'Refugio Soria;San Antonio de Zaragoza;San Antonio de Las Trojes;El Carmen;Limones;Los Nazarios;El Jato;Jesús Martínez;Rosalío Noriega', 'Villa de la Paz', 'San Luis Potosí'),
(78837, 'Barbechos;Jaquis;Laureles;La Boca', 'Villa de la Paz', 'San Luis Potosí'),
(78840, 'Biznaga;Buenavista', 'Villa de Guadalupe', 'San Luis Potosí'),
(78841, 'Puerto de Magdalena', 'Villa de Guadalupe', 'San Luis Potosí'),
(78843, 'La Presa', 'Villa de Guadalupe', 'San Luis Potosí'),
(78844, 'La Presita;Los Chilares', 'Villa de Guadalupe', 'San Luis Potosí'),
(78847, 'Magdalenas', 'Villa de Guadalupe', 'San Luis Potosí'),
(78850, 'Villa de Guadalupe;Zaragoza de Solís;Rancho Alegre;Guadalupito;Santa Isabel', 'Villa de Guadalupe', 'San Luis Potosí'),
(78851, 'Morelos', 'Villa de Guadalupe', 'San Luis Potosí'),
(78853, 'Llano de Jesús María', 'Villa de Guadalupe', 'San Luis Potosí'),
(78855, 'San José del Muerto;El Leoncito', 'Villa de Guadalupe', 'San Luis Potosí'),
(78858, 'Jarillas;Santa Rosa', 'Villa de Guadalupe', 'San Luis Potosí'),
(78859, 'San Antonio de La Ordeña', 'Villa de Guadalupe', 'San Luis Potosí'),
(78860, 'La Masita', 'Villa de Guadalupe', 'San Luis Potosí'),
(78862, 'San Bartolo;Vallejo', 'Villa de Guadalupe', 'San Luis Potosí'),
(78863, 'Palo Blanco', 'Villa de Guadalupe', 'San Luis Potosí'),
(78864, 'Santa Rita de Hernandez', 'Villa de Guadalupe', 'San Luis Potosí'),
(78866, 'San Francisco', 'Villa de Guadalupe', 'San Luis Potosí'),
(78868, 'Santa Teresa', 'Villa de Guadalupe', 'San Luis Potosí'),
(78870, 'Guadalcázar;Cantarranas', 'Guadalcázar', 'San Luis Potosí'),
(78873, 'San Pedro', 'Guadalcázar', 'San Luis Potosí'),
(78880, 'El Llano del Lobo;La Pedrera;Entronque de Matehuala (El Huizache);Los Amoles;El Rey del Camino;La Verdolaga;San José de las Flores;Crucero de Charco Cercado (El Parador);Charco Cercado;El Huizache;Colonia Menonita del Huizache;Cuajimalpa;San Juan sin Agua', 'Guadalcázar', 'San Luis Potosí'),
(78883, 'El Refugio del Amparito;Presa de Guadalupe;Las Negritas;San Agustín;Santo Domingo;Progreso;San Antonio de Trojes', 'Guadalcázar', 'San Luis Potosí'),
(78884, 'Colonia Agrícola San José;El Quelital;La Hincada;San Rafael de los Nietos;Buenavista', 'Guadalcázar', 'San Luis Potosí'),
(78885, 'San Isidro;El Plan;Rancho la Cieneguilla;San Francisco de los Toros;San Miguel (El Llano);Realejo;El Terrero de los Posadas;Minas de Plata;El Huaricho;El Murciélago;Las Lagunas;Rincón de Santa Elena;Santa Rita;El Oro;Las Clavellinas;Aguaje de Sánchez;La Huerta de los Conches;La Tapada;Ábrego;Andana;La Estacada;La Yerbabuena;Pozo de Acuña;La Escondida;La Tinaja;Potreritos;Potrero de los Sánchez;Puerto de las Matianas', 'Guadalcázar', 'San Luis Potosí'),
(78886, 'Los Pinos;Entronque de Guadalcázar;El Aguaje de García;San Pedro el Alto;Palos Altos;San Nicolás;San Cristóbal;Las Trojas (San Miguel);Potrero de Pinedas;Charco Blanco;San José de Cervantes', 'Guadalcázar', 'San Luis Potosí'),
(78887, 'La Trinidad;El Ranchito;La Esperanza (Núñez);La Nueva Jerusalén (La Borrega);La Campana;San Isidro;Santa María del Tecomate;La Negrita;Crucero Pozas de Santa Ana;Crucero la Presita (Tanque la Presita);Crucero Noria de las Flores;La Noria de las Flores;Laguna de Gerardo;Pozas de Santa Ana;Núñez;Rancho el Castillo;Peyote', 'Guadalcázar', 'San Luis Potosí'),
(78890, 'Puerta de Jesús María (La Rosita);San Gregorio;San Martín (San Martín del Tanquito);La Boquilla;San Juanito de Anhelo;La Media Nega;San Ignacio;El Fraile;La Naranjita;San Francisco del Tulillo;San Antonio del Tulillo;Soledad de la Biznaga;El Tulillo', 'Guadalcázar', 'San Luis Potosí'),
(78893, 'El Milagro de Guadalupe;Estanque Blanco;San Mauricio (La Carbonera)', 'Guadalcázar', 'San Luis Potosí'),
(78894, 'Los Ángeles Número Dos;Ranchito Grande (La Loma);Los Ángeles Número Uno;La Joya de la Laja;El Puerto de la Clavellina;El Jaujal;Domingo Gámez;Presa el Pinto', 'Guadalcázar', 'San Luis Potosí'),
(78895, 'San Vicente;El Jicote;Los Anteojos;El Paisano;Rancho Nuevo', 'Guadalcázar', 'San Luis Potosí'),
(78896, 'La Ventana;Presita del Tepetate;Pozo Colorado', 'Guadalcázar', 'San Luis Potosí'),
(78897, 'El Barrial;La Palapa;Potrero San Julián;San José del Refugio;El Anteojo;Los Torres [Restaurante];Santa Rita del Rucio;La Pólvora;Crucero la Pólvora;Los Tres Reales;Norias del Refugio;San Carlos', 'Guadalcázar', 'San Luis Potosí'),
(78900, 'San Juan;Magisterial;Tlaxcala;Cristo Rey;Aduana;Buena Vista;La Laguna;Cruces;Charco del Lobo;Cucamo;Moctezuma;Morados;San José;San José del Grito;Camposanto;Refugio', 'Moctezuma', 'San Luis Potosí'),
(78901, 'Santa Teresa', 'Moctezuma', 'San Luis Potosí'),
(78902, 'Garabatillo', 'Moctezuma', 'San Luis Potosí'),
(78903, 'Labor Vieja;Santa Catarina', 'Moctezuma', 'San Luis Potosí'),
(78904, 'Pozos de Matanza;El Rebalín', 'Moctezuma', 'San Luis Potosí'),
(78905, 'Morterillos;La Presa', 'Moctezuma', 'San Luis Potosí'),
(78906, 'El Colorado;Salsipuedes;El Retiro', 'Moctezuma', 'San Luis Potosí'),
(78908, 'La Cueva;Arroyo Hondo', 'Moctezuma', 'San Luis Potosí'),
(78909, 'Juache;Ancón', 'Moctezuma', 'San Luis Potosí'),
(78910, 'Providencia', 'Moctezuma', 'San Luis Potosí'),
(78911, 'San Ignacio', 'Moctezuma', 'San Luis Potosí'),
(78914, 'Clavellinas;Ex-Hacienda de Enramada', 'Moctezuma', 'San Luis Potosí'),
(78918, 'Rancho Nuevo', 'Moctezuma', 'San Luis Potosí'),
(78919, 'El Estanco;San Antonio de Rul;Codorniz', 'Moctezuma', 'San Luis Potosí'),
(78920, 'Venado', 'Venado', 'San Luis Potosí'),
(78923, 'San Cayetano;El Cenizal', 'Venado', 'San Luis Potosí'),
(78924, 'Barrio de Guadalupe', 'Venado', 'San Luis Potosí'),
(78925, 'San Sebastián;Lomas de Guadalupe;San Francisco;San José', 'Venado', 'San Luis Potosí'),
(78926, 'La Cruz Negra;Ricardo Flores Magón;San Juan;Loma Linda', 'Venado', 'San Luis Potosí'),
(78927, 'Del Valle;La Purísima;Villa de Las Flores', 'Venado', 'San Luis Potosí'),
(78930, 'El Gateado;La Puerta;La Puerta;Tanque la Milpa;Andrés Rangel;Eulogio Zamarripa;La Vaina;Palo Blanco;La Cañada San Juan;Cinco de Febrero;Guanamé;El Grullo;El Matorral;Viborillas;Los Remedios;El Colgado;Los Elotes;Los Lobitos;La Manga (Tanque la Bota);La Piedra;La Reforma;Toledo', 'Venado', 'San Luis Potosí'),
(78933, 'Ejido el Salero;La Ciénaga de Guanamé;Quinta Ojo de Agua;San Onofre;Cinco de Mayo;El Sotolillo de Abajo;El Laurel;La Barranca Norte;Polocote de Arriba;El Salero;El Cuije;El Tejón;El Sotol;La Lagunita del Sotol;Venado;El Conejo;Los Trejos', 'Venado', 'San Luis Potosí'),
(78934, 'Cerro Verde;San Sabino;Santa Rita (El Alto);Barrio de Guadalupe Dos (Mexiquito);La Curva (La Esquina);Rancho Nuevo;Santa Rita;El Arenal;Noria de la Unión;San Sebastián;El Faro;Pozo Número Dos;Pozo Número Nueve;Pozo Número Tres (Santa Rita);Noria de Santa Teresa;Polocote de Abajo (Polocotillo);Pozo Número Siete;Tierra Blanca;El Clérigo (Miguel Rivera Banderas);Pozo Número Ocho;Pozo Número Tres (Barrio de Guadalupe);San Mateo;El Tecolote', 'Venado', 'San Luis Potosí'),
(78935, 'La Clavellina;El Charquillo;La Trinidad;El Refugio;El Charco Verde;Coronado (Hacienda de Coronado)', 'Venado', 'San Luis Potosí'),
(78936, 'El Salitre;El Pocito;El Berrendo;Don Diego;San Pedro;San Joaquín de las Flores;El Epazote;El Charquito', 'Venado', 'San Luis Potosí'),
(78937, 'El Huizachal;La Presa Colorada;Cerro Blanco;El Ranchito;Cañada del Cuarto;El Chaparralillo (El Chaparral);El Machito (El Tanque del Machito);El Pozote;Las Crucitas;Cañada Grande;Los Muñiz;Agua de En Medio;Calabacillas;El Chaparral;Las Jarillas;Barranca del Sur;Don Longino;El Rebaje;El Cerrito;Buenavista;El Sauco', 'Venado', 'San Luis Potosí'),
(78940, 'Villa de Arista Centro', 'Villa de Arista', 'San Luis Potosí'),
(78943, 'Benito Juárez;Los Nogales', 'Villa de Arista', 'San Luis Potosí'),
(78944, 'Hipodromo', 'Villa de Arista', 'San Luis Potosí'),
(78945, 'Vialle de Arista', 'Villa de Arista', 'San Luis Potosí'),
(78947, 'Niños Héroes;Guadalupe', 'Villa de Arista', 'San Luis Potosí'),
(78950, 'El Corazón de Jesús;La Florida;Ranchito San Isidro (Los Llanitos);Rancho el Huevo;San Eduardo;San Martín de Guadalupe;El Vergel;Rafael García;Rancho Grande;Rancho Santa Rosa (La Luz);San Fernando;El Diamante;Granja de San Isidro;José Luis;La Granja;Los Hermanos Neri;Ninguno [Planta de Luz];Rancho de la Cruz;Rancho San Rafael;San Antonio;San José;El Mezquite;Santa Teresa;Felipe Miranda;Potrero el Maguey (Olga Lidia Monsiváis);Rancho la Magdalena;Santa Carolina;Charco Blanco;Colonia Guadalupe;El Trébol;Fracción la Palma;Granja el Saucito;Rancho Campo el Gato;San Elías;San Fidel;Santa Rosa;Capillas (La Capilla);El Maguey de Limones;El Pozo;Escamilla [Empacadora];Guardarraya;La Víbora (Herminio Gámez);Los Cedros;Los Pilares;Rancho el Progreso;Rancho San José de las Flores;San Rafael;Buenavista;Rancho Chelita;San José de Buenavista;El Dorado;El Maguey de Ezqueda;El Olivo;Granja San José;Jesús Gámez;Rancho el Bajío;Rancho el Mezquite;Rancho el Rifle;Rancho Santa Cecilia;San Jorge', 'Villa de Arista', 'San Luis Potosí'),
(78953, 'La Escondida;La Cecilia;San José de Buenavista (El Cochinito);El Cañón de las Auras', 'Villa de Arista', 'San Luis Potosí'),
(78954, 'Salitrillos;El Charquito;Rancho el Gachupín', 'Villa de Arista', 'San Luis Potosí'),
(78955, 'Piedra Rodada (Antonio Martínez Leija);Rancho María del Pilar;San Silverio;El Pedernal;San José de Altamira;El Tajo;La Lajita;San José del Arbolito;Ingeniero Palau (Rancho los Nogales);La Tinaja;Martín Gámez;El Bajío;Rancho el Pitayo;San Pedro;Capillla de las Peñitas;Cuatro Caminos;Cirilo Saldaña', 'Villa de Arista', 'San Luis Potosí'),
(78956, 'El Palmarito;Ejido Villa de Arista (Amado Torres Tovar);José Leonor Sierra;La Presa (Francisco Camacho Rivera);Las Paredes;Majada de Don Paz;Charco Valeria;Quirino Castro;Ejido Villa de Arista (Guadalupe González);El Azafrán;El Charco los Ganaderos;Federico Gámez', 'Villa de Arista', 'San Luis Potosí'),
(78957, 'Los Parras;Milpas;Tanque el Árbol;Mesteñas;Rancho la Aurora;El Refugio;La Pelotera (Venta del Carmen);Herminio Gámez;Peñita de Guadalupe;Rancho el Rosario;Santo Tomás;Derramaderos;Rancho el Palomo;Raúl Costilla;Colonia Buenavista;Rancho San David;San Dionisio;San Leonel;Palmas Anchas;Rancho Santa Anita;San Alejandro;Santa Leticia;La Lagunita;Pegolas;San Isidro;Santa Rosa;Tanque el Novillero', 'Villa de Arista', 'San Luis Potosí'),
(78958, 'Rincón de Leijas;El Palmito;El Tanquecito', 'Villa de Arista', 'San Luis Potosí'),
(78960, 'Villa Hidalgo Centro', 'Villa Hidalgo', 'San Luis Potosí'),
(78963, 'El Mirador II;Rancho Grande;Las Lomas;Ma de los Angeles', 'Villa Hidalgo', 'San Luis Potosí'),
(78964, 'El Picacho;La Calavarera', 'Villa Hidalgo', 'San Luis Potosí'),
(78965, 'Campamento;Zapioris;El Mirador I;La Chinana;Magisterial', 'Villa Hidalgo', 'San Luis Potosí'),
(78966, 'Tanque de Luna;Venaditos;Noria de San Antonio (Noria del Agrito);Valle de San Juan;Veinte de Noviembre;El Potrerito de la Cruz;Trojes;Sequedad;La Huerta (Beto Ramírez);Presita de la Cruz;Rancho del Valle', 'Villa Hidalgo', 'San Luis Potosí'),
(78967, 'El Leoncito;Corcovada;Jagüey;Lolita [Restaurante];El Colorado;El Salto;Noria de las Peñitas;La Redonda;Tanque Blanco;Tanquecito de San Francisco;Las Mesitas (La Tasita);Majada de los Rico;Zapotillo;Pedrera del Tanquito;El Puerto;Pozo de Villa Hidalgo', 'Villa Hidalgo', 'San Luis Potosí'),
(78968, 'San Antonio;Peotillos;San Ignacio;Sección Ferrocarril (La Sección);Lagunillas;Paso Blanco;San Nicolás del Refugio;Estación Peotillos;Matancillas', 'Villa Hidalgo', 'San Luis Potosí'),
(78970, 'El Ojito;El Durazno de Juárez;El Coro;Tanque de la Cruz;Corazones;Tanque Nuevo;El Arbolito (El Coyote);Mi Ranchito', 'Villa Hidalgo', 'San Luis Potosí'),
(78973, 'El Guayule;Noria la Tinajuela;Cerritos Blancos;El Sotolito;El Cacahuate;Noria la Purísima;San Lorenzo;Café Base Mexicali [Restaurante];El Rey del Camino [Restaurante];Las Cebollas;Los Compadres [Restaurante];San Luis [Gasera];El Camarillo', 'Villa Hidalgo', 'San Luis Potosí'),
(78974, 'Las Minitas;El Pocito;La Loma', 'Villa Hidalgo', 'San Luis Potosí'),
(78975, 'Las Hormigas;Tanque Romerillo', 'Villa Hidalgo', 'San Luis Potosí'),
(78976, 'San Juan de las Higueras (El Zorrillo);Presa de Chancaquero;Calabacillas;San Isidro;Llano del Carmen;El Aljíber', 'Villa Hidalgo', 'San Luis Potosí'),
(78977, 'El Coyote;La Tapona;Juan Fidel', 'Villa Hidalgo', 'San Luis Potosí'),
(78978, 'Silos', 'Villa Hidalgo', 'San Luis Potosí'),
(78979, 'Rincón del Refugio', 'Villa Hidalgo', 'San Luis Potosí'),
(78980, 'Armadillo de los Infante', 'Armadillo de los Infante', 'San Luis Potosí'),
(78983, 'El Aguaje de los Castillos;San Elías;El Tanquecito;Los Troncos;Contrayerba;Loma Alta;El Ranchito de los Guzmán;Palomas (El Valle de Palomas);La Escondida;Los Charcos;Tinajillas', 'Armadillo de los Infante', 'San Luis Potosí'),
(78984, 'Rancho los Tomates;Salazar (El Gringo);San Antonio de Eguía;La Chicharra;Tlaxcalilla;El Sauz', 'Armadillo de los Infante', 'San Luis Potosí'),
(78985, 'Llano de los Patiño', 'Armadillo de los Infante', 'San Luis Potosí'),
(78986, 'La Haciendita de Usquiano;San José de Magaña;El Bolillo;Las Víboras;Los Mireles;Mezquitalillo;El Salto del Agua;La Cardona;Rancho Nuevo del Tízar;La Palmita', 'Armadillo de los Infante', 'San Luis Potosí'),
(78987, 'El Pato;San Cayetano;Los Ángeles;San José de Barbosa;Puerto de Chagoya;Corral de Piedra;El Alguacil;La Mesa del Refugio;Tanque de las Manzanas;Piedra Agujereada;Tortugas;El Chital (Manzanillas);Campamento el Chital;Lagunita de San Juan;Picacho de los Dolores;Rancho el Chital (La Carbonera);Torres Corzo', 'Armadillo de los Infante', 'San Luis Potosí'),
(78990, 'Cerro Grande;Temascal;Rincón del Refugio;Rancho Nuevo de la Cruz', 'Armadillo de los Infante', 'San Luis Potosí'),
(78993, 'Pozo del Carmen [COPLAMAR];La Concordia;Santa Lucía', 'Armadillo de los Infante', 'San Luis Potosí'),
(78994, 'El Durazno;Paradita del Refugio', 'Armadillo de los Infante', 'San Luis Potosí'),
(78995, 'Pozo del Carmen;El Salitre;El Caracol;Puerta del Refugio;Paso del Águila;Arroyo Hondo;Paso del Águila [COPLAMAR]', 'Armadillo de los Infante', 'San Luis Potosí'),
(78996, 'Hacienda Parada de Luna;Parada de San Rafael;Los Tanquitos;Nogalitos de la Cruz', 'Armadillo de los Infante', 'San Luis Potosí'),
(78997, 'San Miguel;Barranquita de San Rafael;El Desestrés;La Ciénaga;Rancho Nuevo de los Nájera;San José de Álvarez;Barranca de San Isidro;La Huerta de Manzano;Laguna de San Isidro;Llano de los Saldaña;Cieneguilla;El Capulín;San Rafael', 'Armadillo de los Infante', 'San Luis Potosí'),
(79000, 'Ciudad Valles Centro', 'Ciudad Valles', 'San Luis Potosí'),
(79010, 'Vista Hermosa II;América;Santa María;Ferrocarrilera;Morelos y Pavón;Vista Hermosa;Francisco Villa;El Consuelo;Márquez', 'Ciudad Valles', 'San Luis Potosí'),
(79019, 'Ingeniero García Téllez;Tecnológico;Santa Lucía;Mujeres En Solidaridad', 'Ciudad Valles', 'San Luis Potosí'),
(79020, 'INFONAVIT II;Valle Alto;Plan de Ayala;Campo Colonial;Campo Colonial;Magisterial;18 de Marzo;Doracely;Loma Bonita;Fidel Velázquez;Guadalupe;Granjas Buenos Aires;Marques;Lázaro Cárdenas;Monte Alegre;12 de Julio;20 de Noviembre;Valle Alto;Emiliano Zapata;Morelos', 'Ciudad Valles', 'San Luis Potosí'),
(79023, 'Del Sol;Las Palmas;La Estrella', 'Ciudad Valles', 'San Luis Potosí'),
(79025, 'Buenos Aires;Mary Tere;18 de Marzo;Las Granjas', 'Ciudad Valles', 'San Luis Potosí'),
(79027, 'El Pacifico;Alfonso Esper', 'Ciudad Valles', 'San Luis Potosí'),
(79028, 'El 21;Las Fincas;Tanculpaya;Villabrisa;Bugambilias;2 de Enero;Solidaridad;Banobras;S.C.T.;Lomas del Real;La Victoria', 'Ciudad Valles', 'San Luis Potosí'),
(79030, 'Santa Rosa;Diana;Praderas del Río;Ciudad Valles', 'Ciudad Valles', 'San Luis Potosí'),
(79033, 'La Curva;Estación;Funcionarios de Fibracel;Loma de los Silleros;Del Campo', 'Ciudad Valles', 'San Luis Potosí'),
(79034, 'Palo de Rosa;Florida', 'Ciudad Valles', 'San Luis Potosí'),
(79035, 'La Diana;Villa del Sol;Plan de Ayala', 'Ciudad Valles', 'San Luis Potosí'),
(79036, 'Antiguas Casas del Ingenio', 'Ciudad Valles', 'San Luis Potosí'),
(79040, 'INFONAVIT I;Cuauhtémoc;Moctezuma;FOVISSSTE;Avance;Francisco I Madero', 'Ciudad Valles', 'San Luis Potosí'),
(79043, 'Tetuán;Las Lomas;Los Filtros', 'Ciudad Valles', 'San Luis Potosí'),
(79050, 'Jardines del Valle;Bonifacio Salinas;Mirador;Obrera;Porvenir;Cemex;Alta Vista;Lomas del Mirador;Nely;Tipzen;Altavista;Anfer;Valle Oriente;Real de Villas II;Nelly Zulaiman;Antonio Esper;Lomas del Mirador;Real de Villas;Villa Real de Santiago;Méndez', 'Ciudad Valles', 'San Luis Potosí'),
(79058, 'Portenia;Norte Residencial', 'Ciudad Valles', 'San Luis Potosí'),
(79059, 'Las Brisas;Lomas del Porvenir;El Porvenir;19 de Enero;Residencial del Lago', 'Ciudad Valles', 'San Luis Potosí'),
(79060, 'Las Águilas;Rafael Curiel;Las Águilas', 'Ciudad Valles', 'San Luis Potosí'),
(79063, 'San Rafael;Tantocob', 'Ciudad Valles', 'San Luis Potosí'),
(79064, 'Tampico;La Alhajita;San Angel I', 'Ciudad Valles', 'San Luis Potosí'),
(79068, 'La Pimienta;Del Carmen;Palma Sola;Rosas del Tepeyac;Del Carmen', 'Ciudad Valles', 'San Luis Potosí'),
(79070, 'Cantarranas;Juárez;B Castro', 'Ciudad Valles', 'San Luis Potosí'),
(79080, 'Rotarios;El Vergel;Cerillera;María Nilda;Hidalgo;Hidalgo;Pen', 'Ciudad Valles', 'San Luis Potosí'),
(79082, 'Lomas Poniente;San Luis Poniente;Lomas de Yuejat;Leonardo Rodríguez Alcaine', 'Ciudad Valles', 'San Luis Potosí'),
(79083, 'Morales;Villa del Vergel', 'Ciudad Valles', 'San Luis Potosí'),
(79084, 'Lomas de Oriente;Bellavista', 'Ciudad Valles', 'San Luis Potosí'),
(79085, 'Misión San Miguel;Real Valles', 'Ciudad Valles', 'San Luis Potosí'),
(79088, 'Cereso Ciudad Valles SLP', 'Ciudad Valles', 'San Luis Potosí'),
(79090, 'Olegario Vizcarra', 'Ciudad Valles', 'San Luis Potosí'),
(79092, 'Militar;Jardín del Campestre;Real Campestre;Rodríguez', 'Ciudad Valles', 'San Luis Potosí'),
(79093, 'Oxitipa;Bicentenario', 'Ciudad Valles', 'San Luis Potosí'),
(79094, 'Lomas de San José;Residencial Santa Claudia;San Angel II', 'Ciudad Valles', 'San Luis Potosí'),
(79095, 'Las 3 Huastecas;José María Morelos y Pavón;Lomas de Santiago;El Gavilán;Gregorio Osuna;Valle 85;Municipal', 'Ciudad Valles', 'San Luis Potosí'),
(79097, 'Yuejat;Central Camionera;San Luis', 'Ciudad Valles', 'San Luis Potosí'),
(79098, 'Margarita de Gortari;CECYT;San José', 'Ciudad Valles', 'San Luis Potosí'),
(79100, 'Centro', 'Ebano', 'San Luis Potosí'),
(79110, 'Zostepec;Estación', 'Ebano', 'San Luis Potosí'),
(79120, 'Las Américas;Antonio J. Bermúdez', 'Ebano', 'San Luis Potosí'),
(79122, 'Santa Cruz;20 de Noviembre', 'Ebano', 'San Luis Potosí'),
(79130, 'Los Pinos', 'Ebano', 'San Luis Potosí'),
(79139, 'El Hule;Ampliación Del Valle;Del Valle', 'Ebano', 'San Luis Potosí'),
(79140, 'Obrera', 'Ebano', 'San Luis Potosí'),
(79142, 'Dr. Quintana;Vicente Inguanzo', 'Ebano', 'San Luis Potosí'),
(79143, 'Primavera', 'Ebano', 'San Luis Potosí'),
(79150, 'Petrolera Lázaro Cárdenas;Solidaridad;Himno Nacional', 'Ebano', 'San Luis Potosí'),
(79152, 'Bellavista;Valle Dorado;Puerta del Sol', 'Ebano', 'San Luis Potosí'),
(79153, 'Aviación;Unidad Nacional', 'Ebano', 'San Luis Potosí'),
(79160, '18 de Marzo', 'Ebano', 'San Luis Potosí'),
(79161, '20 de Noviembre', 'Ebano', 'San Luis Potosí'),
(79162, 'Zona Industrial', 'Ebano', 'San Luis Potosí'),
(79170, 'Tulipanes', 'Ebano', 'San Luis Potosí'),
(79180, 'Vergel', 'Ebano', 'San Luis Potosí'),
(79182, 'Manuel Avila Camacho;INFONAVIT', 'Ebano', 'San Luis Potosí'),
(79183, 'Campamento SARH', 'Ebano', 'San Luis Potosí'),
(79190, 'Zona Cuartel;El Veintiuno', 'Ebano', 'San Luis Potosí'),
(79200, 'Tamuin Centro', 'Tamuín', 'San Luis Potosí'),
(79202, 'El Campo;Morelos;Victor Manuel Santos', 'Tamuín', 'San Luis Potosí'),
(79203, 'Las Brisas;Salvador Nava Martínez;El Mirasol', 'Tamuín', 'San Luis Potosí'),
(79204, 'Los Pericos;Quinta Dulce', 'Tamuín', 'San Luis Potosí'),
(79205, 'Magisterial;Las Norias;Hidalgo;Lindavista', 'Tamuín', 'San Luis Potosí'),
(79206, 'Ricardo Flores Magón;Tanmuachan;Juárez;Media Luna', 'Tamuín', 'San Luis Potosí'),
(79207, 'Nuevo Tamuin;Pueblo Nuevo', 'Tamuín', 'San Luis Potosí'),
(79208, 'Vista Alegre;Las Gaviotas;Colosio;Valle Alto;Del Bosque', 'Tamuín', 'San Luis Potosí'),
(79210, 'Tamuin', 'Tamuín', 'San Luis Potosí'),
(79212, 'Santa Elena', 'Tamuín', 'San Luis Potosí'),
(79213, 'El Peñasco', 'Tamuín', 'San Luis Potosí'),
(79214, 'Santa Martha', 'Tamuín', 'San Luis Potosí'),
(79215, 'Nuevo Aquismón', 'Tamuín', 'San Luis Potosí'),
(79216, 'La Ceiba', 'Tamuín', 'San Luis Potosí'),
(79217, 'Luis Donaldo Colosio', 'Tamuín', 'San Luis Potosí'),
(79218, 'Velazco', 'Tamuín', 'San Luis Potosí'),
(79219, 'Tamuín (Tamuín)', 'Tamuín', 'San Luis Potosí'),
(79220, 'El Palmar;Palmas', 'Tamuín', 'San Luis Potosí'),
(79224, 'Nuevo Tampaón', 'Tamuín', 'San Luis Potosí'),
(79225, 'Los Huastecos;El Centinela;Ávila Camacho;San José del Limón', 'Tamuín', 'San Luis Potosí'),
(79226, 'Nuevo Ahuacatitla', 'Tamuín', 'San Luis Potosí'),
(79227, 'Nueva Primavera', 'Tamuín', 'San Luis Potosí'),
(79228, 'Antiguo Tamuin;La Fortaleza', 'Tamuín', 'San Luis Potosí'),
(79230, 'Campo Negro (Rogelio Contreras Espinoza);Ejido las Canoas (Canoas);San Lorenzo;El Colorado;Ejido la Hincada', 'Ciudad Valles', 'San Luis Potosí'),
(79233, 'Nuevo Crucitas;El Entripado;Estación Micos;El Veladero', 'Ciudad Valles', 'San Luis Potosí'),
(79234, 'La Puerta del Espíritu Santo;Los Pinos', 'Ciudad Valles', 'San Luis Potosí'),
(79235, 'San Pedro (La Antigua Hincada);El Platanito Número Tres;Ampliación la Hincada;Nuevo Tepeguajes;La Virgen;Rioverdito', 'Ciudad Valles', 'San Luis Potosí'),
(79236, 'Ojo de Agua;Las Huertas', 'Ciudad Valles', 'San Luis Potosí'),
(79237, 'Crucero las Pitas;El Sabino del Obispo;El Choy;El Limoncito;Las Pitas;La Esperanza', 'Ciudad Valles', 'San Luis Potosí'),
(79240, 'Rascón', 'Ciudad Valles', 'San Luis Potosí'),
(79243, 'Las Crucitas;Casa Blanca;Andrea San Juan;María Castillo Salazar;San Francisco;San Dieguito', 'Ciudad Valles', 'San Luis Potosí'),
(79244, 'Estación Quinientos', 'Ciudad Valles', 'San Luis Potosí'),
(79245, 'Las Flores;San Isidro;San Pedro;El Platanito Uno;El Choyoso;La Gloria;Chantol;Los Jobos;Cerro Alto;La Soledad;Nombre de Dios', 'Ciudad Valles', 'San Luis Potosí'),
(79246, 'El Platanito;Campo Atonatilco;Ejido la Loma;Ejido la Loma (Canoítas);San Francisco;Entrada a Camillas;Coyoles;Camillas;La Loma (Quinientos Uno);Rancho Nuevo;La Pasadita (La Colmena)', 'Ciudad Valles', 'San Luis Potosí'),
(79247, 'Rancho San Antonio;San Isidro;El Poste (El Verde);Rancho Santa Fe;San Isidro (Los Estrada);Rancho el Siete;Palmillas;El Sabinito;San Mateo;Zocohuite;Dos Pericos (San Isidro);El Verde', 'Ciudad Valles', 'San Luis Potosí'),
(79250, 'La Pitaya (La Pitahaya);San Antonio;Buenavista;El Pantano;El Ojite;La Extremadura;El Disco', 'Ciudad Valles', 'San Luis Potosí'),
(79252, 'La Corriente y Troncones', 'Ciudad Valles', 'San Luis Potosí'),
(79253, 'Rancho Cuatro;Tantute;La Lagunita;Fraccionamiento Misión de San Miguel;La Copa;Tampaya;Cuatro Caminos;El Palmar (El Paso);Cambeses', 'Ciudad Valles', 'San Luis Potosí'),
(79254, 'La Esperanza (La Loma);Prodigio;El Algüey;La Escondida;El Azulejo;La Crucita (Barrio de Guadalupe);La Subida;La Urbina', 'Ciudad Valles', 'San Luis Potosí'),
(79255, 'Buenos Aires;El Tamarindo;El Aquichal;La Pila;Ejido el Chuchupe;Tierras Blancas;El Carrizal;Las Chochas', 'Ciudad Valles', 'San Luis Potosí'),
(79256, 'El Jacubal;Rancho Nuevo;El Bárbol;El Mocoque;La Lima;El Atascadero;El Chical Uno;La Loma;El Chical Dos;El Lindero;La Antigua', 'Ciudad Valles', 'San Luis Potosí'),
(79257, 'El Maguey;Ojo de Agua;San Antonio Huichimal;Rancho Nuevo', 'Ciudad Valles', 'San Luis Potosí'),
(79260, 'Ejido la Toconala Uno (La Virgen);La Camelia;Villa María;El Gritadero;Jabalí;Loma de las Conchas;San Felipe;El Cuiche;La Concepción (La Concha);Tamunal;El Escape;Álvaro Obregón (El Pujal);Villa Fierro;El Detalle', 'Ciudad Valles', 'San Luis Potosí'),
(79263, 'Adolfo López Mateos;Ojo de Agua;Rancho Viejo;Salcedo;Cien Fuegos;Catán', 'Ciudad Valles', 'San Luis Potosí'),
(79264, 'Fracción el Turu;Las Moritas;El Desengaño;Los Humos;Loma del Desengaño (Ejido el Desengaño Dos);Ejido el Lobo', 'Ciudad Valles', 'San Luis Potosí'),
(79265, 'La Marina;Ejido Emiliano Zapata;El Jopoy;Entrada a Tamalte;Crucero de Tantóbal;Sacrificio (Nuevo Santiaguillo);Nuevo Tambolón;Ejido la Marina (Ejido Colectivo);Antiguo Tambolón;Tantóbal;Santiaguillo;El Refugio', 'Ciudad Valles', 'San Luis Potosí'),
(79266, 'Loma del Mirador;San Rafael;Tantizohuiche;San Juan;El Capulín (Río Escondido);El Chico', 'Ciudad Valles', 'San Luis Potosí'),
(79267, 'El Cinco;El Barranco (El Rosario);La Lomita;Rancho San Carlos;Chipico;San Miguel;Campo del Capulín;El Sidral (San Miguel el Sidral);Loma del Barranco', 'Ciudad Valles', 'San Luis Potosí'),
(79270, 'El Siete;La Calera;La Raya;San Felipe;Jacinto López;Álvaro Obregón;La Bolsa;El Nacimiento', 'Ciudad Valles', 'San Luis Potosí'),
(79273, 'Colonia Citlalmina;León García;Montecillos (La Curva);El Cañón del Taninul (El Abra);Fraccionamiento las Granjas;Montecillos;Colonia Eligio Quintanilla;El Abra (San Felipe)', 'Ciudad Valles', 'San Luis Potosí'),
(79274, 'Tampaspaque (Cruz de Aquiche);Los Sabinos Número Dos;El Aguaje', 'Ciudad Valles', 'San Luis Potosí'),
(79275, 'Lino Lárraga (La Unión);Gustavo Garmendia (La Unión);El Chubasco', 'Ciudad Valles', 'San Luis Potosí'),
(79276, 'El Rodeo;Rubén Abundis (Los Orejones)', 'Ciudad Valles', 'San Luis Potosí'),
(79277, 'Colonia Luis Donaldo Colosio;Colonia Juan González;Tanzacalte;Fraccionamiento Buenos Aires;Colonia Ejidal Lázaro Cárdenas del Río;Los Jobitos;Colonia Mano Amiga', 'Ciudad Valles', 'San Luis Potosí'),
(79280, 'Rancho Casas Viejas;La Milpa;Tanlecue (El Olivo);La Estribera;La Lagunita Dos;La Lagunita;La Perla', 'Ciudad Valles', 'San Luis Potosí'),
(79283, 'El Otate;Colonia Ignacio Zaragoza', 'Ciudad Valles', 'San Luis Potosí'),
(79284, 'Joaquín Peralta', 'Ciudad Valles', 'San Luis Potosí'),
(79285, 'San Ricardito;Laguna del Mante', 'Ciudad Valles', 'San Luis Potosí'),
(79286, 'Las Yeguas', 'Ciudad Valles', 'San Luis Potosí'),
(79287, 'Palo de Sabino;Buena Vista', 'Ciudad Valles', 'San Luis Potosí'),
(79290, 'La Reforma;Plan de Iguala;Ébano;Vichinchijol', 'Ebano', 'San Luis Potosí'),
(79292, 'Ponciano Arriaga;Emiliano Zapata;Aurelio Manrique', 'Ebano', 'San Luis Potosí'),
(79293, 'Alto de La Reforma;El Tulillo;Reforma Agraria;Ampliación Velazco;Auza;Pujal-coy', 'Ebano', 'San Luis Potosí'),
(79294, 'Velázco', 'Ebano', 'San Luis Potosí'),
(79295, 'Sarh', 'Ebano', 'San Luis Potosí'),
(79296, 'Ajinche;Uno Dicha', 'Ebano', 'San Luis Potosí'),
(79297, 'Julián Carrillo Dos', 'Ebano', 'San Luis Potosí'),
(79300, 'El Naranjo Centro', 'El Naranjo', 'San Luis Potosí'),
(79303, 'La Presa;Las Granjas El Naranjo;La Esperanza Sur;Habitacional;La Esperanza Norte', 'El Naranjo', 'San Luis Potosí'),
(79304, 'Azucareros - INFONAVIT;El Pedregal;Obrera', 'El Naranjo', 'San Luis Potosí'),
(79305, 'Arboleda;La Crúz;La Encantada;La Bahia;Las Margaritas', 'El Naranjo', 'San Luis Potosí'),
(79306, 'San Francisco;El Naranjito;Las Brisas;San José;La Huerta;Carlos Jonguitud Barrios', 'El Naranjo', 'San Luis Potosí'),
(79307, 'El Sabinito Plan del Naranjo', 'El Naranjo', 'San Luis Potosí'),
(79313, 'Los Álamos de Abajo;La Mesa de Guadalupe;La Toma;Ojo de Agua Tierra Nueva;La Mequihuana;Los Álamos de Arriba;La Sierrita;El Limonal;Cruz Montoya Hernández;El Abrevadero;El Carrizal;El Garabato', 'El Naranjo', 'San Luis Potosí'),
(79314, 'La Joya;La Rodada;Rancho el Colorado;San Nicolás;Colonia el Meco;El Colorado;Francisco Ventura Hernández;Lázaro Cárdenas;Rancho la Montaña (La Gonzalera);Rancho los Cuates;Colonia Salto del Agua;El Mirador;La Ceiba;La Soledad;Ojo de Agua de Ramón;Potrero el Sabinal;Rancho San Francisco;Camilo Arriaga [Central Hidroeléctrica];Campamento SCT;La Colmena;Río Escondido (La Caja);Francisco Hernández García;Los Corrales;Rancho la Cascada;El Naranjo;El Puerto;Abraham García;El Aterrizaje (Calderón);El Pedregal;Rancho la Paloma;El Bule;La Cabaña;La Laguna (Oscar Raúl Cano);La Nigua;Santa Laura;El Guamúchil;Florencio Flores (Granja);La Cascadita', 'El Naranjo', 'San Luis Potosí'),
(79315, 'La Yerbabuena del Oriente;Rincón de Álamos;El Sabinito;El Aguacate;La Loma (Ejido los Álamos);El Platanito;Maguey de Oriente;El Naranjito;La Concepción;Chupadero;El Chote;El Tanque;La Yerbabuena del Norte;Las Abritas;Las Palmas;Los Álamos', 'El Naranjo', 'San Luis Potosí'),
(79316, 'El Ojital;El Estribo;Loma Alta;Rancho la Cuesta;Santa Rita;Kilómetro Cuarenta y Dos;La Mutua;El Rincón de las Bombas (Nicolás Ortiz);La Mutua (El Estribo);Ejido Benito Juárez su Anexo el Potosino;El Edén (Villa Rosita);Rancho el Divisadero;Rancho el Rosario;Villa Rosita;Campamento Benito Juárez;Casa Blanca (El Banco);Ejido la Mutua;El Sabinito Plan del Naranjo;La Germinal;Minas Viejas;El Esfuerzo;Arroyo Hondo;Gregorio Moctezuma Sánchez;La Piedra;Rancho el Carmen;Rancho el Herradero;El Triunfo;Gregorio de la Rosa;La Balsa;La Ceiba;La Victoria;Rancho el Cadillo', 'El Naranjo', 'San Luis Potosí'),
(79317, 'San Martín;Los Charcos de Oriente;El Refugio;Rancho el Carrizal;San Juan del Viejo;Los Cedros;Rancho Nuevo (Florencio Ortega);Rancho Nuevo Paso del Águila;La Isla;La Tinaja;Isabel Ledezma Barrón;Rancho Dos Ríos;Maitinez;Cuicillos;El Molino;La Presita;Paso del Águila (Ismael Rojas);Peña Amarilla;Rancho Buenavista;San Rafael (Ojo de Agua de la Vieja);El Limoncito;El Paso del Águila (Vicente Escobedo);La Palma;Rancho Maitinez;Rancho el Cimarrón', 'El Naranjo', 'San Luis Potosí'),
(79318, 'Chihuahuita;Puerto del Higuerón;Contadero;Rancho la Esperanza;San Isidro;El Ojo Frío;Francisco Aranda;Olla Verde;El Queretano;Gabriel Dimas;Santa Cruz', 'El Naranjo', 'San Luis Potosí'),
(79320, 'Ciudad del Maíz Centro', 'Ciudad del Maíz', 'San Luis Potosí'),
(79323, 'El Senegal;Valle del Maíz;Santo Niño;Las Lomas;Las Margaritas;La Deportiva;Arboledas;Jacarandas', 'Ciudad del Maíz', 'San Luis Potosí'),
(79324, 'Buenos Aires;La Pista;Las Alazanas;Callejón', 'Ciudad del Maíz', 'San Luis Potosí'),
(79325, 'El Orégano;Del Pueblo;La Alameda', 'Ciudad del Maíz', 'San Luis Potosí'),
(79326, 'Pedregal;Derramaderos;Villa de San José', 'Ciudad del Maíz', 'San Luis Potosí'),
(79327, 'San José;Villa Antiguo', 'Ciudad del Maíz', 'San Luis Potosí'),
(79330, 'La Cardona (El Chilarcito);Colonia Álvaro Obregón;El Puerto Santa Gertrudis', 'Ciudad del Maíz', 'San Luis Potosí'),
(79333, 'Colonia Lagunillas;Ejido San José;Los Charcos del Poniente;La Cruz Verde;Las Mesas de Don Luis;El Fuereño;Catalina Navarro Hernández;Rancho las Azucenas;José Ángel Anguiano;María Esther Olvera;Ejido San José (Sotero Alvizu);Guadalupe García;Rancho Dos Hermanas (La Cañada)', 'Ciudad del Maíz', 'San Luis Potosí'),
(79334, 'Aquiles Serdán;Agua Zarca;Milpillas;Puerta Ojo de León;Buenavista;El Porvenir;Los Ávalos;Celestría;Los Pilares (El Encinal);Colonia Carlos Diez Gutiérrez (La Italiana);Jorge Ferretiz;Barbarita;Rancho del Pozo', 'Ciudad del Maíz', 'San Luis Potosí'),
(79335, 'Estación Microondas;Tanque de Jiménez;Rancho Kansan;Rancho Santa Margarita;Aquiles Serdán (Celerino Ortega);Rancho el Setenta y Tres (Miguel Jiménez)', 'Ciudad del Maíz', 'San Luis Potosí'),
(79336, 'Nuevo Centro de Población Ganadero Papagayos;Papagayos (Ejido Papagayos);El Toro;La Chuparrosa;Las Lomas;El Tigrito;El Venadito;Las Joyas', 'Ciudad del Maíz', 'San Luis Potosí'),
(79337, 'La Roncha;Las Gavias;Llanitos;Rancho Nuevo;San Gabriel;Rancho de la Cruz;Carrizal Grande;Potreritos de los Llanos;La Victoria;Miguel Olvera Ramírez', 'Ciudad del Maíz', 'San Luis Potosí'),
(79340, 'El Galán;Las Chinampas;Pedro Antonio de los Santos (Los Huizaches);Sección Setenta y Nueve los Anteojos;San Ignacio (Santiago Ortiz);Estación las Tablas;El Divisadero (La Garra);El Duro;El Jefe;La Loma de Dios;La Majada;Santa Teresa;El Pozo', 'Ciudad del Maíz', 'San Luis Potosí'),
(79343, 'Colonia la Morita;La Noria;Rancho Escondido (Lomas de Chora);Colonia la Libertad;Tanque de los Ángeles (El Venadito);Santa Rita;Tomás Ceballos', 'Ciudad del Maíz', 'San Luis Potosí'),
(79344, 'La Cartuja;Rancho San Tiburcio;El Oasis;Rancho la Palma;El Vergel;La Cuesta (Ejido Ganadero Papagayos);Fermín Ortiz;San Tiburcio;Calzada de San Rafael;El Tomate;Santa Teresa;Humberto Martínez Castillo', 'Ciudad del Maíz', 'San Luis Potosí'),
(79345, 'Palomas', 'Ciudad del Maíz', 'San Luis Potosí'),
(79346, 'San Francisco (La Garifa);Nuevo San Rafael;San Mateo;San Rafael Matriz;La Bonita;Cantarranas (El Charco Blanco);La Encarnación;Rancho Aguilar;San Ignacio;San Luis (Las Pinturas);Santa María', 'Ciudad del Maíz', 'San Luis Potosí'),
(79347, 'Sartenejo;Nuevo Centro de Población Ejidal Plan de San Luis;San Antonio del Toro (Cabeza del Toro);El Custodio', 'Ciudad del Maíz', 'San Luis Potosí'),
(79350, 'San Antonio;San Juan del Llano;La Pendencia;La Providencia;Potrero los Anaya;Piedra Parada;Rancho la Gloria;Colonia Agrícola Magdaleno Cedillo;La Guacamaya (La Lagunita);Rancho San José;Zamachihue;Puerto de Lobos', 'Ciudad del Maíz', 'San Luis Potosí'),
(79353, 'Francia Chica;La Barranca;El Nogal;Campamento SEMARNAT;El Puertecito;Ángel García;Francia Grande;Las Mesas;Rancho los Ávalos;Rancho San Miguel', 'Ciudad del Maíz', 'San Luis Potosí'),
(79354, 'San Juan del Meco;Las Moras;La Manzana (Ampliación Buenavista y Olivo);Las Tortugas (Las Moras);Puerto del Zamandoque;Memela;El Capulín;El Olivo;Buenavista del Olivo;El Mequito;Colonia Agrícola Ollitas de las Vacas', 'Ciudad del Maíz', 'San Luis Potosí'),
(79355, 'Laguna Seca;Rincón Seco;Montebello', 'Ciudad del Maíz', 'San Luis Potosí'),
(79356, 'Agua Nueva del Norte;San Martín;La Morenita;San Rafael Carretera', 'Ciudad del Maíz', 'San Luis Potosí'),
(79357, 'Puerto de San Juan de Dios;El Tepeyac', 'Ciudad del Maíz', 'San Luis Potosí'),
(79360, 'Alaquines', 'Alaquines', 'San Luis Potosí'),
(79363, 'De Guadalupe', 'Alaquines', 'San Luis Potosí'),
(79364, 'San Antonio', 'Alaquines', 'San Luis Potosí'),
(79365, 'De San José', 'Alaquines', 'San Luis Potosí'),
(79366, 'De La Luz', 'Alaquines', 'San Luis Potosí'),
(79370, 'El Salitrillo (Juan Olvera);El Álamo;La Cieneguita;San José de Palmas;Río Abajo', 'Alaquines', 'San Luis Potosí'),
(79373, 'Cerro Grande;El Callejón de la Luz;La Puente;Nogales;Ojo de Agua;La Casa de la Piedra;Puerto del Tigre;Los Palos Prietos;Agua de San Juan (Joya Alegre);San Antonio de las Tortugas', 'Alaquines', 'San Luis Potosí'),
(79374, 'El Sabino;Colonia Indígena (Pascual Osorio Ortega);El Nacimiento de la Peña;El Tejocote;Paso de Mendiolas;Rincón Grande;La Cañada;Las Peñitas;Rancho Nuevo;Morales;Las Puertas Cuatas;Rancho de Pro;La Máscara;Nueva Reforma;Maldonado', 'Alaquines', 'San Luis Potosí'),
(79375, 'Los Pocitos (Los Pozos);Pasito de San Francisco;Agua Nueva;Las Huertas;El Abra;Olla del Durazno (Joya del Durazno);El Quebrantadero;Las Crucitas;Mesas del Durazno;El Llanito;El Pelillo;Palo Hueco;Cañón de Guerrero;El Infiernito;San José del Corito', 'Alaquines', 'San Luis Potosí'),
(79376, 'Huerta de la Redonda;La Sepultura;Las Tuzas;Rancho San Blas;Martínez;Cañaditas;Mesa de San Francisco (Mesa de San José);San Antonio;Crucero del Llano', 'Alaquines', 'San Luis Potosí'),
(79377, 'Tanque el Granadillo', 'Alaquines', 'San Luis Potosí'),
(79380, 'Cárdenas Centro', 'Cárdenas', 'San Luis Potosí'),
(79382, 'Del Carmen;El Calichal Grande;Ferrocarrilera;El Mirador II;Bellavista 2a Sección;Brownsville;El Señor del Amparo', 'Cárdenas', 'San Luis Potosí'),
(79383, 'De La Palma', 'Cárdenas', 'San Luis Potosí'),
(79384, 'Arboledas;Guadalupe;INFONAVIT;Nuevo Venecia;Sector Corito', 'Cárdenas', 'San Luis Potosí'),
(79385, 'La Atajea;Astral;Magisterial;San Isidro Chaparral', 'Cárdenas', 'San Luis Potosí'),
(79386, 'del Rasconcito', 'Cárdenas', 'San Luis Potosí'),
(79387, 'El Mirador;Morelos', 'Cárdenas', 'San Luis Potosí'),
(79390, 'Las Canoas;Las Lomas;Colonia Agrícola el Naranjo;Miramar;El Ranchito;Lagunitas;Naranjo', 'Cárdenas', 'San Luis Potosí'),
(79393, 'La Borreguita;Arroyo del Tabaco;Cárdenas (Olegario Castro);Potrero de las Ánimas;Rancho Avestruces;El Palo Alto;La Pista;El Trompillal;Flavio Contreras;El Aguaje;El Derramadero;El Tulillo;Isabel Gómez;Rancho Moy Báez;Potrero de las Parejas (Ignacio Martínez)', 'Cárdenas', 'San Luis Potosí'),
(79394, 'Pascual Rodríguez;Cañada de Pastores;Higinio Olivo (La Labor);Las Moras;Potrero el Savial;Lobos;Ninguno [Estación de Microondas]', 'Cárdenas', 'San Luis Potosí'),
(79395, 'Los Desmontes;Pozo Número Diez;Unidad de Riego Cárdenas (Jesús de León);Pozo Número Tres;Rancho Espiricueta;Abel Calderón;La Piedad;Agua Zarca;Las Peñitas;Pantano;Rancho Bellavista;La Puerta [Potrero los Desmontes];Rancho los Rivera', 'Cárdenas', 'San Luis Potosí'),
(79396, 'El Duraznillo;Los Tachos;El Alazán;El Charco;La Cinta;Rancho Leal;Epifanio Guzmán;El Vaquero;La Capilla;El Remigio;Cirilo Mendoza Díaz;El Salitrillo;Narciso Linares;Tanque de la Guerra;El Mirador;La Puerta de la Esperanza;Rancho la Brecha', 'Cárdenas', 'San Luis Potosí'),
(79397, 'Bernardo Vargas Gámez;El Mirador (Pozo Número Uno);Bugambilia;La Atarjea (Pozo Número Dos);Potrero de la Tinajilla;Familia Lozano;Anexo la Atarjea;Granja María Dolores;La Noria', 'Cárdenas', 'San Luis Potosí'),
(79400, 'San José Turrubiates;Sáuz', 'Cerritos', 'San Luis Potosí'),
(79401, 'San Nicolás del Bosque', 'Cerritos', 'San Luis Potosí'),
(79406, 'Cerros Blancos', 'Cerritos', 'San Luis Potosí'),
(79407, 'Manzanillas', 'Cerritos', 'San Luis Potosí'),
(79408, 'San Pedro de los Hernandez', 'Cerritos', 'San Luis Potosí'),
(79410, 'El Gavilán', 'Cerritos', 'San Luis Potosí'),
(79413, 'Ojo de Agua', 'Cerritos', 'San Luis Potosí'),
(79420, 'Montaña', 'Cerritos', 'San Luis Potosí'),
(79421, 'Derramaderos;San Diego', 'Cerritos', 'San Luis Potosí'),
(79427, 'Rincón de Turrubiates', 'Cerritos', 'San Luis Potosí'),
(79428, 'Rincón de Banda', 'Cerritos', 'San Luis Potosí'),
(79429, 'Villar', 'Cerritos', 'San Luis Potosí'),
(79430, 'Joya de Luna', 'Cerritos', 'San Luis Potosí'),
(79431, 'El Tepozán', 'Cerritos', 'San Luis Potosí'),
(79432, 'San Isidro', 'Cerritos', 'San Luis Potosí'),
(79433, 'Tepetates', 'Cerritos', 'San Luis Potosí'),
(79434, 'Tanque de Banda', 'Cerritos', 'San Luis Potosí'),
(79435, 'Mezquites Chicos', 'Cerritos', 'San Luis Potosí'),
(79436, 'Labor de San Diego', 'Cerritos', 'San Luis Potosí'),
(79437, 'Peña de Salazar', 'Cerritos', 'San Luis Potosí'),
(79440, 'Cerritos Centro', 'Cerritos', 'San Luis Potosí'),
(79442, 'Nuestra Señora de San Juan;Nueva Satélite;Buenos Aires;Las Palmas;San Juan', 'Cerritos', 'San Luis Potosí'),
(79443, 'San Antonio', 'Cerritos', 'San Luis Potosí'),
(79444, 'Francisco Villa;De Francia;Nuestro Padre Jesús', 'Cerritos', 'San Luis Potosí'),
(79445, 'Guadalupe', 'Cerritos', 'San Luis Potosí'),
(79446, 'Jardines de La Unidad;Los Pinos;Santa Cruz', 'Cerritos', 'San Luis Potosí'),
(79447, 'Aurora;San Francisco', 'Cerritos', 'San Luis Potosí'),
(79450, 'El Granjenal;San José del Matorral;Palo Seco', 'Villa Juárez', 'San Luis Potosí'),
(79460, 'Villa Juárez;Las Palmas;Guadalupe;Las Minas de Guascama;San Rafael;Puerta del Río;Agua del Medio;La Gavia;Santo Domingo;San Isidro', 'Villa Juárez', 'San Luis Potosí'),
(79466, 'Guascama', 'Villa Juárez', 'San Luis Potosí'),
(79467, 'Buena Vista', 'Villa Juárez', 'San Luis Potosí'),
(79470, 'Carrizal', 'Villa Juárez', 'San Luis Potosí'),
(79471, 'San Isidro', 'Villa Juárez', 'San Luis Potosí'),
(79480, 'San Nicolás Tolentino', 'San Nicolás Tolentino', 'San Luis Potosí'),
(79482, 'Barranca de San Joaquín', 'San Nicolás Tolentino', 'San Luis Potosí'),
(79483, 'Cañas', 'San Nicolás Tolentino', 'San Luis Potosí'),
(79484, 'Ojo de Agua;Morenos', 'San Nicolás Tolentino', 'San Luis Potosí'),
(79485, 'San José de Nogalitos', 'San Nicolás Tolentino', 'San Luis Potosí'),
(79486, 'Laguna de Santo Domingo', 'San Nicolás Tolentino', 'San Luis Potosí'),
(79487, 'Potrero de Santa Gertrudis', 'San Nicolás Tolentino', 'San Luis Potosí'),
(79488, 'Ignacio Allende', 'San Nicolás Tolentino', 'San Luis Potosí'),
(79489, 'Las Golondrinas', 'San Nicolás Tolentino', 'San Luis Potosí'),
(79490, 'Santa Catarina', 'San Nicolás Tolentino', 'San Luis Potosí'),
(79491, 'San Martín de Abajo', 'San Nicolás Tolentino', 'San Luis Potosí'),
(79493, 'Fracción Ocampo', 'San Nicolás Tolentino', 'San Luis Potosí'),
(79500, 'El Salitral;Cahuila;Calvario;Abasolo;México;Villa de Reyes Centro;Santuario', 'Villa de Reyes', 'San Luis Potosí'),
(79502, 'Gogorrón;Socavón', 'Villa de Reyes', 'San Luis Potosí'),
(79503, 'El Organito;La Boquilla', 'Villa de Reyes', 'San Luis Potosí'),
(79505, 'El Rosario', 'Villa de Reyes', 'San Luis Potosí'),
(79506, 'Centenario;Alberto Carrera Torres;La Ventilla;Las Rusias', 'Villa de Reyes', 'San Luis Potosí'),
(79507, 'San Miguel;Presa San Agustín', 'Villa de Reyes', 'San Luis Potosí'),
(79508, 'Puerta de San Antonio', 'Villa de Reyes', 'San Luis Potosí'),
(79509, 'El Tejocote', 'Villa de Reyes', 'San Luis Potosí'),
(79510, 'Carranco;Bledos', 'Villa de Reyes', 'San Luis Potosí'),
(79511, 'Saucillo de Bledos', 'Villa de Reyes', 'San Luis Potosí'),
(79512, 'Arroyo Blanco', 'Villa de Reyes', 'San Luis Potosí'),
(79513, 'Cañón de Bledos', 'Villa de Reyes', 'San Luis Potosí'),
(79520, 'Jesús María', 'Villa de Reyes', 'San Luis Potosí'),
(79521, 'Ojo del Gato', 'Villa de Reyes', 'San Luis Potosí'),
(79524, 'Pardo;San Lorenzo', 'Villa de Reyes', 'San Luis Potosí'),
(79525, 'Laguna de San Vicente', 'Villa de Reyes', 'San Luis Potosí'),
(79526, 'Logistik', 'Villa de Reyes', 'San Luis Potosí'),
(79530, 'Emiliano Zapata;Guadiana;Saucillo;Calderón;Rodrigo;Villa de Reyes', 'Villa de Reyes', 'San Luis Potosí'),
(79532, 'Machado;El Verde', 'Villa de Reyes', 'San Luis Potosí'),
(79533, 'Palomas', 'Villa de Reyes', 'San Luis Potosí'),
(79540, 'Zaragoza Centro', 'Zaragoza', 'San Luis Potosí'),
(79543, 'El Conguito;La Barranca;El Pedregal', 'Zaragoza', 'San Luis Potosí'),
(79544, 'La Sauceda', 'Zaragoza', 'San Luis Potosí'),
(79545, 'Perpetuo Socorro;La Calera;La Lagunita', 'Zaragoza', 'San Luis Potosí');
INSERT INTO `postcodes` (`id`, `place`, `city`, `entity`) VALUES
(79546, 'La Calera;La Puerta del Arbolito;El Pame;El Potrero Nuevo;Santo Domingo;La Parada del Zarcido;El Arenal;Plan de San José;Rincón de Santa Eduwiges;Ángel Hernández;El Capulín;Emiliano Zapata (El Tepozán);Ninguno [Trituradora de Mármol];Arroyo Hondo;Autódromo Potosino [Pista de Carreras];Benito Cárdenas;El Cerrito;Esperanza Juárez Rocha;Jondablito;La Alberca (Eudocio de la Cruz Martínez);La Lagunita;San Rafael;Rincón de los Alicoches', 'Zaragoza', 'San Luis Potosí'),
(79547, 'San José de Gómez;La Luz (Rodríguez Gaytán);Las Trojes;Valente Moreno Ponce;Xoconoxtle;Hacienda de la Morena;Tanque Prieto;Los Terreros;Rancho el Pituche;Los Calicantitos (Jorge del Fierro);Independencia (Patol);Corral de Palmas;Derramadero;José Natividad Silva;La Estancia;Paso Colorado;Tanque el Llano;Casas Blancas;Garrochitas;La Morena;Las Ánimas;Magdaleno de la Rosa;Campo de Tiro (Club de Tiro Ferrocarrilero);El Castillo;El Potrero de Rosario;La Tinaja;Ranchito de los Rivera;El Garabatillo;El Llano de Santa Isabel', 'Zaragoza', 'San Luis Potosí'),
(79550, 'Los Dos Cerros;Potrerillo;Puerto del Jacal;Joya Honda;Salitrera;El Carrizal;El Recodo;El Puertecito de las Escobas;La Laguna', 'Zaragoza', 'San Luis Potosí'),
(79553, 'Kilómetro 58;Chula Vista;El Aguacatal;Cerro Cuate;Los Llanitos;Puerto de Badillo;El Tablón;Los Lirios;Rancho Nuevo;La Cardona (Las Aguilillas);Las Galgas', 'Zaragoza', 'San Luis Potosí'),
(79554, 'San Francisco;Altamira;Cañón del Pozo;El Divisadero;Hacienda de San Isidro;La Lagunita;La Virgen;Las Rusias;Los Hoyos;Rincón de la Yerbabuena;Álvarez;El Pinal;Las Aguilillas;La Laja;Quinta Guadalupe;Valle de los Fantasmas;Cerro los Caballos;Los Matías;Agua Blanca;El Milagro;La Colmena;La Sierra;La Ciénaga del Trigo;El Puerto Hondo;La Pendencia;Puerto de la Huerta;Rancho el Sumidero;Bellavista;Las Trojes;Rancho los Manzanos', 'Zaragoza', 'San Luis Potosí'),
(79555, 'Parada de los Martínez;Agua Zarca;Alfredo Alvarado (El Picacho);El Membrillo;La Cieneguilla;Puerto del Ranchito;El Congo;Evaristo Sánchez;La Ordeñita;Los Castillos;Puertecito de la Cal;El Lindero;La Lobera;Estanco del Carmen;El Rodeo;Reyna;La Tableta;Ranchito de Juárez;El Charco;El Cocolistle;El Zapote;Puerto de la Cruz;El Pasito;Fracción Juárez;La Cañada del Pastle;La Labor del Mazo;La Paradita;Rancho los Cascabeles;San José del Salto', 'Zaragoza', 'San Luis Potosí'),
(79556, 'Los Arroyitos;Puerta de las Andanas;El Cascarero;Longoria;Arreates;El Cambalache;La Soledad;Los Pilares;Ramiro Saldaña;Coahuila;Ejido la Enramada;El Polvorín;Texas;El Panal;Hacienda de la Enramada;La Bajadita', 'Zaragoza', 'San Luis Potosí'),
(79557, 'La Mesita (La Vallita);Los Cerritos;Pilar de Guadalupe;Cerro Gordo;El Carmen;El Chilarillo;El Pachol;El Tostadero;Jamay;Las Paredes;Puerto del Taray;La Esperanza;La Lagunita;Nazario Bravo;Rodeo Don Johns Bro;Rancho San Dimas;El Jaralito;El Venadito;Alberca de La Cruz;El Ojo de Agua;La Esperanza (Isidro Ávila);La Presita;Pozo Número 2;Colonia el Pedregal;El Jagüey;Entronque de Zaragoza;Las Borrachas;Rancho San Cristóbal (Palenque)', 'Zaragoza', 'San Luis Potosí'),
(79560, 'Zona Centro;Santiago;Guadalupana;La Trinidad;Loma Bonita;Benito Juárez;Gustavo Díaz Ordaz;Linda Vista;Cuartel Once;San José;El Guanajuatito;María Auxiliadora;Las Cruces;Las Arboledas;San Juan', 'Santa María del Río', 'San Luis Potosí'),
(79562, 'Peregrina de Arriba;San Juan Capistrano;El Toro;Cerro Prieto;Palmarito', 'Santa María del Río', 'San Luis Potosí'),
(79563, 'Llano de Guadalupe;El Pueblito;Ojo Caliente;Enramadas', 'Santa María del Río', 'San Luis Potosí'),
(79564, 'La Barranca', 'Santa María del Río', 'San Luis Potosí'),
(79565, 'Tepozán;El Soyate', 'Santa María del Río', 'San Luis Potosí'),
(79566, 'Cañada de Yánez;Puerto del Fraile', 'Santa María del Río', 'San Luis Potosí'),
(79567, 'Sanchez', 'Santa María del Río', 'San Luis Potosí'),
(79569, 'Labor del Río;El Organito', 'Santa María del Río', 'San Luis Potosí'),
(79570, 'San José Alburquerque', 'Santa María del Río', 'San Luis Potosí'),
(79573, 'Vallecito de La Cruz', 'Santa María del Río', 'San Luis Potosí'),
(79574, 'Cañada de Cacao;Cañada de San Juan', 'Santa María del Río', 'San Luis Potosí'),
(79575, 'Laborcilla;Milpillas', 'Santa María del Río', 'San Luis Potosí'),
(79576, 'El Tigre', 'Santa María del Río', 'San Luis Potosí'),
(79580, 'El Fuerte', 'Santa María del Río', 'San Luis Potosí'),
(79581, 'El Cerrito;La Cardona', 'Santa María del Río', 'San Luis Potosí'),
(79583, 'Yerbabuena 1', 'Santa María del Río', 'San Luis Potosí'),
(79584, 'El Tule;Los Conos', 'Santa María del Río', 'San Luis Potosí'),
(79585, 'Villela', 'Santa María del Río', 'San Luis Potosí'),
(79586, 'Presa de los Dolores', 'Santa María del Río', 'San Luis Potosí'),
(79588, 'Estancia de Atotonilco;Santo Domingo', 'Santa María del Río', 'San Luis Potosí'),
(79589, 'El Carmen', 'Santa María del Río', 'San Luis Potosí'),
(79590, 'Tierranueva Centro', 'Tierra Nueva', 'San Luis Potosí'),
(79592, 'De los Moros;El Original;Los Nogales', 'Tierra Nueva', 'San Luis Potosí'),
(79593, 'El Santuario', 'Tierra Nueva', 'San Luis Potosí'),
(79594, 'La Piedad', 'Tierra Nueva', 'San Luis Potosí'),
(79595, 'Paisanos;Rancho San Gabriel;El Patol;Hacienda Vieja', 'Tierra Nueva', 'San Luis Potosí'),
(79600, 'San José del Tapanco;El Capulín;El Garambullo;La Misión;Las Magdalenas;Los Tres Compadres;Miguel Velázquez Reyna;Rancho Loredo´s;El Huizachal;Javier Hernández;Rancho el Esfuerzo;Valle Florido;Colonia María del Rosario (Puente del Carmen);El Riachuelo (El Caracol);Francisco Alvarado Verde;La Laborcilla;Las Vegas;Salitrera;Palmita;Ampliación Ejido el Jabalí (La Curva);El Salto;Paraíso de Ángeles;Puerta Grande;Anexo el Riachuelo;Hernández [Ladrillera];Palmillas;Bordo Blanco;Nueva Colonia el Florido;Puente Nueva;Plazuela;El Obrajero;Juan Verástegui;La Aldea;La Ardilla;Palomas;Paso de los Herreros (Paso de Guadalupe)', 'Rioverde', 'San Luis Potosí'),
(79603, 'Albino Martínez;Paradero la Tapona;Tecomates;Los Amoniacos;San José de Gallinas;San José de las Flores;La Tapona;Chupaderos;Rancho las Maravillas (Inocencio Martínez);Agua de los Robles;La Lagunita', 'Rioverde', 'San Luis Potosí'),
(79604, 'El Coyote;Fraccionamiento Charco Verde;Joya de Faustino;Las Guayabitas;Los Anteojitos;Rancho los Salitrillos (El Mostrenco);Buenavista;Fraccionamiento Ejido San Marcos;El Higuerón;La Escondida;La Manga;Los Potreritos;El Nacimiento;San Diego;El Capulín [Parque Acuático];El Vergel de David Cruz Arellano;Evaristo Baldera;Herminio Rodríguez;Salitrillo;Arco Grande (Los Arquitos de San Isidro);El Begüeño;La Escondida Segunda Sección;La Huerta Juárez;Las Adjuntas;Carlota Méndez;Huerta las Carmelitas;La Manga;Manantial de la Media Luna [Centro Vacacional];Las Potrancas;San Isidro;Cieneguillas;El Jabalí;La Loma;San Martín;Colonia la Esperanza Dos;El Cerro Colorado;El Ezquite;El Zancudo (Sambalamtram);La Concha;La Pedrera;Miguel Rodríguez;Resumidero;Jesús Díaz (Puente del Carmen);Joya de Luna;La Robluda;La Roca;La Yerbabuena;Los Huesos;Potrero de las Mulas;Pozo San Martín (Gregorio Milán)', 'Rioverde', 'San Luis Potosí'),
(79605, 'La Pared (La Virgen Dos);Rancho Nuevo (Ranchito);Cerro del Carmen;Joya de Tablas (La Providencia);La Peñita;Joyas de San Isidro;Joya del Durazno;La Joya Verde (El Lucero);Las Adjuntas;Las Minitas;Los Banquitos;Joyas de Ventura;Mesa de San Isidro;El Paso del Agua;El Sauz;La Viga;Las Moctezumas;Los Alamitos;Puerto de la Yerbabuena;El Rincón (Mesa de San Isidro)', 'Rioverde', 'San Luis Potosí'),
(79606, 'Los Puertos (Colonia los Puertos);Tanque de San Juan;El Refugio;Cañada Grande;La Manzanilla;San José de Canoas;Agua Zarca (La Pila);San Isidro de Vigas (El Huacal);Paso de San Antonio;Milpitas;Rancho del Puente (Puente Prieto);Santa Efigenia;El Carrizal;El Coyote (El Rincón);La Ermita;El Charco', 'Rioverde', 'San Luis Potosí'),
(79607, 'El Pescadito;El Paso de los Alisos;Puerto Ancho;Las Presitas;Palo Alto;Chupaderos;La Cruz del Alamito;Ojo de Agua;Álamos de los Fierros;Guayabas;Las Albercas;Ojo de Agua Seco;Desparramadas;El Aguacate;Mesa del Salto;Soledad;El Aliso;El Saucito;Las Márgaras;Puerto de Chapalitas;Puerto de la Vaca;El Freno', 'Rioverde', 'San Luis Potosí'),
(79610, 'Río Verde Centro', 'Rioverde', 'San Luis Potosí'),
(79613, 'Gama;Valle Florido;INFONAVIT Los Naranjos;Bugambilias;San Fancisco de Asis;Los Frailes;Quintas El Naranjal;Santa Teresa;San Miguel;La Ilusión;Precursores;Gabriel Martínez', 'Rioverde', 'San Luis Potosí'),
(79614, 'Las Rosas;Santa Teresita;Insurgentes;Los Pinos;Carreón de los Condes;Los Sabinos;Morelos;Villas Alejandra', 'Rioverde', 'San Luis Potosí'),
(79615, 'El Carmen;Ciudad Nueva;Buenos Aires', 'Rioverde', 'San Luis Potosí'),
(79616, 'León Franco;San Francisco;La Huerta;Victoria;Azahares', 'Rioverde', 'San Luis Potosí'),
(79617, 'INFONAVIT Ojo de Agua;La Unión;El Porvenir;Del Valle;San Ángel;Los Sauces', 'Rioverde', 'San Luis Potosí'),
(79618, 'San Rafael;La Piedad;Frontera;San José;Ferrocarrilero;El Golfo;Residencial Centenario;San Isidro;Del Sol', 'Rioverde', 'San Luis Potosí'),
(79619, 'Las Arboledas;Los Naranjos;San Antonio', 'Rioverde', 'San Luis Potosí'),
(79620, 'Isla de San Pablo;Isla de San Pablo III;La Pasadita;Accion Nacional', 'Rioverde', 'San Luis Potosí'),
(79623, 'Pedregal de San Marcos;Santa Fe', 'Rioverde', 'San Luis Potosí'),
(79624, 'Los Ángeles;Cofradía Grande;Santa Julia', 'Rioverde', 'San Luis Potosí'),
(79625, 'La Esperanza 1;Las Palmas;San Marcos;La Esperanza II;La Cantera', 'Rioverde', 'San Luis Potosí'),
(79626, 'Jacarandas;Santa Cecilia;Magisterial Rio Verde;La Morita', 'Rioverde', 'San Luis Potosí'),
(79630, 'Mitres;Rancho el Polvorín;Rancho San Francisco;San Bartolo;El Puerto de los Ángeles (El Venadito);El Venado;Rancho los Llorones', 'Rioverde', 'San Luis Potosí'),
(79633, 'Las Dos Trinidades;Potrero de San Isidro;El Chicayán;Joya el Cardón;La Sábana;Los Corrales', 'Rioverde', 'San Luis Potosí'),
(79634, 'El Aguaje;Diego Ruiz;Rancho Santa Fe', 'Rioverde', 'San Luis Potosí'),
(79635, 'Rancho Santo Domingo;Rancho el Común;Rancho el Vergel;Progreso', 'Rioverde', 'San Luis Potosí'),
(79636, 'Ojo de Agua;Rancho Española;Rancho el Verde;Benito Juárez;La Muralla;Rancho los Reyes;Santa María de las Parras (El Soldado);San Francisco;El Sabinito', 'Rioverde', 'San Luis Potosí'),
(79637, 'Angostura (Los Canelos);Santa Rosa Número Dos', 'Rioverde', 'San Luis Potosí'),
(79640, 'Rancho el Trébol;El Albur;La Providencia;Rancho el Trece;Rancho las Clavadas (Otomite);Pastora;Rancho el Quince;Rancho la Gloria;Rancho Victoria;Platón Lárraga Zamora (El Llano);Las Grullas;Rancho el Diecisiete;Cirio;Rancho San Isidro;Santa Isabel (La Luz);El Palmar (El Rucio);Rancho la Cabaña;Rancho San José de Piedras Negras;Trinidad', 'Rioverde', 'San Luis Potosí'),
(79643, 'La Jabonera;Las Pilas;Joya de Ipazotes;La Salitrera;Cruz de Marín;El Nogalito;Joya de Caballos (Joya de Jesús);Puerto de Martínez;La Perdida;Rancho San Martín (Familia Prado)', 'Rioverde', 'San Luis Potosí'),
(79644, 'Barbechitos (Vicente Moreno Romero);Centro de Readaptación Social [Penitenciaría];Concepción Castillo;Isabel Álvarez;La Esperanza;La Pensión;Las Águilas;Los Tecolotes;Mondragón [Blockera];Rancho la Guadalupana;Rancho la Soledad (La Presa);Rancho las Parras;Rancho los Olivos;Rancho San José;Rancho San José;Santa Rita;Hacienda San Isidro;Juan Olvera;La Carcacha;La Poza Quintareña;La Virgen;Las Gemelas;Manuel Alvarado;Rancho el Gavilán;Rancho la Concepción;Rancho San Juan;Rancho Santa Teresa;Santa Lucía;Bernardino Ibarra Sánchez;Fracción Valle Florido;La Florida;Rancho el Gran Chaparral;Rancho Legaspi;Rancho San Fidel;Miguel Hidalgo;Redención Nacional;Cholotova;Colonia Independencia;El Triángulo;La Cenicienta (Rancho de los Pescados);Los Rosales;Rancho el Milagro;Rancho San Blas (Proto Castillo);Rancho San Gabriel;Santa Cruz;Ildefonso Turrubiartes (La Boquilla);Alfonso Robles;El Sacrificio;La Cajeta;La Cofradía;La Huerta;La Pistola;Potrero de San José (Bonifacio Olvera);Rancho los Laureles;Valle de Guadalupe;Colonia María Asunción del Barrio de los Ángeles;Charco Salado;Los Lagartijos;Rancho el Triunfo;Rancho la Trinidad;Rancho San Isidro;San Fernando;Valle de los Ángeles;Ángel Escobar;Cecilio Martínez Cruz;El Invernadero;Jauja;La Garrapata;Las Águilas;Las Palmas;Potrero de la Cofradía Grande;Potrero del Llano;San Vicente;Aurelio Vázquez;Esteban García Allón;José García;Manuel Pérez;Rancho de la Cruz;Rancho el Papalote;Rancho Guadalupe del Tepeyac;Rancho la Soledad;Rancho los Puertecitos;Rancho San Francisco;Rancho Tierra Blanca;Rancho Tres Hermanos;Sanguijuela', 'Rioverde', 'San Luis Potosí'),
(79645, 'Cerrito Colorado;Puente la Escondida;Paso Real;La Providencia;Santa Isabel;La Escondida;Los Tanques de la Escondida;Buena Vista;San Joaquín de Vigas', 'Rioverde', 'San Luis Potosí'),
(79646, 'Agua del Venado;Arroyo Hondo;Bagres de Abajo;El Abojón (Alameda);El Rincón Verde;El Tigre;Paredes;El Campanario;El Garbanzo;El Saucillito;La Parada;Zapotito;Corral Quemado;El Carrizal;Encadenado;La Empanada (Mezquite Blanco);Las Huertitas;Los Aguacatitos;San Jerónimo;Sierra de la Virgen (El Chorro);El Zapote;Bagres de Arriba (La Estancia);Alameda;La Alegría;La Rosita;Las Adjuntas de Bagres;El Tulillo;El Rodeo;Las Enramaditas;Los Corrales (Nueva Rosita);Arroyo de la Cal;La Minita (Rincón del Pino);Nogal del Clavo;Carrizal de Paredes;El Charco del Coyote;La Jabalina;Las Mangas;Las Mesas;Malpaso;Malpaso Grande;Paredes;La Guadalupe (La Agüita);Sorola;El Puertecito;La Joya;Las Joyas del Chicharrón;Los Alamitos;Puerto de las Tarimas (El Aserradero)', 'Rioverde', 'San Luis Potosí'),
(79647, 'Adjuntas;Vielma;Agua Dulce;El Tule;San Francisco de la Puebla;San Sebastián;Los Baños;San Rafaelito;Tierras Prietas;El Rodeo;La Peña;Santa Rosa', 'Rioverde', 'San Luis Potosí'),
(79650, 'El Manantial;Moras de Frontera;Ciudad Fernández', 'Ciudad Fernández', 'San Luis Potosí'),
(79653, 'San Antonio;Arroyo Hondo;Cruz del Mezquite;Los Pinos;Puestecitos;Democracia II', 'Ciudad Fernández', 'San Luis Potosí'),
(79654, 'Los LLanitos;Prados de Fertimex I;Prados de Fertimex II;Santa María de los LLanitos', 'Ciudad Fernández', 'San Luis Potosí'),
(79655, 'San Martín;Mollinedo;Jardines del Alto;El Altillo;Las Fuentes II;La Mora;Los Molinos;Galeana;El Alto', 'Ciudad Fernández', 'San Luis Potosí'),
(79656, 'La Esperanza;Concordia;El VIiento;Casa Blanca;Mezquital del Alto', 'Ciudad Fernández', 'San Luis Potosí'),
(79657, 'El Mezquital;Prados de Moctezuma;El Paraíso;Los Álamos;Democracia I;Atletas;Santa Cruz;Gama', 'Ciudad Fernández', 'San Luis Potosí'),
(79660, 'Cuarto;Vista Hermosa', 'Ciudad Fernández', 'San Luis Potosí'),
(79663, 'Tercero;El Paseo', 'Ciudad Fernández', 'San Luis Potosí'),
(79664, 'Los Naranjos;Segundo;Fracción El Refugio Centro', 'Ciudad Fernández', 'San Luis Potosí'),
(79665, 'Primero', 'Ciudad Fernández', 'San Luis Potosí'),
(79670, 'Joya de las Peñas;Las Pilas;Paso de San Martín;Colonia Camino Real;La Minita;Puerto las Joyas;Atotonilco;El Mosco;Puerto de Palo Gordo;Las Adjuntas;Mesa del Campanario;El Mimbre;La Tízar;La Ventilla;El Obraje;La Concepción;Morillos', 'Ciudad Fernández', 'San Luis Potosí'),
(79673, 'Rancho Nuevo;San José del Terremoto;El Paraíso;Ojo de Agua de San Juan', 'Ciudad Fernández', 'San Luis Potosí'),
(79674, 'Barrio de la Cruz;Santa Ana;El Carrizal;Mojarras de Arriba;La Banda;El Sermón Santa Ana;La Alameda;El Saucillo', 'Ciudad Fernández', 'San Luis Potosí'),
(79675, 'Rancho San Juan;La Reforma;La Reformita;Las Tres Huérfanas;Mojarras de Abajo;San Isidro;Labor Vieja;La Huerta;Solano;Huerta el Huasteco (Potrero el Huasteco);Las Trojas;La Noria', 'Ciudad Fernández', 'San Luis Potosí'),
(79676, 'Las Auras;Puertas Cuatas;Rancho el Garambullo;Rancho San José;Rancho Xochipilli;San Isidro;Huerta la Gloria;Tomás González;Barrio de Guadalupe;Ejido Ojo de Agua (Pablo Mendoza Torres);El Papalote;La Loma (Las Pitahayas);Los Laureles;Piedras Blancas;Rancho la Virgen;San Miguel;Ojo de Agua de Solano;Piedras Blancas (Álvaro Olguín);Rancho Alegre;Rancho San Luis;Ejido los Llanitos;El Campestre;Huerta Martha Elena;Rancho de los Tirados;Rancho las Sandías;San Pablo;El Salitre;Potrero San Cristóbal;Puestecitos;Rancho la Libertad;La Mina;Rancho el Polocote;Colonia Veinte de Noviembre;José Jasso Villegas;La Encarnación;La Mora;Martín Vasco;Rancho Santa María;Splash [Parque Acuático]', 'Ciudad Fernández', 'San Luis Potosí'),
(79677, 'Marcelino Ramos Castillo;Moctezumas del Tepetate;Monte del Tepetate;Quinta Vista Hermosa;Rancho Hernández Perales;Rancho San Benito;Rancho Santa Amalia;San Onofre;Huerta de Martín Silva;Huerta San Blas;Potrero de Caldera Vieja;Potrero el Tepetate (Cerrito del Melón);Puente Adjuntas (El Tepetate);Colonia la Peñita;Huerta de Benito Martínez;Huerta de Clemente Martínez;Huerta de Ezequiel Govea;Las Lechuzas;Finca la Esperanza (Potrero el Apeloteado);Huerta de Marcelino Hernández;Potrero San Joaquín;Huerta de Juan Alvarado;Huerta de Juan Govea;Huerta de Roberto de la Torre;La Mezclita (Potrero de San Joaquín);Gabriel Martínez Segura;Huerta de Fidencio;Huerta las Rositas;Potrero de Santa Ana;Huerta de Alfredo Martínez;Huerta de Juan Compeán;Huerta José González;Huerta los Pinos;Potrero el Álamo;Potrero el Jaral;Rancho Santa Catarina', 'Ciudad Fernández', 'San Luis Potosí'),
(79680, 'San Ciro de Acosta Centro', 'San Ciro de Acosta', 'San Luis Potosí'),
(79683, 'San Juan;Real San Ciro', 'San Ciro de Acosta', 'San Luis Potosí'),
(79684, 'San José;San Isidro;Benito Juárez;Las Viborillas;Azteca', 'San Ciro de Acosta', 'San Luis Potosí'),
(79685, 'Lindavista;El Porvenir;Guadalupe;De Guadalupe', 'San Ciro de Acosta', 'San Luis Potosí'),
(79686, 'Santiago;San Antonio', 'San Ciro de Acosta', 'San Luis Potosí'),
(79687, 'Del Refugio;San Mateo', 'San Ciro de Acosta', 'San Luis Potosí'),
(79690, 'Potrero del Órgano;La Puebla;Paso de Jesús;Colonia Cuauhtémoc;La Morita;Peña Azul', 'San Ciro de Acosta', 'San Luis Potosí'),
(79693, 'La Almarciguera;La Puerta del Tanque;El Caracol;La Ceja;Nicolás Tolentino;La Trinidad;El Potrero de San Antonio;Ninguno [Estación de Teléfonos];El Órgano', 'San Ciro de Acosta', 'San Luis Potosí'),
(79694, 'El Cañón;Guerrero;El Cerro (San José del Palmito);San Carlos;La Lomita;La Barranca;El Soyotal;Paso de la Hormiga;Cerrito de la Cruz;Palo Blanco;La Puerta de Guerrero;Pachuquita', 'San Ciro de Acosta', 'San Luis Potosí'),
(79695, 'La Tinaja;El Encantado;Capadero;Capulín Grande;El Capulín Chico;Rancho Nuevo;Palo Alto de la Purísima Concepción;El Aguacate;Las Trancas;El Pitahayo (Santa Cruz del Pitayo);El Relámpago;Nuevo San Luis', 'San Ciro de Acosta', 'San Luis Potosí'),
(79696, 'Codornices;Canoítas;La Cañada Santa Gertrudis;El Pinito;El Sótano (Los Sótanos);El Chupadero;El Rejalgar (Ojo de Agua);Joyas del Pino', 'San Ciro de Acosta', 'San Luis Potosí'),
(79697, 'La Cochina;Las Bóvedas;Agua Fría;El Nogalito;El Pinito;La Atarjea;Los Parajes;Santa Teresa;Las Moctezumas;Corral Quemado;Las Pilas;Los Pocitos;El Fuereño;Los Charcos;Palos Clavados;El Barrito;Álamos de San Juan;El Charco del Venado;Charco Largo;La Presa de Santo Domingo;Charco Colorado', 'San Ciro de Acosta', 'San Luis Potosí'),
(79702, 'El Cafetal;Verástegui', 'Tamasopo', 'San Luis Potosí'),
(79703, 'Agua Buena', 'Tamasopo', 'San Luis Potosí'),
(79704, 'Puerto Verde;Laguna de Gómez;Tanque del Borrego', 'Tamasopo', 'San Luis Potosí'),
(79705, 'El Clarín;Santa María Tampalatin;La Palmita', 'Tamasopo', 'San Luis Potosí'),
(79707, 'El Nogalito;El Huizachal;El Carrizo;Tierritas Blancas;La Palma;Rincón de Ramírez;Cuesta Blanca;El Sabinito Quemado;Cañón de La Virgen', 'Tamasopo', 'San Luis Potosí'),
(79708, 'La Gavia;Potrerillos', 'Tamasopo', 'San Luis Potosí'),
(79709, 'Emiliano Zapata (La Boquilla);El Trigo;Veinte de Noviembre', 'Tamasopo', 'San Luis Potosí'),
(79710, 'Tamasopo Centro', 'Tamasopo', 'San Luis Potosí'),
(79712, 'Pedregal', 'Tamasopo', 'San Luis Potosí'),
(79713, 'Pasquines', 'Tamasopo', 'San Luis Potosí'),
(79714, 'Altavista', 'Tamasopo', 'San Luis Potosí'),
(79716, 'La Mora', 'Tamasopo', 'San Luis Potosí'),
(79717, 'El Corozo', 'Tamasopo', 'San Luis Potosí'),
(79720, 'Damián Carmona', 'Tamasopo', 'San Luis Potosí'),
(79721, 'El Chino', 'Tamasopo', 'San Luis Potosí'),
(79722, 'El Aguacate', 'Tamasopo', 'San Luis Potosí'),
(79725, 'San Jerónimo;El Mirador', 'Tamasopo', 'San Luis Potosí'),
(79728, 'San Nicolás de Los Montes', 'Tamasopo', 'San Luis Potosí'),
(79729, 'Agua Buena', 'Tamasopo', 'San Luis Potosí'),
(79730, 'Obrera', 'Tamasopo', 'San Luis Potosí'),
(79731, 'Abras del Corozo', 'Tamasopo', 'San Luis Potosí'),
(79732, 'El Saucillo;El Carpintero', 'Tamasopo', 'San Luis Potosí'),
(79733, 'Tambaca;Rancho Nuevo', 'Tamasopo', 'San Luis Potosí'),
(79740, 'Amoladeras;El Pajarito;Nogales;Rayón;Crucero de Rayón;El Aguacate;Tortugas;Guadalupe', 'Rayón', 'San Luis Potosí'),
(79745, 'Cerrito de La Cruz', 'Rayón', 'San Luis Potosí'),
(79746, 'Pozo Bendito', 'Rayón', 'San Luis Potosí'),
(79747, 'La Luz;Morelos', 'Rayón', 'San Luis Potosí'),
(79748, 'Vaqueros', 'Rayón', 'San Luis Potosí'),
(79750, 'Obregón;Aguacatillos;Las Canoas;Tierras Coloradas', 'Rayón', 'San Luis Potosí'),
(79751, 'Puertecitos', 'Rayón', 'San Luis Potosí'),
(79753, 'Las Guapas', 'Rayón', 'San Luis Potosí'),
(79754, 'Vicente Guerrero;Potrero del Carnero', 'Rayón', 'San Luis Potosí'),
(79755, 'San Francisco;San Felipe de Jesús Gamotes', 'Rayón', 'San Luis Potosí'),
(79760, 'El Choy;Norte;El Zapote;Nueva;La Mora;Aquismon;Loma Colorada', 'Aquismón', 'San Luis Potosí'),
(79764, 'San Rafael', 'Aquismón', 'San Luis Potosí'),
(79766, 'Eureka;Santa Bárbara;Barrio el Chamal;Barrio San José;Barrio San Miguel;Jomté Eureka;Lanim;Lázaro Castillo (La Labor del Lienzo Charro);Manja;Barrio de las Golondrinas;Cuetáb;La Laja;El Zopope;Barrio el Progreso;Barrio la Sagrada Familia;Tamápatz;Alitzé;El Mirador;La Unión de Guadalupe;Linjá;Tahuilatzén;Paxaljá;Tamcuime;Octzén;Tan Tzajib', 'Aquismón', 'San Luis Potosí'),
(79767, 'Múhuatl;El Carrizo;La Esperanza;La Mesa;Los Limones;Los Lirios;Santa Rita;Agua Bendita;Barrio de Jolja;Mina de Belemont;San Martín;San Francisco;El Respaldo;Jagüey Prieto (El Jagüey);Joya de las Vacas;La Peña Blanca;La Soledad;San José Oija;Tampete;Tangojo;Alte Anam (La Banqueta);Cueva del Tiwi (Cueva de la Gavilucha);El Túnel;Jactzén;La Manteca;Puerto del Jonote;Puerto Tampete;San Rafael Tampaxal;Agua Amarga;Agua Nueva;Al Tzabalte;Barrio la Cruz;Cuache;Jol Mom;Joya de Papatla;Sanjuanita;Ulush (El Nacimiento);Tampaxal;Los Hornos;Barrio la Mina;Hoya de la Luz;Joya del Limón (María Gregoria Bautista);San Isidro;Tamcuem;Joya del Limón;La Reforma;La Yerbabuena;Las Ánimas;Los Vidales;Octujub o Campeche', 'Aquismón', 'San Luis Potosí'),
(79770, 'La Cuchilla;La Cueva (El Rezago);La Mora (El Lindero);La Peña;San Rafael Tamápatz;Arroyo Zarco;El Sabino;El Sauz;Puerto de Tantzotzob;Yerbabuena;El Corozo;El Pemoche;Jagüey Cercado;La Reforma;Rancho Alegre (El Cañón);Tansosob;La Cruz de Guadalupe;La Mesa;El Copoy;Los Canelos;Los Charcos;La Paloma;Tanchopol;El Chamal;Tanquizul', 'Aquismón', 'San Luis Potosí'),
(79773, 'Tanchanaco;Puhuitzé;La Brecha (La Brecha de Tantzotzob);Colonia el Mirador;El Aguacate;El Choy;Loma Bonita;Mantezulel;Oxitipa;Rancho los Riachuelos;Tampate;Tanute;Rancho Japazum', 'Aquismón', 'San Luis Potosí'),
(79774, 'El Aguacate;El Corocito;El Sabinal;Oxmolón;La Caldera;El Caracol;El Otate;Loma Bonita (Charco)', 'Aquismón', 'San Luis Potosí'),
(79775, 'El Pastor;Pedro Castillo Sánchez (El Volantín);Rancho el Plan de Limón;Rancho San Jorge;San Francisco de Asís;El Limón;El Maguey;Rancho Nuevo;Santa Elena;Arroyo Grande (El Puente);El Chilaf;El Rosario;La Ilusión;El Coyol;El Progreso;La Laguna;Rancho Nuevo Tamalte;Salsipuedes;Tambaque;Santa Cruz;Tampemoche;Carlos Mayorga;El Bosque;Roberto Morales;Santa Anita;La Garita Tambaque;Los Ciruelos;Rancho las Flores;Zanja Prieta (Los Támez);San Pedro de las Anonas;El Centavo;El Volantín;NCPE Santa Anita;Alborada Primera;El Sacrificio;Marcos Luis Santiago (Santa Anita);San Pablo;Tamalte', 'Aquismón', 'San Luis Potosí'),
(79776, 'La Morena;Rancho la Morena;Tanchachin;Rancho Acuario;El Caporal Uno;El Manzanillo;El Corozo;El Naranjito (Isaías López);Rancho las Mesas (Javier González Ramírez);El Caporal Dos;Guillermo Durán;La Unión Catorce;San José el Viejo;Puente de Dios (Paso Alto);Rancho las Mesas;Las Vegas', 'Aquismón', 'San Luis Potosí'),
(79777, 'Coyotes (Camarones);Rancho Agua de la Mona;Rancho la Labor;Rancho Santa Isabel;Santa Anita Dos;Santa Martha;El Jabalí;El Águila (Rincón del Águila);La Escondida;La Sonadora Uno (Maclovio Medellín);Lorenzo Juárez Bueno;Palo de Arco;Rancho el Afán (La Choyosa);Rancho la Ilusión;Rancho la Joya del Encino;El Vergel;Rancho el Milagro;El Sauz (Saucito Viejo);La Cañada (Los Corrales);Los Otates;Moctezuma;Rancho San Francisco;Arroyo Blanco;Camarones;El Sauz (El Saucito);Gallinas [Estación Hidrométrica];La Hierbabuena (Rancho San Antonio);Los Remedios;Rancho Bertita;La Loma;El Naranjito;La Ceiba (Los Corrales);Puerto de Guaymas;Rancho el Siete Leguas;Rancho la Mina;Rancho María Bonita;El Paraíso;Los Naranjos;Rancho San Jorge', 'Aquismón', 'San Luis Potosí'),
(79780, 'Lagunillas', 'Lagunillas', 'San Luis Potosí'),
(79781, 'Quelitalillo', 'Lagunillas', 'San Luis Potosí'),
(79782, 'Carrizal de San Juan', 'Lagunillas', 'San Luis Potosí'),
(79783, 'Las Norias;Charco de Piedra;San Rafael', 'Lagunillas', 'San Luis Potosí'),
(79784, 'La Línea;La Rodada;Pinihuan', 'Lagunillas', 'San Luis Potosí'),
(79785, 'El Epazote', 'Lagunillas', 'San Luis Potosí'),
(79786, 'El Mirador;Laguna Colorada;El Limón', 'Lagunillas', 'San Luis Potosí'),
(79788, 'Laguna Verde;San Ramón;La Presa', 'Lagunillas', 'San Luis Potosí'),
(79790, 'Viña El Milagro;Santa Catarina Centro', 'Santa Catarina', 'San Luis Potosí'),
(79793, 'El Coco;La Viña del Milagro;Llano de Tanlé;Moisés Olvera Yáñez;Puerta del Salto;Las Joyas;El Puente (Ejido Guayabos);Crucerito de los Limones (Santos Apolinar);El Potrero;La Tapada;Tampaso;San Nicolás de Tampote;San Antonio de los Guayabos;El Ranchito;El Sabinito;La Amapola', 'Santa Catarina', 'San Luis Potosí'),
(79794, 'El Agarroso;El Salitrillo;Tanlacut (Labor Zapata);Los Pocitos;San Juan de Dios;El Pedregoso;Joya del Guayabo;Puertecitos;Anexo Agua Nueva del Norte;El Zorrillo;Plan de Santo Domingo;Plan de Santo Domingo (Los Chávez);Los Duraznos;Tanlacut (Pueblo de Tanlacut);Joya de Palma Real', 'Santa Catarina', 'San Luis Potosí'),
(79795, 'Agua Nueva;Veinte de Agosto;Tanlé;Las Milpitas;Cerro Grande;Paso de Jesés;El Crucero Tanlé Chacuala;Paso de las Paguas;Chacuala;Río Chiquito;Río la Culata;Milpas Viejas;El Huizache;El Potrerito', 'Santa Catarina', 'San Luis Potosí'),
(79796, 'La Cercada;Calabazas (San Francisco del Sauce);La Encantada;Tortugas;Los Cuicillos;San José;La Cuchilla;La Maroma;La Barranca;San José de Arriba;El Carrizalillo;La Parada;Las Tinajas;La Compuerta;Frijolares', 'Santa Catarina', 'San Luis Potosí'),
(79797, 'Lagunitas;Limón de la Peña;Joya del Gavilán;Carrizal Grande;Santa Teresa;Agua Amarga;El Arado;El Coral;El Pino;La Ahorcada;Paso de Botello;Santa María Acapulco;La Ciénaga;La Palmita;San Diego (Pueblo Viejo);Mesa del Junco;Agua Amarga (Las Jaritas);El Mezquital;El Potrero de los Sauceda;Las Lagunitas;Puerto la Cruz;El Huizache (Las Jaritas);El Mandule;La Escondida;Las Jaritas;Palo Rajado;San Pedro;El Sauz;Mesa del Aguacate', 'Santa Catarina', 'San Luis Potosí'),
(79798, 'Ranas;Santa Elena;El Saucillo;Las Moras;Pueblo Viejo;Rancho Nuevo (El Encinal);Anteojos;Caballos', 'Santa Catarina', 'San Luis Potosí'),
(79800, 'La Cuesta;Tzepacab;Las Armas;Tancanhuitz de Santos;Tuzantla;Palmira;Piaxtla 1a Secc;Tamaleton;Cuatlamayan;Cuayo-piaxtla;Xochimilco', 'Tancanhuitz', 'San Luis Potosí'),
(79803, 'Xolol Bethania;Los Carrizos;Crucero de Xolol;La Loma', 'Tancanhuitz', 'San Luis Potosí'),
(79804, 'El Capricho;Mexcala;Xolol Tancoltze Segunda Sección;Tempexquistitla;San José Pequétz Tzén', 'Tancanhuitz', 'San Luis Potosí'),
(79805, 'Crucero Marcelino Zamarrón;Tzac-anam;El Crucero (Crucerito);Antonio Flores;La Garza (Pequetzén de La Garza)', 'Tancanhuitz', 'San Luis Potosí'),
(79806, 'Aldzulup Poytzén;Linares;Santa Isabel', 'Tancanhuitz', 'San Luis Potosí'),
(79807, 'La Ceiba San José Pequétz Tzén', 'Tancanhuitz', 'San Luis Potosí'),
(79810, 'La Labor;Tizuapatz;Tanlajas;Malilija;Tres Cruces', 'Tanlajás', 'San Luis Potosí'),
(79811, 'Tocoymón;La Cebadilla;El May;La Concepción;San José Xilatzen;San Nicolás;Santa Rosa;El Jomte', 'Tanlajás', 'San Luis Potosí'),
(79812, 'Tancolol', 'Tanlajás', 'San Luis Potosí'),
(79813, 'Dhokob;Anexo Quelabitad Calabazas', 'Tanlajás', 'San Luis Potosí'),
(79814, 'La Argentina', 'Tanlajás', 'San Luis Potosí'),
(79815, 'El Pando', 'Tanlajás', 'San Luis Potosí'),
(79819, 'San José del Tinto', 'Tanlajás', 'San Luis Potosí'),
(79820, 'Monte Verde;Benito Juárez;Valle Alto;Independencia;Felipe Enríquez;Altos de San José;Cuayalab;Luis Donaldo Colosio;San Francisco Cuayalab;San Vicente Tancuayalab Centro;Deportiva;Progreso;Prof. Leopoldo Zúñiga;Alto del Refugio;El Mirador;La Granja;20 de Noviembre;La Hormiga', 'San Vicente Tancuayalab', 'San Luis Potosí'),
(79821, 'El Ciruelar', 'San Vicente Tancuayalab', 'San Luis Potosí'),
(79822, 'El Sasub', 'San Vicente Tancuayalab', 'San Luis Potosí'),
(79823, 'Tancuiche;El Álamo;Flores Magón', 'San Vicente Tancuayalab', 'San Luis Potosí'),
(79825, 'Tantojon;San Juan de Las Vegas', 'San Vicente Tancuayalab', 'San Luis Potosí'),
(79826, 'Nuevo Jomté (Nuevo May);Nuevo Jomte (Bolsa II);Tancojol;Francisco Villa;Tazajeras;Nuevo Jomté (Tambolón)', 'San Vicente Tancuayalab', 'San Luis Potosí'),
(79830, 'Tanchahuil;Tocoy;Lejen;Tanjasnec;San Antonio;Santa María', 'San Antonio', 'San Luis Potosí'),
(79833, 'Xolol;Cuéchod', 'San Antonio', 'San Luis Potosí'),
(79834, 'Pokchich;Altzájib;Patnel;San Pedro', 'San Antonio', 'San Luis Potosí'),
(79835, 'Santa Martha', 'San Antonio', 'San Luis Potosí'),
(79836, 'Altamira;El Crucero de Lejem;Pozo Blanco', 'San Antonio', 'San Luis Potosí'),
(79837, 'Tzab it adh', 'San Antonio', 'San Luis Potosí'),
(79840, 'Terraplén;Las Lomas;Unidad;Alto de Las Flores;Tanquian de Escobedo Centro;Fátima;Progreso;La Noria', 'Tanquián de Escobedo', 'San Luis Potosí'),
(79841, 'El Tampicol', 'Tanquián de Escobedo', 'San Luis Potosí'),
(79842, 'La Sagrada Familia', 'Tanquián de Escobedo', 'San Luis Potosí'),
(79843, 'El Basuche', 'Tanquián de Escobedo', 'San Luis Potosí'),
(79849, 'Buenavista', 'Tanquián de Escobedo', 'San Luis Potosí'),
(79850, 'Tampamolon Corona', 'Tampamolón Corona', 'San Luis Potosí'),
(79851, 'Tamarindo Huasteco', 'Tampamolón Corona', 'San Luis Potosí'),
(79852, 'El Carrizal;El Naranjo', 'Tampamolón Corona', 'San Luis Potosí'),
(79853, 'Paxquid', 'Tampamolón Corona', 'San Luis Potosí'),
(79854, 'Tzapuja', 'Tampamolón Corona', 'San Luis Potosí'),
(79856, 'Río Florido;Coaxinquila', 'Tampamolón Corona', 'San Luis Potosí'),
(79859, 'Las Víboras;Tonatico;Chiquinteco', 'Tampamolón Corona', 'San Luis Potosí'),
(79860, 'Coxcatlan;Zocote', 'Coxcatlán', 'San Luis Potosí'),
(79861, 'San Pablo', 'Coxcatlán', 'San Luis Potosí'),
(79863, 'El Sabino', 'Coxcatlán', 'San Luis Potosí'),
(79864, 'Ajuatitla;Moyotla;La Palma;La Palma', 'Coxcatlán', 'San Luis Potosí'),
(79865, 'Tazaquil;Tazaquil Ejido;Suchiaco', 'Coxcatlán', 'San Luis Potosí'),
(79866, 'Tampuchón;Ajacaco', 'Coxcatlán', 'San Luis Potosí'),
(79867, 'Tlaxco;Mahuajco;Ixpatlach', 'Coxcatlán', 'San Luis Potosí'),
(79870, 'Amaxac', 'Coxcatlán', 'San Luis Potosí'),
(79871, 'San Andrés', 'Coxcatlán', 'San Luis Potosí'),
(79874, 'Tlapani', 'Coxcatlán', 'San Luis Potosí'),
(79876, 'Las Mesas', 'Coxcatlán', 'San Luis Potosí'),
(79878, 'Tepotzuapa I Sección;Tepotzuapa II Sección', 'Coxcatlán', 'San Luis Potosí'),
(79879, 'Calmecayo', 'Coxcatlán', 'San Luis Potosí'),
(79880, 'Tandzumad;Tanleab;San José;El Limoncito;Huehuetlán;La Pimienta;Tzineja 1a Sección', 'Huehuetlán', 'San Luis Potosí'),
(79884, 'Tan lejab Segunda Sección', 'Huehuetlán', 'San Luis Potosí'),
(79887, 'La Pedrera', 'Huehuetlán', 'San Luis Potosí'),
(79888, 'Tantocoy Uno', 'Huehuetlán', 'San Luis Potosí'),
(79889, 'Cruz Blanca (Tantocoy Dos)', 'Huehuetlán', 'San Luis Potosí'),
(79890, 'Huichihuayan', 'Huehuetlán', 'San Luis Potosí'),
(79891, 'Chununtzen;Chununtzen II;Chununtzen Comunidad;Tierras Coloradas;Chununtzen Dos Sección Uno;Jilim Tantocoy Tres', 'Huehuetlán', 'San Luis Potosí'),
(79892, 'El Jilim', 'Huehuetlán', 'San Luis Potosí'),
(79893, 'La Escalera', 'Huehuetlán', 'San Luis Potosí'),
(79895, 'El Nacimiento', 'Huehuetlán', 'San Luis Potosí'),
(79900, 'Ahuehueyo;Tlaletla;El Naranjal;Poxtla;Xilitla;Xilosuchico', 'Xilitla', 'San Luis Potosí'),
(79901, 'El Jobo', 'Xilitla', 'San Luis Potosí'),
(79903, 'Los Pocitos;La Conchita;Cruztitla', 'Xilitla', 'San Luis Potosí'),
(79904, 'Itztacapa;Arroyo Seco;Pemoxco;La Loma', 'Xilitla', 'San Luis Potosí'),
(79905, 'Cuartillo Nuevo;San Antonio Xalcuayo 1', 'Xilitla', 'San Luis Potosí'),
(79906, 'Puerto Encinal', 'Xilitla', 'San Luis Potosí'),
(79907, 'Tierra Blanca;Plan de Júarez;San Antonio Xalcuayo 2', 'Xilitla', 'San Luis Potosí'),
(79908, 'Petatillo', 'Xilitla', 'San Luis Potosí'),
(79910, 'Tlamaya', 'Xilitla', 'San Luis Potosí'),
(79913, 'El Cañón', 'Xilitla', 'San Luis Potosí'),
(79915, 'San Pedro Huitzquilico;El Nacimiento', 'Xilitla', 'San Luis Potosí'),
(79916, 'Peña Blanca', 'Xilitla', 'San Luis Potosí'),
(79917, 'Tlacuapa (Temazcal);Ixtacamel Buenos Aires;La Escalera;Las Crucitas;Pitzóatl;La Herradura;Chichimixtitla', 'Xilitla', 'San Luis Potosí'),
(79920, 'Xilitlilla;Amayo de Zaragoza;Ahuacatlan;San Antonio Huitzquilico;Potrerillos;Miramar;Soledad de Zaragoza', 'Xilitla', 'San Luis Potosí'),
(79922, 'Tlamimil', 'Xilitla', 'San Luis Potosí'),
(79923, 'La Silleta', 'Xilitla', 'San Luis Potosí'),
(79924, 'Zacatipa;El Retén', 'Xilitla', 'San Luis Potosí'),
(79927, 'Apetzco;El Túnel;Puerto Tres Cruces (San Antonio Xalcuayo Uno);Cerro Quebrado', 'Xilitla', 'San Luis Potosí'),
(79928, 'Rancho Nuevo', 'Xilitla', 'San Luis Potosí'),
(79930, 'Lomas de Axtla;San Miguel;Villas de Santa María;Villa de Guadalupe;Coamila;Progreso;San Juan;Loma Bonita;La Libertad;Jacarandas;Santa María Dos;Axtla de Terrazas;San Rafael;Jardines de Axtla;La Realidad', 'Axtla de Terrazas', 'San Luis Potosí'),
(79933, 'Arroyo de en Medio;Agua Fría;Chenico;Pomoco;Rancho Huasteco el Pino;Nuevo Ayotoxco;Barrio San José del Rincón;La Libertad (Ejido la Libertad);Cuatecoyo;Escalante;Rancho Viejo;Choteco;Hacienda Tampochocho;La Esmeralda;Tampochocho;Ampliación Cuayo Buenavista;Choteco;El Mirador;La Libertad Segunda Sección;Rancho el Avión;Tempixco (Sihuapilco);El Aquichal;Doña Pilar;El Sacrificio;Fracción el Cerro;Las Flores;Rancho las Huastecas;Rancho Nuevo;Rancho Tres Negro;Zacayuhual;Agua Fría Dos;La Gloria;La Laja', 'Axtla de Terrazas', 'San Luis Potosí'),
(79934, 'La Ceiba (Ezequiel Terrazas);El Cerro;Loma Bonita Choteco;Otlasxuaco;Rancho Axtlán;La Ceiba;Chacuala (Mario Acosta);Comunidad Jalpilla (Jalpilla Viejo);Ostatitla;Santa Cecilia (Tamoss);Chacuala;Tamalacaco;La Noria;Santa Rita;Viejo Ayotoxco;Rancho Coyocala;Ahuacatitla;Juan José;Tepetlaco;Xochititla', 'Axtla de Terrazas', 'San Luis Potosí'),
(79935, 'Jalpilla', 'Axtla de Terrazas', 'San Luis Potosí'),
(79936, 'El Progreso;Michotlayo (Chalco);Comunidad Picholco (Picholco Viejo);Cuixcoatitla (Chalco);Xocoyo (Chalco);Copalo (Chalco);Zojualo (Chalco);Picholco;Las Cuevas;Barrio San Isidro (Tlajumpal);Cuayo (Chalco);Ensenada (Chalco)', 'Axtla de Terrazas', 'San Luis Potosí'),
(79937, 'Chicaxtitla;Arroyo Seco;El Sacrificio;Rancho Tenexcalco;Tenexio;Buenos Aires;La Garita;El Danubio;Santo Tomás;Barrio Santa Fe;Comoca Ahuacatitla;Santa Fe Texacal (Centro Urbano);Joaquín Jonguitud;Barrio el Tamarindo;El Madrigal;El Paraíso;Vista Hermosa;El Encinal;Tenexcalco (La Ceiba);Crucero de Comoca;El Laurel;Texacal', 'Axtla de Terrazas', 'San Luis Potosí'),
(79938, 'Chimalaco;Coatzontitla;Calcahual;Coamízatl;La Ceiba;La Purísima;Mapaxtla;Rancho Nuevo;Coamila;Fracción Ahuehueyo;Cuayo Cerro;Cuatlácatl;La Mora;Xoloco;La Purísima;Barrio el Saucito;Comunidad la Purísima;Matlalapa;El Rincón;Fraccionamiento la Purísima;Mapotla;Papatlayo;Rancho Ahuehueyo;San José;Y Griega Vieja;San Miguel;Y Griega Nueva;Cuayo Buenavista;Tenexcruz', 'Axtla de Terrazas', 'San Luis Potosí'),
(79940, 'Xochicuatla;San Juan;El Hulero;Tampacán;Guadalupe;Tenextitla 2;San Juan;Chiconamel;Miraflores;Huexco;La Cruz', 'Tampacán', 'San Luis Potosí'),
(79941, 'Las Mesas', 'Tampacán', 'San Luis Potosí'),
(79942, 'Los Cues', 'Tampacán', 'San Luis Potosí'),
(79943, 'Xochiayo;Lagunillas', 'Tampacán', 'San Luis Potosí'),
(79944, 'La Soledad', 'Tampacán', 'San Luis Potosí'),
(79945, 'El Ojital;Totomoxtla (La Ceiba)', 'Tampacán', 'San Luis Potosí'),
(79946, 'Chimimexco;Cuayahual;Tenextitla 1', 'Tampacán', 'San Luis Potosí'),
(79948, 'El Refugio', 'Tampacán', 'San Luis Potosí'),
(79950, 'Ocuilzapollo;San Martín Chalchicuautla;Cuartel III;Escuatitla;Cuartel II;Carrizo', 'San Martín Chalchicuautla', 'San Luis Potosí'),
(79951, 'Huayal;El Potrero', 'San Martín Chalchicuautla', 'San Luis Potosí'),
(79952, 'Tepemiche', 'San Martín Chalchicuautla', 'San Luis Potosí'),
(79953, 'Apaxtiantla (Apaxtiantlán);Tepetlayo', 'San Martín Chalchicuautla', 'San Luis Potosí'),
(79954, 'Cerro (Cerro de la Cruz);San José de las Adjuntas;La Cruz;Pemuche (Ejido Nuevo)', 'San Martín Chalchicuautla', 'San Luis Potosí'),
(79955, 'Buenavista (Palmar Alto)', 'San Martín Chalchicuautla', 'San Luis Potosí'),
(79956, 'Barranquillas (Tepetzintla);La Labor', 'San Martín Chalchicuautla', 'San Luis Potosí'),
(79957, 'Lalaxo;Chachatipa;Terrerito;Manchoc;Acayo;Chupaderos Dos;Barrio los Tlacuaches (Cuartel Primero);Totolteo', 'San Martín Chalchicuautla', 'San Luis Potosí'),
(79958, 'La Esperanza;Octlamecayo;Las Mesitas;Llano Grande;Aguamolo;Rancho Nuevo;La Soledad;La Mesa del Toro;Pitagio;El Frijolillo;Tempexquititla', 'San Martín Chalchicuautla', 'San Luis Potosí'),
(79959, 'Zapoyo Domingo', 'San Martín Chalchicuautla', 'San Luis Potosí'),
(79960, 'Del Carmen;El Sol;San José;Xew;Benito Juárez;Los Naranjos;Estrella;Zacatipan;Buenos Aires;INFONAVIT;San Juan Zona Centro;San Rafael;San Miguel;La Cañada;Lindavista;Jardines del Valle;Mirador;Los Tamarindos;Tencazapa y Netzahualcoyotl;Valle Alto;Tamazunchale Centro;Emiliano Zapata Sección I', 'Tamazunchale', 'San Luis Potosí'),
(79962, 'Palictla', 'Tamazunchale', 'San Luis Potosí'),
(79963, 'La Peña;Totectitla Los Ciruelos', 'Tamazunchale', 'San Luis Potosí'),
(79964, 'Ixteamel;Ahuehueyo;Tacial;Cuapacho;Mazatétl', 'Tamazunchale', 'San Luis Potosí'),
(79965, 'Xaltipa;Xomoco', 'Tamazunchale', 'San Luis Potosí'),
(79966, 'El Platanito;Los Amigos;Aguazarca;Huazalingo;Tierra Blanca;Poxtla;Barrio de Guadalupe;Tlacuilola', 'Tamazunchale', 'San Luis Potosí'),
(79967, 'Xilhuazo;El Banco;San Francisco;Xinictle', 'Tamazunchale', 'San Luis Potosí'),
(79970, 'Matlapa Centro;El Paraíso;Los Naranjos', 'Matlapa', 'San Luis Potosí'),
(79973, 'Aguacatitla;Pitzoteyo;San Antonio;Tlajumpal (Barrio San José);La Isla', 'Matlapa', 'San Luis Potosí'),
(79974, 'Terrero Colorado;Chalchocoyo;Otlayo;Tlamaxac;Nexcuayo', 'Matlapa', 'San Luis Potosí'),
(79975, 'Texquitote II;Texquitote 1ro;Xochititla;Tepetzintla', 'Matlapa', 'San Luis Potosí'),
(79976, 'Cuichapa;Atlamaxátl;Barrio de Arriba;Apanco;Tamala', 'Matlapa', 'San Luis Potosí'),
(79977, 'Tlaxco;Pahuayo Primero;Zacayo;La Peñita (La Peña);Tezonquilillo;Coaquentla;Tlacohuaque', 'Matlapa', 'San Luis Potosí'),
(79978, 'Escalanar;Ahuehuello 1ro;Nuevo Tepetzintla;Ahuehueyo Segundo;Cuaxilotitla;Barrio de Enmedio;Chalchitepetl;Tancuilín', 'Matlapa', 'San Luis Potosí'),
(79980, 'La Cuchilla;Cojolapa;La Providencia;La Laguna;Rancho Nuevo;Chapulhuacanito;Tianguispicula;Tepetate;Tezontla', 'Tamazunchale', 'San Luis Potosí'),
(79981, 'Zacatipan', 'Tamazunchale', 'San Luis Potosí'),
(79982, 'Tenexco;Temamatla', 'Tamazunchale', 'San Luis Potosí'),
(79983, 'El Palmito;San Sebastián;Los Cerritos;Tepetzintla', 'Tamazunchale', 'San Luis Potosí'),
(79985, 'El Laurel;Arroyo de Los Patos;Xicotla;Acuapich (Pixteyo)', 'Tamazunchale', 'San Luis Potosí'),
(79986, 'Tecomate Uno', 'Tamazunchale', 'San Luis Potosí'),
(79987, 'Achiquico;Tantoyuquita;San Isidro;El Piñal;Encino Solo', 'Tamazunchale', 'San Luis Potosí'),
(79990, 'Taman;La Cruz (Sector);Netzahualcóyotl;Nuevo México;El Carrizal;Pahuayo;Tlalnepantla', 'Tamazunchale', 'San Luis Potosí'),
(79991, 'Vega Larga;Atlajque;Cuixcuatitla;Mecatlan;Tamacol', 'Tamazunchale', 'San Luis Potosí'),
(79993, 'Enramaditas;Tencaxapa', 'Tamazunchale', 'San Luis Potosí'),
(79994, 'Mecapala;Monte Alegre;Zoquitipa;Payantla;Mecachiquico;Axhumol', 'Tamazunchale', 'San Luis Potosí'),
(79995, 'Santa María Picula;Tezapotla;Zapotitla;Tixcuayuca;Tlalixco', 'Tamazunchale', 'San Luis Potosí'),
(79996, 'Pemucho;Santiago;Coahuica', 'Tamazunchale', 'San Luis Potosí'),
(79997, 'La Fortuna;Pahuayo San Francisco;Choteo;Tetlama;Texopis;Quinta Chilla;Pahuayo San Miguel;Ixtla', 'Tamazunchale', 'San Luis Potosí');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `products`
--

CREATE TABLE IF NOT EXISTS `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_by` int(11) NOT NULL,
  `campaings_id` int(11) NOT NULL,
  `name` text CHARACTER SET latin1 NOT NULL,
  `price` double NOT NULL,
  `description` text CHARACTER SET latin1,
  `features` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_products_1_idx` (`created_by`),
  KEY `fk_products_2_idx` (`campaings_id`),
  KEY `fk_products_3_idx` (`features`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Productos' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `name`) VALUES
(1, 'Administrador'),
(2, 'Jefe de Marketing'),
(3, 'Promotor'),
(4, 'Agente de Ventas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `schools`
--

CREATE TABLE IF NOT EXISTS `schools` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Volcado de datos para la tabla `schools`
--

INSERT INTO `schools` (`id`, `name`) VALUES
(1, 'Ninguna'),
(2, 'Primaria'),
(3, 'Secundaria'),
(4, 'Preparatoria o Bachillerato'),
(5, 'Licenciatura'),
(6, 'Maestria o Doctorado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `status_civil`
--

CREATE TABLE IF NOT EXISTS `status_civil` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `status_civil`
--

INSERT INTO `status_civil` (`id`, `name`) VALUES
(1, 'Soltero'),
(2, 'Unión Libre'),
(3, 'Casado'),
(4, 'Divorciado'),
(5, 'Viudo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `status_social`
--

CREATE TABLE IF NOT EXISTS `status_social` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `status_social`
--

INSERT INTO `status_social` (`id`, `name`) VALUES
(1, 'Baja'),
(2, 'Media'),
(3, 'Alta');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `teams`
--

CREATE TABLE IF NOT EXISTS `teams` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_by` int(11) NOT NULL,
  `name` text NOT NULL,
  `description` text CHARACTER SET latin1,
  `status` text COMMENT 'Objetivo, Activo, Inactivo',
  `date_created` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_teams_1_idx` (`created_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `types_customers`
--

CREATE TABLE IF NOT EXISTS `types_customers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text CHARACTER SET latin1 NOT NULL,
  `description` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `types_customers`
--

INSERT INTO `types_customers` (`id`, `name`, `description`) VALUES
(1, 'A', NULL),
(2, 'B', NULL),
(3, 'C', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text,
  `last_name` text,
  `email` text NOT NULL,
  `password` varchar(45) NOT NULL,
  `gender` varchar(1) CHARACTER SET latin1 NOT NULL,
  `rol` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_users_1_idx` (`rol`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `last_name`, `email`, `password`, `gender`, `rol`) VALUES
(2, 'Alfredo', 'Barrón Rodríguez', 'alfreedobarron@gmail.com', 'afec8e3faf8cc984cf3e0060e73fb945', 'H', 1),
(3, 'Cruz Ulises', 'Larraga Ramirez', 'uliseslarraga@gmail.com', '043f53c3299dbbac1346ccbf1bf4cd90', 'H', 3),
(4, 'Silvia', 'Gómez Hernández', 'silviagomez@gmail.com', 'e5cb7c411f1d9a67f68deff4a954cfbc', 'M', 2),
(5, 'Victor Josue', 'Netro Gonzalez', 'jos_1990_@hotmail.com', 'c4f0f080c3f5992b3a4c03d04ace51a2', 'H', 4);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `campaing_team`
--
ALTER TABLE `campaing_team`
  ADD CONSTRAINT `fk_campaing_team_1` FOREIGN KEY (`campaings_id`) REFERENCES `campaings` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_teams_has_campaings_teams1` FOREIGN KEY (`teams_id`) REFERENCES `teams` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `fk_customers_1` FOREIGN KEY (`job`) REFERENCES `jobs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_customers_2` FOREIGN KEY (`postcode`) REFERENCES `postcodes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_customers_3` FOREIGN KEY (`school`) REFERENCES `schools` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_customers_4` FOREIGN KEY (`type`) REFERENCES `types_customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_customers_5` FOREIGN KEY (`status_civil`) REFERENCES `status_civil` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_customers_6` FOREIGN KEY (`status_social`) REFERENCES `status_social` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `customer_team`
--
ALTER TABLE `customer_team`
  ADD CONSTRAINT `fk_customer_team_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_teams_has_customers_teams1` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `emails`
--
ALTER TABLE `emails`
  ADD CONSTRAINT `fk_emails_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_emails_2` FOREIGN KEY (`campaings_id`) REFERENCES `campaings` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `fk_products_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_products_2` FOREIGN KEY (`campaings_id`) REFERENCES `campaings` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_products_3` FOREIGN KEY (`features`) REFERENCES `features` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `teams`
--
ALTER TABLE `teams`
  ADD CONSTRAINT `fk_teams_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_1` FOREIGN KEY (`rol`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
