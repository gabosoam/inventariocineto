/*
Navicat MySQL Data Transfer

Source Server         : Mysql
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : sicpere0.1

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2017-04-16 21:30:58
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for acta
-- ----------------------------
DROP TABLE IF EXISTS `acta`;
CREATE TABLE `acta` (
  `id_acta` varchar(20) NOT NULL COMMENT 'Clave única de la tabla acta',
  `tipo_acta` varchar(20) NOT NULL COMMENT 'Tipo de la acta',
  `fecha_acta` date NOT NULL COMMENT 'Fecha de realización de la acta',
  `hora_acta` time NOT NULL COMMENT 'Hora de realización de la acta',
  `descripcion_acta` varchar(255) DEFAULT NULL COMMENT 'Descripción de la acta',
  `id_contrato` varchar(20) DEFAULT NULL COMMENT 'Número de contrato ligado al acta',
  `id_usuario` varchar(50) DEFAULT NULL COMMENT 'Nombre de usuario que creó el acta',
  PRIMARY KEY (`id_acta`),
  KEY `fk_contrato` (`id_contrato`),
  KEY `fk_usuario` (`id_usuario`),
  CONSTRAINT `fk_contrato` FOREIGN KEY (`id_contrato`) REFERENCES `contrato` (`id_contrato`),
  CONSTRAINT `fk_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`nombre_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of acta
-- ----------------------------
INSERT INTO `acta` VALUES ('FDO-001', 'De entrega', '2017-04-17', '09:00:00', 'PRUEBA', '1234567', 'gsalazar');

-- ----------------------------
-- Table structure for categoria
-- ----------------------------
DROP TABLE IF EXISTS `categoria`;
CREATE TABLE `categoria` (
  `id_categoria` int(255) NOT NULL AUTO_INCREMENT COMMENT 'Clave primaria de la tabla categoría',
  `nombre_categoria` varchar(50) DEFAULT NULL COMMENT 'Nombre de la categoría de productos',
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of categoria
-- ----------------------------
INSERT INTO `categoria` VALUES ('1', 'OTRO');
INSERT INTO `categoria` VALUES ('15', 'SDH');
INSERT INTO `categoria` VALUES ('16', 'OTR');
INSERT INTO `categoria` VALUES ('17', 'REPST');
INSERT INTO `categoria` VALUES ('18', 'PORT-IP');
INSERT INTO `categoria` VALUES ('19', 'OTRO');
INSERT INTO `categoria` VALUES ('20', 'MATRIX');
INSERT INTO `categoria` VALUES ('21', 'PACE');
INSERT INTO `categoria` VALUES ('22', 'VOIP');
INSERT INTO `categoria` VALUES ('23', 'INTELBRAS');
INSERT INTO `categoria` VALUES ('24', 'CISCO');
INSERT INTO `categoria` VALUES ('25', 'CLIRSEN');
INSERT INTO `categoria` VALUES ('26', 'WI-FI');
INSERT INTO `categoria` VALUES ('27', 'HERR');
INSERT INTO `categoria` VALUES ('28', 'ETIQ');
INSERT INTO `categoria` VALUES ('29', 'SWITCH');
INSERT INTO `categoria` VALUES ('30', 'ENE');
INSERT INTO `categoria` VALUES ('31', 'RESPT');
INSERT INTO `categoria` VALUES ('32', 'PEPST');
INSERT INTO `categoria` VALUES ('33', 'DAM');
INSERT INTO `categoria` VALUES ('34', 'TELEFONO');
INSERT INTO `categoria` VALUES ('35', 'ADSL');
INSERT INTO `categoria` VALUES ('36', 'HEADSET');
INSERT INTO `categoria` VALUES ('37', 'VIOP');
INSERT INTO `categoria` VALUES ('38', 'IN');
INSERT INTO `categoria` VALUES ('39', 'WIFI');
INSERT INTO `categoria` VALUES ('40', 'CSN');
INSERT INTO `categoria` VALUES ('41', 'LNR');
INSERT INTO `categoria` VALUES ('42', 'POE');
INSERT INTO `categoria` VALUES ('43', 'AUDCONF');
INSERT INTO `categoria` VALUES ('44', 'METCAL');
INSERT INTO `categoria` VALUES ('45', 'ENER');
INSERT INTO `categoria` VALUES ('46', 'TRA');
INSERT INTO `categoria` VALUES ('47', 'VOZ');
INSERT INTO `categoria` VALUES ('48', 'OCB');
INSERT INTO `categoria` VALUES ('49', 'FLUKE');

-- ----------------------------
-- Table structure for cliente
-- ----------------------------
DROP TABLE IF EXISTS `cliente`;
CREATE TABLE `cliente` (
  `identificacionCliente` int(20) NOT NULL AUTO_INCREMENT COMMENT 'Clave primaria de la tabla cliente',
  `idPersona` varchar(20) NOT NULL COMMENT 'Número de cédula, pasaporte o carnet de refugiado',
  `usuario` varchar(20) DEFAULT NULL COMMENT 'Nombre de usuario que registro el cliente',
  PRIMARY KEY (`identificacionCliente`),
  KEY `fk_personaCliente` (`idPersona`),
  CONSTRAINT `fk_personaCliente` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`identificacion_persona`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1 COMMENT='Datos personales y de contacto de la persona';

-- ----------------------------
-- Records of cliente
-- ----------------------------
INSERT INTO `cliente` VALUES ('20', '1789654123', null);
INSERT INTO `cliente` VALUES ('25', '1724395536', null);

-- ----------------------------
-- Table structure for contrato
-- ----------------------------
DROP TABLE IF EXISTS `contrato`;
CREATE TABLE `contrato` (
  `id_contrato` varchar(20) NOT NULL COMMENT 'Clave única de la tabla contrato',
  `fecha_inicio_contrato` date NOT NULL COMMENT 'Fecha de inicio del contrato',
  `fecha_fin_contrato` date NOT NULL COMMENT 'Fecha final del contrato',
  `descripcion_contrato` varchar(255) NOT NULL COMMENT 'Observaciones del contrato',
  `id_cliente` int(20) DEFAULT NULL COMMENT 'Clave foránea de la tabla Cliente',
  PRIMARY KEY (`id_contrato`),
  KEY `fk_clienteCon` (`id_cliente`),
  CONSTRAINT `fkIdCliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`identificacionCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of contrato
-- ----------------------------
INSERT INTO `contrato` VALUES ('1234567', '2017-04-01', '2017-04-30', 'PRUEBA CONRATO', '25');
INSERT INTO `contrato` VALUES ('CONTR-005', '2017-01-01', '2017-12-31', 'CONTRATO PRUEBA', '20');
INSERT INTO `contrato` VALUES ('CONTR-0115', '2017-01-01', '2017-01-01', 'PRUEBA CONRATO', '20');
INSERT INTO `contrato` VALUES ('PRUEBA1', '2017-04-14', '2017-04-13', 'PRUEBA CONRATO', '25');

-- ----------------------------
-- Table structure for detalleacta
-- ----------------------------
DROP TABLE IF EXISTS `detalleacta`;
CREATE TABLE `detalleacta` (
  `id_detalleActa` int(255) NOT NULL AUTO_INCREMENT COMMENT 'Clave única de la tabla detalleActa',
  `id_acta` varchar(20) NOT NULL COMMENT 'Clave foránea para la tabla acta',
  `id_producto` int(11) DEFAULT NULL COMMENT 'Clave foránea de la tabla producto',
  PRIMARY KEY (`id_detalleActa`),
  KEY `fk_actaDet` (`id_acta`),
  KEY `id_producto` (`id_producto`),
  CONSTRAINT `fk_actaDet` FOREIGN KEY (`id_acta`) REFERENCES `acta` (`id_acta`),
  CONSTRAINT `id_producto` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of detalleacta
-- ----------------------------

-- ----------------------------
-- Table structure for estadocivil
-- ----------------------------
DROP TABLE IF EXISTS `estadocivil`;
CREATE TABLE `estadocivil` (
  `id_estado_civil` tinyint(255) NOT NULL AUTO_INCREMENT COMMENT 'Clave única de la tabla estado civil',
  `nombre_estado_civil` varchar(255) DEFAULT NULL COMMENT 'Nombre del estado civil',
  PRIMARY KEY (`id_estado_civil`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of estadocivil
-- ----------------------------
INSERT INTO `estadocivil` VALUES ('1', 'SOLTERO(A)');
INSERT INTO `estadocivil` VALUES ('2', 'CASADO(A)');
INSERT INTO `estadocivil` VALUES ('3', 'DIVORCIADO(A)');
INSERT INTO `estadocivil` VALUES ('4', 'VIUDO(A)');
INSERT INTO `estadocivil` VALUES ('5', 'UNIÓN LIBRE');

-- ----------------------------
-- Table structure for evento
-- ----------------------------
DROP TABLE IF EXISTS `evento`;
CREATE TABLE `evento` (
  `id_evento` int(255) NOT NULL AUTO_INCREMENT COMMENT 'Clave única de la tabla evento',
  `tipo_evento` varchar(15) DEFAULT NULL COMMENT 'Tipo del evento',
  `hora_evento` datetime DEFAULT NULL COMMENT 'Hora del evento',
  `nombre_tabla` varchar(255) DEFAULT NULL COMMENT 'Nombre de la tabla afectada',
  `valor_anterior` varchar(255) DEFAULT NULL COMMENT 'Valor afectado(si existe)',
  `valor_nuevo` varchar(255) DEFAULT NULL COMMENT 'Nuevo valor',
  `ip_usuario` varchar(30) DEFAULT NULL COMMENT 'Ip donde se realizó la acción',
  `usuario` varchar(50) DEFAULT NULL COMMENT 'Nombre del usuario que realizó la acción',
  PRIMARY KEY (`id_evento`)
) ENGINE=InnoDB AUTO_INCREMENT=787 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of evento
-- ----------------------------

-- ----------------------------
-- Table structure for genero
-- ----------------------------
DROP TABLE IF EXISTS `genero`;
CREATE TABLE `genero` (
  `id_genero` tinyint(255) NOT NULL AUTO_INCREMENT COMMENT 'Clave única de la tabla género',
  `nombre_genero` varchar(20) NOT NULL COMMENT 'Nombre del género',
  PRIMARY KEY (`id_genero`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of genero
-- ----------------------------
INSERT INTO `genero` VALUES ('1', 'MASCULINO');
INSERT INTO `genero` VALUES ('2', 'FENENINO');
INSERT INTO `genero` VALUES ('3', 'OTRO');

-- ----------------------------
-- Table structure for marca
-- ----------------------------
DROP TABLE IF EXISTS `marca`;
CREATE TABLE `marca` (
  `id_marca` int(255) NOT NULL AUTO_INCREMENT COMMENT 'Clave única de la tabla marca',
  `nombre_marca` varchar(50) DEFAULT NULL COMMENT 'Nombre de la marca',
  PRIMARY KEY (`id_marca`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of marca
-- ----------------------------
INSERT INTO `marca` VALUES ('1', 'OTRO');
INSERT INTO `marca` VALUES ('2', 'VANDAL');
INSERT INTO `marca` VALUES ('3', 'MATRIZ');
INSERT INTO `marca` VALUES ('4', 'INTELBRAS');
INSERT INTO `marca` VALUES ('5', 'PACE');
INSERT INTO `marca` VALUES ('6', 'SEAGATE');

-- ----------------------------
-- Table structure for modelo
-- ----------------------------
DROP TABLE IF EXISTS `modelo`;
CREATE TABLE `modelo` (
  `codigo_modelo` varchar(50) NOT NULL COMMENT 'Código del modelo',
  `nombre_modelo` varchar(50) DEFAULT NULL COMMENT 'Nombre del modelo',
  `id_categoria` int(50) DEFAULT NULL COMMENT 'Clave foránea de la tabla categoría',
  `id_marca` int(50) DEFAULT NULL COMMENT 'Clave foránea de la tabla marca',
  PRIMARY KEY (`codigo_modelo`),
  KEY `fk_marcaMod` (`id_marca`),
  KEY `fk_categoria` (`id_categoria`),
  CONSTRAINT `fk_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`),
  CONSTRAINT `fk_marcaMod` FOREIGN KEY (`id_marca`) REFERENCES `marca` (`id_marca`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of modelo
-- ----------------------------
INSERT INTO `modelo` VALUES ('0.33UF 120V', 'CONDENSADOR 0.33UF 120V', '17', '1');
INSERT INTO `modelo` VALUES ('0606328', 'Terminal VF 2 - 4 16-14 AWG OJO 5.3MM AZUL', '1', '1');
INSERT INTO `modelo` VALUES ('0606339', 'Terminal VF 5.5 - 5 12-10 AWG OJO 5.3MM AMARILLO', '1', '1');
INSERT INTO `modelo` VALUES ('0606341', 'Terminal VF 5.5 - 8 12-10 AWG OJO 8.4MM AMARILLO', '1', '1');
INSERT INTO `modelo` VALUES ('1-0233400-0', 'PATCH CORD FIBRA SC/SC', '1', '1');
INSERT INTO `modelo` VALUES ('1000UF 100V', 'CONDENSADOR 1000UF 100V', '17', '1');
INSERT INTO `modelo` VALUES ('1000UF 10V', 'CONDENSADOR 1000UF 10V', '17', '1');
INSERT INTO `modelo` VALUES ('1000UF 15V', 'CONDENSADOR 1000UF 15V', '17', '1');
INSERT INTO `modelo` VALUES ('1000UF 25V', 'CONDENSADOR 1000UF 25V', '17', '1');
INSERT INTO `modelo` VALUES ('1000UF 40V', 'CONDENSADOR 1000UF 40V', '17', '1');
INSERT INTO `modelo` VALUES ('10038769', 'GUIA DE ONDA TWISTFLEX TF084-BW1 1,2m', '1', '1');
INSERT INTO `modelo` VALUES ('100UF 16V', 'CONDENSADOR 100UF16V', '17', '1');
INSERT INTO `modelo` VALUES ('100UF 200V', 'CONDENSADOR 100UF 200V', '17', '1');
INSERT INTO `modelo` VALUES ('100UF 25V', 'CONDENSADOR 100UF 25V', '17', '1');
INSERT INTO `modelo` VALUES ('100UF 35V', 'CONDENSADOR 100UF 35V', '17', '1');
INSERT INTO `modelo` VALUES ('100UF 40V', 'CONDENSADOR 100UF 40V', '17', '1');
INSERT INTO `modelo` VALUES ('100UF 50V', 'CONDENSADOR 100UF 50V', '17', '1');
INSERT INTO `modelo` VALUES ('100UF 6,3V', 'CONDENSADOR 100UF 6,3V', '17', '1');
INSERT INTO `modelo` VALUES ('100UF 63V', 'CONDENSADOR 100UF 63V', '17', '1');
INSERT INTO `modelo` VALUES ('10NF 630V', 'CONDENSADOR 10NF 630V', '17', '1');
INSERT INTO `modelo` VALUES ('10UF 100V', 'CONDENSADOR 10UF 100V', '17', '1');
INSERT INTO `modelo` VALUES ('10UF 16V', 'CONDENSADOR 10UF 16V', '17', '1');
INSERT INTO `modelo` VALUES ('10UF 200V', 'CONDENSADOR 10UF 200V', '17', '1');
INSERT INTO `modelo` VALUES ('10UF 250V', 'CONDENSADOR 10UF 250V', '17', '1');
INSERT INTO `modelo` VALUES ('10UF 25V', 'CONDENSADOR 10UF 25V', '17', '1');
INSERT INTO `modelo` VALUES ('10UF 35V', 'CONDENSADOR 10UF 35V', '17', '1');
INSERT INTO `modelo` VALUES ('10UF 40V', 'CONDENSADOR 10UF 40V', '17', '1');
INSERT INTO `modelo` VALUES ('10UF 50V', 'CONDENSADOR 10UF 50 V', '17', '1');
INSERT INTO `modelo` VALUES ('10UF 63V', 'CONDENSADOR 10UF 63V', '17', '1');
INSERT INTO `modelo` VALUES ('1100-0232', 'ASSY, TOOL, CLEANING, FIBER', '21', '1');
INSERT INTO `modelo` VALUES ('1100-0233', 'ASSY, TOOL, CLEANING, SPONGE', '21', '1');
INSERT INTO `modelo` VALUES ('1121-0624-P5', 'DRIVE TIP PKG .040 THERMO', '21', '1');
INSERT INTO `modelo` VALUES ('1121-0625-P5', 'DRIVE TIP PKG .030 THERMO', '21', '1');
INSERT INTO `modelo` VALUES ('1121-0626-P5', 'DRIVE TIP PKG .060 THERMO', '21', '1');
INSERT INTO `modelo` VALUES ('1121-0627-P5', 'DRIVE TIP PKG .090 THERMO', '21', '1');
INSERT INTO `modelo` VALUES ('1124-0007-P1', 'CHISEL PACE .063 90 DEG', '21', '1');
INSERT INTO `modelo` VALUES ('1124-0010-P1', 'CHISEL PACE .203', '21', '1');
INSERT INTO `modelo` VALUES ('1124-0013-P1', 'CHISEL PACE .094 30 DEG', '21', '1');
INSERT INTO `modelo` VALUES ('1124-0016-P1', 'CHISEL PACE .047 BENT', '21', '1');
INSERT INTO `modelo` VALUES ('1124-0023-P1', 'CHISEL PACE .125 90 DEG', '21', '1');
INSERT INTO `modelo` VALUES ('1124-0028-P1', 'CHISEL PACE .047 BENT', '21', '1');
INSERT INTO `modelo` VALUES ('1124-0034-P1', 'SIDED PACE .25 SINGLE', '21', '1');
INSERT INTO `modelo` VALUES ('120UF 100V', 'CONDENSADOR 120UF 100V', '17', '1');
INSERT INTO `modelo` VALUES ('121559102A', 'TRANSFORMADOR DE TIMBRE ILA', '17', '1');
INSERT INTO `modelo` VALUES ('1265-0011', 'GLASS CHAMBER', '21', '1');
INSERT INTO `modelo` VALUES ('130-195', '3M 746CERT 746 Tester with Certificate of Calibrat', '1', '1');
INSERT INTO `modelo` VALUES ('1309-0054', 'FLUX SODR TRAP', '21', '1');
INSERT INTO `modelo` VALUES ('1415-PRUEBA', 'PRUEBA 2', '31', '5');
INSERT INTO `modelo` VALUES ('14UH', 'BOBINAS AZO238', '1', '1');
INSERT INTO `modelo` VALUES ('15000UF-63V', 'CONDENSADOR 15000UF-63V', '17', '1');
INSERT INTO `modelo` VALUES ('1500UF 10V', 'CONDENSADOR 1500UF 10V', '17', '1');
INSERT INTO `modelo` VALUES ('15UF 16V', 'CONDENSADOR 15UF 16V', '17', '1');
INSERT INTO `modelo` VALUES ('16-6', 'TERMINAL T 16-6 6AWG 1/4\"', '1', '1');
INSERT INTO `modelo` VALUES ('16-8', 'TERMINAL T 16-8 6AWG 5/16\"', '1', '1');
INSERT INTO `modelo` VALUES ('1730502068', 'SWITCH TP-LINK 8P 10-100 Mbps', '29', '1');
INSERT INTO `modelo` VALUES ('19C1693', 'CONECTOR CHASSIS BNC 50 OHM', '1', '1');
INSERT INTO `modelo` VALUES ('1AB079840007', 'PATCH CORD FC/SPC-FC/SPC 5 METROS', '1', '1');
INSERT INTO `modelo` VALUES ('1AB079840016', 'PATCH CORD FC-FC 29M', '1', '1');
INSERT INTO `modelo` VALUES ('1AB1747700033', 'FILTRO ADSL', '1', '1');
INSERT INTO `modelo` VALUES ('1AF00089AAAA04', 'MODEM V32 BIS 1144MD', '38', '1');
INSERT INTO `modelo` VALUES ('1AF00398AAAA', 'TELEFONO CANAL DE SERVICIO', '46', '1');
INSERT INTO `modelo` VALUES ('1AFO1226ADAA', 'CLASS 2 POWER  SUPPLY 9V/1A DC', '30', '1');
INSERT INTO `modelo` VALUES ('1UF 200V', 'CONDENSADOR 1UF 200V', '17', '1');
INSERT INTO `modelo` VALUES ('2,2UF 63V', 'CONDENSADOR 2,2UF 63V', '17', '1');
INSERT INTO `modelo` VALUES ('2.2UF 250V', 'CONDENSADOR 2.2UF 250V', '17', '1');
INSERT INTO `modelo` VALUES ('2.2UF-900V', 'CONDENSADOR 2.2UF-900V', '17', '1');
INSERT INTO `modelo` VALUES ('20UF 40V', 'CONDENSADOR 20UF 40V', '17', '1');
INSERT INTO `modelo` VALUES ('22-18', 'TERMINAL DE OJO 22-18AWG DIAMETRO 5.3 MM (3/16\")', '1', '1');
INSERT INTO `modelo` VALUES ('2200-050P', 'CONECTOR DB50', '1', '1');
INSERT INTO `modelo` VALUES ('2200UF 100V', 'CONDENSADOR 2200UF 100V', '17', '1');
INSERT INTO `modelo` VALUES ('2200UF 16V', 'CONDENSADOR 2200UF 16V', '17', '1');
INSERT INTO `modelo` VALUES ('2200UF 25V', 'CONDENSADOR 2200UF 25V', '17', '1');
INSERT INTO `modelo` VALUES ('2200UF 50V', '2200UF 50V', '17', '1');
INSERT INTO `modelo` VALUES ('2201-67810-160', 'SOUNDSTATION 2W B', '22', '1');
INSERT INTO `modelo` VALUES ('2201-67880-160', 'SOUNDSTATION 2W E', '22', '1');
INSERT INTO `modelo` VALUES ('220NF 1000V', 'CONDENSADOR 220NF 1000V', '17', '1');
INSERT INTO `modelo` VALUES ('220UF 100V', 'CONDENSADOR 220UF 100V', '17', '1');
INSERT INTO `modelo` VALUES ('220UF 10V', 'CONDENSADOR 220UF 10V', '17', '1');
INSERT INTO `modelo` VALUES ('220UF 16V', 'CONDENSADOR 220UF 16V', '17', '1');
INSERT INTO `modelo` VALUES ('220UF 25V', 'CONDENSADOR 220UF 25V', '17', '1');
INSERT INTO `modelo` VALUES ('220UF 35V', 'CONDENSADOR 220UF 35V', '17', '1');
INSERT INTO `modelo` VALUES ('220UF 50V', 'CONDENSADOR 220UF 50V', '17', '1');
INSERT INTO `modelo` VALUES ('220UF 63V', 'CONDENSADOR 220UF 63V', '17', '1');
INSERT INTO `modelo` VALUES ('2299121', 'CONECTOR WINCHESTER', '1', '1');
INSERT INTO `modelo` VALUES ('22UF 100V', 'CONDENSADOR 22UF 100V', '17', '1');
INSERT INTO `modelo` VALUES ('22UF 160V', 'CONDENSADOR 22UF 160V', '17', '1');
INSERT INTO `modelo` VALUES ('22UF 35V', 'CONDENSADOR 22UF 35V', '17', '1');
INSERT INTO `modelo` VALUES ('22UF 63V', 'CONDENSADOR 22UF 63V', '17', '1');
INSERT INTO `modelo` VALUES ('22UF-16V', 'CONDENSADORES 22UF-16V', '17', '1');
INSERT INTO `modelo` VALUES ('22UH/3A', 'BOBINAS', '1', '1');
INSERT INTO `modelo` VALUES ('2504548T01', 'ADAPTADOR DE BATERIA MOTOROLA PRO5150', '1', '1');
INSERT INTO `modelo` VALUES ('256550', 'CHECK FOR UTP.STP.COAXIAL', '27', '1');
INSERT INTO `modelo` VALUES ('271001', 'MEMORIA 271001', '17', '1');
INSERT INTO `modelo` VALUES ('27128', 'MEMORIA 27128', '17', '1');
INSERT INTO `modelo` VALUES ('27256', 'MEMORIA 27256', '17', '1');
INSERT INTO `modelo` VALUES ('27512', 'MEMORIA 27512', '17', '1');
INSERT INTO `modelo` VALUES ('2N3251', 'TRANSISTOR 2N3251', '17', '1');
INSERT INTO `modelo` VALUES ('2N3439', 'TRANSISTOR 2N3439', '17', '1');
INSERT INTO `modelo` VALUES ('2N3440', 'TRANSISTOR 2N3440', '17', '1');
INSERT INTO `modelo` VALUES ('2N5415', 'TRANSISTOR 2N5415', '17', '1');
INSERT INTO `modelo` VALUES ('2N5416', 'TRANSISTOR 2N5416', '17', '1');
INSERT INTO `modelo` VALUES ('3,3UF 250V', 'CONDENSADOR 3,3UF 250V', '17', '1');
INSERT INTO `modelo` VALUES ('30\'42709\'01', 'MODEL SA100-3430', '30', '1');
INSERT INTO `modelo` VALUES ('3300UF 12V', 'CONDENSADOR 3300UF 12V', '17', '1');
INSERT INTO `modelo` VALUES ('3300UF 35V', 'CONDENSADOR 3300UF 35V', '31', '1');
INSERT INTO `modelo` VALUES ('330UF 10V', 'CONDENSADOR 330UF 10V', '17', '1');
INSERT INTO `modelo` VALUES ('330UF 16V', 'CONDENSADOR 330UF 16V', '17', '1');
INSERT INTO `modelo` VALUES ('330UF 25V', 'CONDENSADOR 330UF 25V', '17', '1');
INSERT INTO `modelo` VALUES ('33461', 'TERMINAL DE OJO AMP 8 1/4\"', '1', '1');
INSERT INTO `modelo` VALUES ('33UF 100V', 'CONDENSADOR 33UF 100V', '17', '1');
INSERT INTO `modelo` VALUES ('33UF 16V', 'CONDENSADOR 33UF 16V', '17', '1');
INSERT INTO `modelo` VALUES ('33UF 250V', 'CONDENSADOR 33UF 250V', '17', '1');
INSERT INTO `modelo` VALUES ('3480405000000010549711', 'CONN BACKSHELL DB15', '1', '1');
INSERT INTO `modelo` VALUES ('3499', 'BOBINA UTP CAT 5E AZUL', '1', '1');
INSERT INTO `modelo` VALUES ('376', 'True-rms AC/DC Clamp Meter', '49', '1');
INSERT INTO `modelo` VALUES ('37602837', 'PCM 1560 PG H CO-16 II', '41', '1');
INSERT INTO `modelo` VALUES ('37606387', 'PCM 1564 PG MM D-BOX', '41', '1');
INSERT INTO `modelo` VALUES ('3872C782', 'PC COMPAQ (OMPC)', '40', '1');
INSERT INTO `modelo` VALUES ('3AF00888AEAA', 'PATCH CORD FC-FC', '1', '1');
INSERT INTO `modelo` VALUES ('3AF00888AFAA', 'PATCH CORD FC-FC', '1', '1');
INSERT INTO `modelo` VALUES ('3HE00028CA 01', 'SFP TRANSCEIVER', '1', '1');
INSERT INTO `modelo` VALUES ('4,7NF 1000V', 'CONDENSADOR 4,7NF 1000V', '17', '1');
INSERT INTO `modelo` VALUES ('4,7UF 100V', 'CONDENSADOR 4,7UF 100V', '17', '1');
INSERT INTO `modelo` VALUES ('4,7UF 16V', 'CONDENSADOR 4,7UF 16V', '17', '1');
INSERT INTO `modelo` VALUES ('4,7UF 25V', 'CONDENSADOR 4,7UF 25V', '17', '1');
INSERT INTO `modelo` VALUES ('4,7UF 40V', 'CONDENSADOR 4,7UF 40V', '17', '1');
INSERT INTO `modelo` VALUES ('4,7UF 63V', 'CONDENSADOR 4,7UF 63V', '17', '1');
INSERT INTO `modelo` VALUES ('4080107', 'PLENO NEGRO-TELÉFONO ALÁMBRICO BÁSICO', '23', '1');
INSERT INTO `modelo` VALUES ('40Uf/2A', 'BOBINAS', '1', '1');
INSERT INTO `modelo` VALUES ('4115000', 'BASE ITC4000 i INTELBRAS', '23', '1');
INSERT INTO `modelo` VALUES ('4116R', 'INTEGRADO 4116R', '17', '1');
INSERT INTO `modelo` VALUES ('4310012', 'TELEFONO EJECUTIVO TE 220', '23', '1');
INSERT INTO `modelo` VALUES ('4320083', 'PABX DIGITAL IMPACTA 16 ESP 2X4', '23', '1');
INSERT INTO `modelo` VALUES ('4340002', 'GATEWAY GSM IP GW280', '22', '1');
INSERT INTO `modelo` VALUES ('4400145', 'PLACA DE EXPANSAO GW280', '22', '1');
INSERT INTO `modelo` VALUES ('4501003', 'PORTERO XPE 1001 PLUS', '23', '1');
INSERT INTO `modelo` VALUES ('4501015', 'PORTERO XPE 1013 PLUS', '23', '1');
INSERT INTO `modelo` VALUES ('4504500', 'LLAVERO RFID MIFARE XID1000', '22', '1');
INSERT INTO `modelo` VALUES ('4505000', 'VIDEO PORTERO IP TVIP1000HF', '22', '1');
INSERT INTO `modelo` VALUES ('4505200', 'CONVERSOR AUT AC/DC 24V 2,5A', '22', '1');
INSERT INTO `modelo` VALUES ('4505300', 'DISTRIBUIDOR DE VIDEO PORTERO IP DVIP1000', '22', '1');
INSERT INTO `modelo` VALUES ('4520010', 'VIDEO PORTERO IV7000 LCD BLANCO-HANDS FREE', '23', '1');
INSERT INTO `modelo` VALUES ('4520800', 'EXTENCION DE AUDIO PARA VIDEO PORTERO IV 7000 EA', '23', '1');
INSERT INTO `modelo` VALUES ('4520801', 'MÓDULO INTERNO PARA VIDEO PORTERO IV 7000 HF IN', '23', '1');
INSERT INTO `modelo` VALUES ('4564004', 'CAMERA DE VIDEO IP BULLET P/SIST SEG VIP S3020', '22', '1');
INSERT INTO `modelo` VALUES ('4564008', 'CAMARA IP VIP S3020 GENERACIÓN 2', '22', '1');
INSERT INTO `modelo` VALUES ('4580017', 'NVD 3000-P', '22', '1');
INSERT INTO `modelo` VALUES ('4580155', 'GRAVADOR DIG. DE IMAGEM NVD 1008', '22', '1');
INSERT INTO `modelo` VALUES ('4700007', 'TELEFONO IP-TIP 100 CON POE', '22', '1');
INSERT INTO `modelo` VALUES ('4700UF 16V', 'CONDENSADOR 4700UF 16V', '17', '1');
INSERT INTO `modelo` VALUES ('470UF 10V', 'CONDENSADOR 470UF 10V', '31', '1');
INSERT INTO `modelo` VALUES ('470UF 12V', 'CONDENSADOR 470UF 12V', '17', '1');
INSERT INTO `modelo` VALUES ('470UF 16V', 'CONDENSADOR 470UF 16V', '17', '1');
INSERT INTO `modelo` VALUES ('470UF 20V', 'CONDENSADOR 470UF 20 V', '17', '1');
INSERT INTO `modelo` VALUES ('470UF 40V', 'CONDENSADOR 470UF 40V', '17', '1');
INSERT INTO `modelo` VALUES ('470UF 63V', 'CONDENSADOR 470UF 63V', '17', '1');
INSERT INTO `modelo` VALUES ('470UF-400V', 'CONDENSADOR 470UF-400V', '17', '1');
INSERT INTO `modelo` VALUES ('4750031', 'ROTEADOR WIRELESS HOTSPOT 300', '26', '1');
INSERT INTO `modelo` VALUES ('47725', 'PATCH CORD OPT.8M 2XFC/SPC.MONOM', '1', '1');
INSERT INTO `modelo` VALUES ('47UF 100V', 'CONDENSADOR 47UF 100V', '32', '1');
INSERT INTO `modelo` VALUES ('47UF 16V', 'CONDENSADOR 47UF 16V', '17', '1');
INSERT INTO `modelo` VALUES ('47UF 25V', 'CONDENSADOR 47UF 25V', '17', '1');
INSERT INTO `modelo` VALUES ('47UF 40V', 'CONDENSADOR 47UF 40V', '17', '1');
INSERT INTO `modelo` VALUES ('47UF 63V', 'CONDENSADOR 47UF 63V', '17', '1');
INSERT INTO `modelo` VALUES ('48F2772', 'CONECTOR CHASSIS TWINAX/TRIAX RCPT', '1', '1');
INSERT INTO `modelo` VALUES ('492014-3', 'PATCH CORD FC/FC 2.95M', '1', '1');
INSERT INTO `modelo` VALUES ('492014-4', 'PIGTAIL C/A SM FC(NG)/FC(NG) 5M', '1', '1');
INSERT INTO `modelo` VALUES ('492014-9', 'PIGTAIL FC/FC 6.92M', '1', '1');
INSERT INTO `modelo` VALUES ('4990083', 'TARJETA 4 INTERNOS/EXTENSIONES ANALOGAS IMPACTA', '23', '1');
INSERT INTO `modelo` VALUES ('4990084', 'TARJETA DOS TRONCALES ANÁLOGAS IMPACTA 16/40/68I', '23', '1');
INSERT INTO `modelo` VALUES ('5617NMA1', 'PATCH CORD MONOMODO DUPLEX FC-ST 3M', '1', '1');
INSERT INTO `modelo` VALUES ('56UH/1.5A', 'BOBINAS', '1', '1');
INSERT INTO `modelo` VALUES ('5K', 'RESISTENCIAS DE PRESICION', '1', '1');
INSERT INTO `modelo` VALUES ('6,8UF 100V', 'CONDENSADOR 6,8UF 100V', '17', '1');
INSERT INTO `modelo` VALUES ('6,8UF 25V', 'CONDENSADOR 6,8UF 25V', '17', '1');
INSERT INTO `modelo` VALUES ('6018-0097', 'KIT, ANGLE BRACKET', '21', '1');
INSERT INTO `modelo` VALUES ('6019-0079', 'TD-100 TIP & TOOL STAND', '21', '1');
INSERT INTO `modelo` VALUES ('6019-0082', 'SX TIP & TOOL STAND', '21', '1');
INSERT INTO `modelo` VALUES ('6092110201', 'CABEZAL KRONE 100 PARES', '1', '1');
INSERT INTO `modelo` VALUES ('662774019680', 'USB VGA KVM CONSOLE EXTENDER OVER CAT5', '1', '1');
INSERT INTO `modelo` VALUES ('680UF 25V', 'CONDENSADOR 680UF 25V', '17', '1');
INSERT INTO `modelo` VALUES ('680UF 6,3V', 'CONDENSADOR 680UF 6,3V', '17', '1');
INSERT INTO `modelo` VALUES ('680UF 63V', 'CONDENSADOR 680UF 63V', '17', '1');
INSERT INTO `modelo` VALUES ('680UF-385V', 'CONDENSADOR 680UF-385V', '17', '1');
INSERT INTO `modelo` VALUES ('68UF 16V', 'CONDENSADOR 68UF 16V', '17', '1');
INSERT INTO `modelo` VALUES ('68UF 6,3V', 'CONDENSADOR 68UF 6,3V', '17', '1');
INSERT INTO `modelo` VALUES ('68UF 63V', 'CONDENSADOR 68UF 63V', '17', '1');
INSERT INTO `modelo` VALUES ('6993-0136', 'KIT, CABLE, MARKER, C-TYPE', '21', '1');
INSERT INTO `modelo` VALUES ('6993-0263', 'TD-100 KIT, INTELL, HEAT', '21', '1');
INSERT INTO `modelo` VALUES ('6993-0266', 'SX-90 KIT, INTELL, HEAT', '21', '1');
INSERT INTO `modelo` VALUES ('7008-0287-01', 'MBT-301 PACE STATION', '21', '1');
INSERT INTO `modelo` VALUES ('72913-01', 'PLANTRONICS SPARE, EAR TIP KIT', '1', '1');
INSERT INTO `modelo` VALUES ('74\'12358\'02 B0', 'ENRUTADOR VPN MULTIFUNCION', '29', '1');
INSERT INTO `modelo` VALUES ('74259', 'INTEGRADO 74259', '17', '1');
INSERT INTO `modelo` VALUES ('74574', 'INTEGRADO 74574', '17', '1');
INSERT INTO `modelo` VALUES ('746320011370', 'CAB - V35MT=', '24', '1');
INSERT INTO `modelo` VALUES ('74HC00', 'INTEGRADO 74HC00', '17', '1');
INSERT INTO `modelo` VALUES ('74HC161', 'INTEGRADO 74HC161', '17', '1');
INSERT INTO `modelo` VALUES ('74HC4316', 'INTEGRADO 74HC4316', '17', '1');
INSERT INTO `modelo` VALUES ('74HC74', 'INTEGRADO 74HC74', '17', '1');
INSERT INTO `modelo` VALUES ('75C188', 'INTEGRADO 75C188', '17', '1');
INSERT INTO `modelo` VALUES ('75C189AN', 'INTEGRADO 75C189AN', '17', '1');
INSERT INTO `modelo` VALUES ('7805', 'TRANSISTOR 7805CV', '17', '1');
INSERT INTO `modelo` VALUES ('7808', 'TRANSISTOR L7808CV', '17', '1');
INSERT INTO `modelo` VALUES ('7896637614702', 'TELEFONO ALAMBRICO ANALOGICO INTELBRAS', '1', '1');
INSERT INTO `modelo` VALUES ('7896637643542', 'CAMARA IP VIP S4100', '23', '1');
INSERT INTO `modelo` VALUES ('7896637644969', 'CAMARA IP VIP S4120', '23', '1');
INSERT INTO `modelo` VALUES ('7896637645928', 'TELEFONO VOIP TS60 IPR', '23', '1');
INSERT INTO `modelo` VALUES ('7896637658058', 'CENTRAL IP DECT T60 IP', '23', '1');
INSERT INTO `modelo` VALUES ('7896637658102', 'TELEFONO SEM FIO T60 IP', '23', '1');
INSERT INTO `modelo` VALUES ('7906', 'TRANSISTOR 7906CT', '17', '1');
INSERT INTO `modelo` VALUES ('7912', 'TRANSISTOR L7912CV', '17', '1');
INSERT INTO `modelo` VALUES ('800-001-0316', 'POWER OVER ETHERNET KITS', '1', '1');
INSERT INTO `modelo` VALUES ('81083-01', 'SPARE HEADSET CT14', '1', '1');
INSERT INTO `modelo` VALUES ('81086-01', 'PLANTRONICS SPARE, CLIP BELT CT14', '1', '1');
INSERT INTO `modelo` VALUES ('81087-01', 'SPARE BATTERY PACK CT14', '1', '1');
INSERT INTO `modelo` VALUES ('83648-03', 'PLANTRONICS POWER SUPPLY 9VDC 500 mA', '1', '1');
INSERT INTO `modelo` VALUES ('84693-11', 'PLANTRONICS CS540/HL10', '1', '1');
INSERT INTO `modelo` VALUES ('8904133002516', 'PPM4', '22', '1');
INSERT INTO `modelo` VALUES ('8904133003056', 'TELEFONO EON48S BLACK', '22', '1');
INSERT INTO `modelo` VALUES ('8904133003070', 'TELEFONO EON48P BLACK', '22', '1');
INSERT INTO `modelo` VALUES ('8904133003896', 'Matrix GSM Fixed Cellular Terminal', '1', '1');
INSERT INTO `modelo` VALUES ('8904133004152', 'ETERNITY PE CARD VMS16', '22', '1');
INSERT INTO `modelo` VALUES ('8904133004183', 'ETERNITY PE CARD CO4+SLT4', '22', '1');
INSERT INTO `modelo` VALUES ('8904133004244', 'ETERNITY PE6SP US', '22', '1');
INSERT INTO `modelo` VALUES ('8904133004602', 'ETERNITY PE CARD GSM2', '22', '1');
INSERT INTO `modelo` VALUES ('8904133004664', 'ETERNITY PE CARD VOIP16', '22', '1');
INSERT INTO `modelo` VALUES ('8904133006705', 'ETERNITY NE6 US', '22', '1');
INSERT INTO `modelo` VALUES ('8904133011365', 'NAVAN CNX226 2G2 US', '22', '1');
INSERT INTO `modelo` VALUES ('8904133013611', 'SATATYA CIBR13FL40CW & ACCESORIES', '22', '1');
INSERT INTO `modelo` VALUES ('8904133013628', 'SATATYA CIDR13FL40CW & ACCESORIES', '22', '1');
INSERT INTO `modelo` VALUES ('8904133013987', 'SATATYA NVR8S IN', '22', '1');
INSERT INTO `modelo` VALUES ('8904133014373', 'COSEC COMBO FAX US', '22', '1');
INSERT INTO `modelo` VALUES ('8VFO', 'PATCH CORD FC/PC-FC/PC 1550nm PIRELLI 20 METROS', '1', '1');
INSERT INTO `modelo` VALUES ('9/125', 'PATCH CORD FC/PC-FC/PC DUPLEX 3METROS', '1', '1');
INSERT INTO `modelo` VALUES ('9137430E', 'HELIOS CARD READER', '18', '1');
INSERT INTO `modelo` VALUES ('962-00010-02 B', 'IP TELEPHONE GRANDSTREAM GXP-1200 ENTRY LEVEL', '22', '1');
INSERT INTO `modelo` VALUES ('963-01001-42 B', 'VIDEO PHONE GRANDSTREAM BLACK (GXV300)', '22', '1');
INSERT INTO `modelo` VALUES ('966-00004-13B', 'GATEWAY 4 FXS PORT GRAND STREAM VOIP ANALOG (4004)', '22', '1');
INSERT INTO `modelo` VALUES ('966-00008-02C', 'GW 24 FXS PORT GRANDSTREAM VOIP ANALOG (GXW4024)', '22', '1');
INSERT INTO `modelo` VALUES ('967-00009-04', 'IP CAMERA GRANDSTREAM', '1', '1');
INSERT INTO `modelo` VALUES ('967-00052-10A002', 'CÁMARA GRANDSTREAM GXV3610_FHD', '22', '1');
INSERT INTO `modelo` VALUES ('97B2386', 'CONECTOR RF/COAXIAL, BNC PLUG, STR, 50 ohm, CRIMP', '1', '1');
INSERT INTO `modelo` VALUES ('97K8839', 'BOBINA DE CABLE RG58CU (50 Mts)', '1', '1');
INSERT INTO `modelo` VALUES ('98301747.7', 'PATCH CORD FC-FC', '1', '1');
INSERT INTO `modelo` VALUES ('9UF 125V', 'CONDENSADOR 9UF 125V', '17', '1');
INSERT INTO `modelo` VALUES ('9UF 20V', 'CONDENSADOR 9UF 20 V', '17', '1');
INSERT INTO `modelo` VALUES ('AA-091A', 'OEM AC ADAPTOR', '1', '1');
INSERT INTO `modelo` VALUES ('AAA1820028B05', 'CPU-30BE/16', '33', '1');
INSERT INTO `modelo` VALUES ('AAA1820062AA02', '1 GB SEAGATE HARD DISK', '15', '1');
INSERT INTO `modelo` VALUES ('ADU120150', 'AC/AC PLUG IN TRANSFORMER', '18', '1');
INSERT INTO `modelo` VALUES ('AG-188N', 'ATA ONE LINE FXs', '22', '1');
INSERT INTO `modelo` VALUES ('AM7910PC', 'INTEGRADO AM7910PC', '17', '1');
INSERT INTO `modelo` VALUES ('APOE02-WM', 'PASSIVE POWER OVER ETHERNET', '1', '1');
INSERT INTO `modelo` VALUES ('AT28HC256', 'INTEGRADO AT28HC256', '17', '1');
INSERT INTO `modelo` VALUES ('AT29C040A', 'INTEGRADO AT29C040A', '17', '1');
INSERT INTO `modelo` VALUES ('ATLSP-02598-AAAA', 'TRANSFORMADOR 220VAC-5VDC', '1', '1');
INSERT INTO `modelo` VALUES ('ATLSP04119AAAA', 'MOCHILA ADAPTADORA', '1', '1');
INSERT INTO `modelo` VALUES ('AURICULAR', 'AURICULAR PUEST', '1', '1');
INSERT INTO `modelo` VALUES ('B00MYNX0ZI', 'BRUSHLESS DC FAN 12V 0.08A', '1', '1');
INSERT INTO `modelo` VALUES ('BC287', 'TRNASISTOR BC287', '17', '1');
INSERT INTO `modelo` VALUES ('BD201', 'TRANSISTOR BD201', '17', '1');
INSERT INTO `modelo` VALUES ('BOBINAS IEC IER', 'BOBINAS DE ACOPLAMIENTO', '17', '1');
INSERT INTO `modelo` VALUES ('C01', 'C01 CALL CENTER PHONE', '22', '1');
INSERT INTO `modelo` VALUES ('C10', 'EXPANSIÓN MODULE', '22', '1');
INSERT INTO `modelo` VALUES ('C2007B', 'PASSIVE PoE KIT BLACK', '1', '1');
INSERT INTO `modelo` VALUES ('C56HP', 'C56HP PHONE', '22', '1');
INSERT INTO `modelo` VALUES ('C56P', 'C56P PHONE', '22', '1');
INSERT INTO `modelo` VALUES ('C58P', 'FANVIL IP PHONE', '22', '1');
INSERT INTO `modelo` VALUES ('C62P', 'FANVIL IP PHONE C62P', '22', '1');
INSERT INTO `modelo` VALUES ('C66P', 'C66IP PHONE', '22', '1');
INSERT INTO `modelo` VALUES ('C88E000208', 'TAPAS CONECTOR DB50', '1', '1');
INSERT INTO `modelo` VALUES ('CABLE M26X', 'CABLE FXS M26X', '1', '1');
INSERT INTO `modelo` VALUES ('CAMSX', 'CAMARA PORTEROS SURIX', '22', '1');
INSERT INTO `modelo` VALUES ('CASCOS', 'CASCOS PARA INSTALACIONES', '1', '1');
INSERT INTO `modelo` VALUES ('CC364A', 'LASERJET', '1', '1');
INSERT INTO `modelo` VALUES ('CCR2-5/16', 'TERMINAL DE DOBLE OJO 2 AWG -5/16', '1', '1');
INSERT INTO `modelo` VALUES ('CDV-3VM800', 'IP CAMERA POE 2M 1080P HD VANDAL DOME CMOS FINE', '22', '1');
INSERT INTO `modelo` VALUES ('CHALECOS', 'CHALECOS REFLECTORES', '1', '1');
INSERT INTO `modelo` VALUES ('COD-PRUEBA12', 'NOMBRE_PRUEBA', '17', '1');
INSERT INTO `modelo` VALUES ('CODEJEMPLO', 'EJEMPLO', '1', '1');
INSERT INTO `modelo` VALUES ('codigo-prueba2', 'MODELO PRUEBA2', '17', '1');
INSERT INTO `modelo` VALUES ('CODIGOPRUEBA', 'SADASD', '36', '3');
INSERT INTO `modelo` VALUES ('CODIGOPRUEBA2', 'PRUEBA2', '22', '3');
INSERT INTO `modelo` VALUES ('CODIGOPRUEBA4', 'PRUEBA3', '21', '3');
INSERT INTO `modelo` VALUES ('CODIGOPRUEBA5', 'MODELOPRUEBA', '1', '4');
INSERT INTO `modelo` VALUES ('CT14', 'CT14 CORDLESS HEADSET PHONE', '34', '1');
INSERT INTO `modelo` VALUES ('D43256BCZ', 'INTEGRADO D43256BCZ', '17', '1');
INSERT INTO `modelo` VALUES ('D800', 'FANVIL VIDEO IP PHONE', '22', '1');
INSERT INTO `modelo` VALUES ('D900', 'FANVIL VIDEO PHONE', '22', '1');
INSERT INTO `modelo` VALUES ('DT1E8', 'PATCHCORD FIBRA OPTICA', '1', '1');
INSERT INTO `modelo` VALUES ('DXN5011S', 'CAJA DEXSON TOMA/MULTIPLE INSTALACION', '1', '1');
INSERT INTO `modelo` VALUES ('E209234', 'CABLE FIBRA OPTICA', '1', '1');
INSERT INTO `modelo` VALUES ('EF7910JLD', 'INTEGRADO EF7910JLD', '17', '1');
INSERT INTO `modelo` VALUES ('EPD-5818', 'POE EPD-5818 ENGENIUS', '42', '1');
INSERT INTO `modelo` VALUES ('F52054-000', 'PATCH CORD LC-FC 3M ( TYCO Electronic )', '1', '1');
INSERT INTO `modelo` VALUES ('GPSU15B-8', 'SWITCHING POWER SPPLY', '45', '1');
INSERT INTO `modelo` VALUES ('HD63C09EP', 'INTEGRADO HD63C09EP', '17', '1');
INSERT INTO `modelo` VALUES ('HOLA2', 'ASASDS', '17', '1');
INSERT INTO `modelo` VALUES ('hola3', '212', '17', '1');
INSERT INTO `modelo` VALUES ('HOLASOCKET', 'HOLASOCKET', '17', '1');
INSERT INTO `modelo` VALUES ('HSB 50', 'Telefone Headset ( con diadema-un auricular )', '1', '1');
INSERT INTO `modelo` VALUES ('IDWHOM1P', 'WALLPLUG ENCLOSURE FOR OM1P', '26', '1');
INSERT INTO `modelo` VALUES ('IES1008AA', '10/100 Fast Ethernet Switch', '1', '1');
INSERT INTO `modelo` VALUES ('IL03DBRL50DBSCST', 'PATCH CORD FIBRA SC-ST DUPLEX SINGLE-MODE', '1', '1');
INSERT INTO `modelo` VALUES ('IP GATEWAY', 'ATA', '22', '1');
INSERT INTO `modelo` VALUES ('IP-AX-M', 'SURIX 1 BOTON EMBUTIR', '18', '1');
INSERT INTO `modelo` VALUES ('IP-AX-T', 'SURIX 1 BOTON EXTERIOR', '18', '1');
INSERT INTO `modelo` VALUES ('IP-AXTT-M', 'SURIX C/TECLADO EMBUTIR', '18', '1');
INSERT INTO `modelo` VALUES ('IP-AXTT-T', 'SURIX EXTERIOR C/TECLADO', '18', '1');
INSERT INTO `modelo` VALUES ('IP-Ti-T', 'SURIX TITANIUM 1 BOTON', '22', '1');
INSERT INTO `modelo` VALUES ('IPAX1', 'PULSADORES DIRECTOS SURIX', '1', '1');
INSERT INTO `modelo` VALUES ('K14', 'BIOMETRICO ZKTECO', '1', '1');
INSERT INTO `modelo` VALUES ('K9852RF', 'TECLADO MOUSE INALAMBRICO', '1', '1');
INSERT INTO `modelo` VALUES ('KCS10', 'CABEZAL BELCONN', '1', '1');
INSERT INTO `modelo` VALUES ('KCS10N', 'REGLETA BELCONN', '1', '1');
INSERT INTO `modelo` VALUES ('KX-TS500LXB', 'TELEFONO ANALOGICO PANASONIC', '1', '1');
INSERT INTO `modelo` VALUES ('KXTY', 'TELEFONO PANAPHONE', '47', '1');
INSERT INTO `modelo` VALUES ('LL/M', 'LLAVEROS MAGNETICOS', '18', '1');
INSERT INTO `modelo` VALUES ('LM333', 'TRANSISTOR LM333T', '17', '1');
INSERT INTO `modelo` VALUES ('LR79574', 'CHASE RESEARCH', '1', '1');
INSERT INTO `modelo` VALUES ('M-545', 'MOLDE PARA SOLDE', '1', '1');
INSERT INTO `modelo` VALUES ('M21-500-499-TB', 'CINTA BRADY', '28', '1');
INSERT INTO `modelo` VALUES ('M21-750-499', 'CINTA BRADY', '28', '1');
INSERT INTO `modelo` VALUES ('M32', 'CRIMPING TOOL FOR F/BNC/RCA', '27', '1');
INSERT INTO `modelo` VALUES ('M5M5256', 'INTEGRADO M5M5256', '17', '1');
INSERT INTO `modelo` VALUES ('MC14002BCLD', 'INTEGRADO MC14002BCLD', '17', '1');
INSERT INTO `modelo` VALUES ('MC1489P', 'INTEGRADO MC1489P', '17', '1');
INSERT INTO `modelo` VALUES ('MC54HC273AJ', 'INTEGRADO MC54HC273AJ', '17', '1');
INSERT INTO `modelo` VALUES ('MC68901P', 'INTEGRADO MC68901P', '17', '1');
INSERT INTO `modelo` VALUES ('MD12W', 'RF-ID READER WIEGAND', '1', '1');
INSERT INTO `modelo` VALUES ('MHC3000', 'UPS FIRMESA 3000', '30', '1');
INSERT INTO `modelo` VALUES ('MP-5609-60', 'CABLE TWINAX / TRIAX MACHO - TWINAX/ TRIAX  MACHO', '25', '1');
INSERT INTO `modelo` VALUES ('MQ01ABD100', 'DISK DRIVE TOSHIBA 1TB', '1', '1');
INSERT INTO `modelo` VALUES ('MR500', 'MR500 DUAL BAND 802.11N MESH ROUTER', '39', '1');
INSERT INTO `modelo` VALUES ('MRD-308DS', 'TELEPHONE HEADSET - DOS AURICULARES MAS MICROFONO', '36', '1');
INSERT INTO `modelo` VALUES ('MRD-308S', 'TELEPHONE HEADSET - UN AURICULAR MAS MICROFONO', '36', '1');
INSERT INTO `modelo` VALUES ('MRD-MT001', 'ALMOHADILLAS PARA MICROFONO', '1', '1');
INSERT INTO `modelo` VALUES ('MRD-QD001', 'HEADSET CONNECTING CORD - PC 3.5 MM DOBLE', '36', '1');
INSERT INTO `modelo` VALUES ('MRD-QD002', 'HEADSET CONNECTING CORD - CONECTOR RJ9', '36', '1');
INSERT INTO `modelo` VALUES ('MRD-QD002( A )', 'HEADSET CONNECTING CORD - CONECTOR RJ9', '36', '1');
INSERT INTO `modelo` VALUES ('MRD-QD002( C )', 'HEADSET CONNECTING CORD - CONECTOR RJ9', '36', '1');
INSERT INTO `modelo` VALUES ('MRD-QD006', 'Y TRAINING CORD/ Y CABLE WITH QD PLUG', '36', '1');
INSERT INTO `modelo` VALUES ('MRD-QD008', 'TRAINING CABLE (Y CABLE) WITH QD PLUG AND VOLUMEN', '36', '1');
INSERT INTO `modelo` VALUES ('MRD-QD011', 'HEADSET CONNECTING CORD - PLUG 2.5 mm', '36', '1');
INSERT INTO `modelo` VALUES ('MRD-QD012', 'HEADSET CONNECTING CORD - PLUG 3.5 mm', '36', '1');
INSERT INTO `modelo` VALUES ('MRD-RT004', 'ESPONJAS PARA AURICULAR', '36', '1');
INSERT INTO `modelo` VALUES ('MRD-USB', 'HEADSET CONNECTING CORD - CONECTOR USB', '36', '1');
INSERT INTO `modelo` VALUES ('MS2EP-EP', 'PATCH CORD ST/ST 8FT 2.5 M', '1', '1');
INSERT INTO `modelo` VALUES ('NPC-6203', 'PACHT CORD 3FT CAT 6 AZUL', '1', '1');
INSERT INTO `modelo` VALUES ('NPD-5818', 'POE NPD-5818', '42', '1');
INSERT INTO `modelo` VALUES ('NSC810AN-3I', 'INTEGRADO NSC810AN-3I', '17', '1');
INSERT INTO `modelo` VALUES ('OCJ-T-F1-05MASCA-F1', 'PATCH CORD FC/PC-FC/PC', '1', '1');
INSERT INTO `modelo` VALUES ('OCJ-T-F1-OSMASCA-F1', 'PATCH CORD MONOMODO FC/FC 2.4mm 5M', '1', '1');
INSERT INTO `modelo` VALUES ('OCP-T-F1-03MASCA-XX', 'PIGTAIL FIBRA FC', '1', '1');
INSERT INTO `modelo` VALUES ('OCP-U-F0-03MASEN-XX', 'PIGTAIL FC', '1', '1');
INSERT INTO `modelo` VALUES ('ODHOM1P', 'OUTDOOR HOUSING FOR OM1P', '39', '1');
INSERT INTO `modelo` VALUES ('OM1P', 'PROFESSIONAL MESH ROUTER WIRELESS', '26', '1');
INSERT INTO `modelo` VALUES ('OM1P US', 'PROFESSIONAL MINI ROUTER US PLUGS', '26', '1');
INSERT INTO `modelo` VALUES ('OM2P', 'OM2P ROUTER', '26', '1');
INSERT INTO `modelo` VALUES ('OM2P-HS v2', 'OM2P ROUTER', '26', '1');
INSERT INTO `modelo` VALUES ('OMYA-NEE-38', 'SPRAY OMYA QUICK DRYING', '26', '1');
INSERT INTO `modelo` VALUES ('P-1091', 'CAJA DEXSON TOMA/MULTIPLE 55mm', '1', '1');
INSERT INTO `modelo` VALUES ('P-20021447', 'PATCH CORD FC/UPC-FC/UPC 5 METROS', '1', '1');
INSERT INTO `modelo` VALUES ('P80C31BH', 'INTEGRADO P80C31BH', '17', '1');
INSERT INTO `modelo` VALUES ('P80C88A-2', 'INTEGRADO P80C88A-2', '17', '1');
INSERT INTO `modelo` VALUES ('P9452BJ', 'INTEGRADO P9452BJ', '17', '1');
INSERT INTO `modelo` VALUES ('PAL20X8ACNS', 'INTEGRADO PAL20X8ACNS', '17', '1');
INSERT INTO `modelo` VALUES ('PAL32VX10ACJS', 'INTEGRADO PAL32VX10ACJS', '17', '1');
INSERT INTO `modelo` VALUES ('PB8000', 'LOGIC CONTROLS GPE652-12500W', '1', '1');
INSERT INTO `modelo` VALUES ('PEB2085P', 'INTEGRADO PEB2085P', '17', '1');
INSERT INTO `modelo` VALUES ('POEPASS-01', 'PASSIVE POE KIT', '26', '1');
INSERT INTO `modelo` VALUES ('PRODUCT-001-PR', 'ESTABILIZADOR', '34', '1');
INSERT INTO `modelo` VALUES ('PRUEBA', 'PRUEBA', '1', '1');
INSERT INTO `modelo` VALUES ('PRUEBA12', 'PRUEBA12', '49', '2');
INSERT INTO `modelo` VALUES ('PRUEBA13', 'PRUEBA13', '17', '1');
INSERT INTO `modelo` VALUES ('PRUEBA134', 'PRUEBA14', '17', '1');
INSERT INTO `modelo` VALUES ('pruebamodelo1', 'pruebamodelo1', '1', '2');
INSERT INTO `modelo` VALUES ('PRUEBAXYZ', 'NOMBREXYZ', '17', '1');
INSERT INTO `modelo` VALUES ('PRUEBILLA', '2321321', '17', '1');
INSERT INTO `modelo` VALUES ('pruebilla2', 'pruebilla2', '17', '1');
INSERT INTO `modelo` VALUES ('pruebilla3', 'p3', '17', '1');
INSERT INTO `modelo` VALUES ('PS12VUS', 'POWER SUPPLY', '1', '1');
INSERT INTO `modelo` VALUES ('PS18VUS', 'POWER SUPPLY 18V 1A  ( SAW24-138-1500)', '30', '1');
INSERT INTO `modelo` VALUES ('PS24VINT', 'AC/DC ADAPTER 24V 1000mA', '1', '1');
INSERT INTO `modelo` VALUES ('PST-1908', 'PACHT PANEL 24P CAT 5E', '1', '1');
INSERT INTO `modelo` VALUES ('QX\'0200\'0000', 'QX200', '22', '1');
INSERT INTO `modelo` VALUES ('QX\'0FXO\'0400', 'QXFX04', '22', '1');
INSERT INTO `modelo` VALUES ('QX\'0RMK\'0000', 'QX RACK KIT', '1', '1');
INSERT INTO `modelo` VALUES ('QX-0050-0000', 'QX50', '22', '1');
INSERT INTO `modelo` VALUES ('RMN4018A', 'MICROFONO/AURIC', '1', '1');
INSERT INTO `modelo` VALUES ('SASY-MICRO-0300-0100', 'QUADRO FXO', '22', '1');
INSERT INTO `modelo` VALUES ('SASY-MICRO-0300-0300', 'QUADRO 6L w/KSE', '22', '1');
INSERT INTO `modelo` VALUES ('SASY-MICRO-0501-1002', 'QUADRO 4L', '22', '1');
INSERT INTO `modelo` VALUES ('SASY-MICRO-0501-1101', 'QUADRO 2x2', '22', '1');
INSERT INTO `modelo` VALUES ('SASY-MIDI-0201-1000', 'QUADRO M26X', '22', '1');
INSERT INTO `modelo` VALUES ('SASY-SOHO-0103-1101', 'QUADRO 4X/4 FXO', '22', '1');
INSERT INTO `modelo` VALUES ('SDCFBI-32-201-80', 'COMPACTFLASH', '1', '1');
INSERT INTO `modelo` VALUES ('SETU VG8', 'Matrix Voip GSM Gateway', '37', '1');
INSERT INTO `modelo` VALUES ('SF 100-16', 'SWITCH CISCO SMALL BUSINESS', '29', '1');
INSERT INTO `modelo` VALUES ('SF200-24P', 'CISCO  24-PORT 10/100 PoE', '29', '1');
INSERT INTO `modelo` VALUES ('SF200-48P', 'CISCO 48-PORT 10/100PoE', '29', '1');
INSERT INTO `modelo` VALUES ('SFP-401101', 'FLAT FACE PLATE 1 PORT WHITE', '1', '1');
INSERT INTO `modelo` VALUES ('SG-001', 'MODELO PRUEBA', '27', '3');
INSERT INTO `modelo` VALUES ('SH-J023', 'CONNECTION ( MULTITOMA )', '1', '1');
INSERT INTO `modelo` VALUES ('SIP-T20P', 'YEALINK ENTERPRISE IP PHONE SIP-T20', '22', '1');
INSERT INTO `modelo` VALUES ('SIP-T26P', 'ENTERPRISE IP PHONE T26', '22', '1');
INSERT INTO `modelo` VALUES ('SIP-T28P', 'YEALINK ENTERPRISE IP PHONE SIP-T28', '22', '1');
INSERT INTO `modelo` VALUES ('SIP-T38G', 'GIGABIT COLOR IP PHONE SIP-T38G', '22', '1');
INSERT INTO `modelo` VALUES ('SKJ-XA3111', 'JACK TOOLESS CAT6A AZULES', '1', '1');
INSERT INTO `modelo` VALUES ('SKJXA3111', 'JACK TOOLESS CAT6A BLANCOS', '1', '1');
INSERT INTO `modelo` VALUES ('SKU:23067', 'WIRE STRAP ANTI-STATIC', '1', '1');
INSERT INTO `modelo` VALUES ('SL0CM023024', 'ORDENADOR CABLE MANAGEMENT 2U PLASTIC', '1', '1');
INSERT INTO `modelo` VALUES ('SL0PP2412U101', 'UTP BLANK PACTH PANEL MODULAR 24 PORTS', '1', '1');
INSERT INTO `modelo` VALUES ('SL5KJU0011201', 'JACK 110 CAT5E', '1', '1');
INSERT INTO `modelo` VALUES ('SL6APC2617102', 'PACHT CORD 7FT CAT6A BLANCO', '1', '1');
INSERT INTO `modelo` VALUES ('SL6APC26271006', 'PACHT CORD 2FT CAT6A AZUL', '1', '1');
INSERT INTO `modelo` VALUES ('SL6APC2627101', 'SHIELDES PACTCH CORD CAT 6A 3FT AZUL', '1', '1');
INSERT INTO `modelo` VALUES ('SM-J500M/DS', 'SAMSUNG Galaxy J5', '1', '1');
INSERT INTO `modelo` VALUES ('SNOM 870', 'SNOM VOIP PHONES', '22', '1');
INSERT INTO `modelo` VALUES ('SNP-3120VHN/DC', '12x Vandal resistant Network PTZ Camera', '1', '1');
INSERT INTO `modelo` VALUES ('SP-24PP-C6', 'PATCH PANEL MODULAR UTP 24P ORGAN.', '1', '1');
INSERT INTO `modelo` VALUES ('SP-BC6A-ULS', 'BOBINA CABLE U/UTP 4 P 23AWG CAT 6A LSZH LOW SMOKE', '1', '1');
INSERT INTO `modelo` VALUES ('ST-SC', 'PATCH CORD ST-SC DUPLEX SINGLE-MODE 10 METROS', '1', '1');
INSERT INTO `modelo` VALUES ('ST32122A', '2 GB SEAGATE HARD DISK', '15', '1');
INSERT INTO `modelo` VALUES ('STTC-101', 'REPLACEABLE TIP CARTRIDGE', '44', '1');
INSERT INTO `modelo` VALUES ('SXWE02-20-W', 'SURIX WANG PAGE', '22', '1');
INSERT INTO `modelo` VALUES ('T/M', 'TARJETAS MAGNETICAS', '18', '1');
INSERT INTO `modelo` VALUES ('T122000-24W', 'AC/DC ADAPTER 12V 2A', '1', '1');
INSERT INTO `modelo` VALUES ('TC8312', 'TELEFONO DESIGN ROJO TC 8312', '23', '1');
INSERT INTO `modelo` VALUES ('TDR', 'TALADRO', '1', '1');
INSERT INTO `modelo` VALUES ('TIP41', 'TRANSISTOR TIP41', '17', '1');
INSERT INTO `modelo` VALUES ('TIP42', 'TRANSISTOR TIP42', '17', '1');
INSERT INTO `modelo` VALUES ('TRPDG1LXDABS-ALB', 'SFP TRANSCEIVER', '1', '1');
INSERT INTO `modelo` VALUES ('TS 30 ID', 'TELEFONO INALAMBRICO DIGITAL TS 30 ID', '1', '1');
INSERT INTO `modelo` VALUES ('TS 3522', 'TELÉFONO INALAMBRICO', '1', '1');
INSERT INTO `modelo` VALUES ('TS 3530', 'TELEFONO INALAMBRICO 3530 INTELBRAS', '1', '1');
INSERT INTO `modelo` VALUES ('TS 3532', 'TELEFONO INALAMBRICO 3532 INTELBRAS', '1', '1');
INSERT INTO `modelo` VALUES ('TS 3533', 'TELEFONO INALAMBRICO TS 3533', '1', '1');
INSERT INTO `modelo` VALUES ('TYPE 32', 'TERMINAL POCKET', '48', '1');
INSERT INTO `modelo` VALUES ('U2200-07800-160', 'POLYCOM SOUNDSTATION 2W DECT 6,0 OPEN BOX', '43', '1');
INSERT INTO `modelo` VALUES ('ULT31418', 'ANTI-STATIC WRIST STRAP BRACELET ANTISTATIQUE', '1', '1');
INSERT INTO `modelo` VALUES ('undefined', 'undefined', null, null);
INSERT INTO `modelo` VALUES ('UNSP2000000002', 'PASS 25', '1', '1');
INSERT INTO `modelo` VALUES ('USB PHONE', 'USB WIRELESS PHONE', '1', '1');
INSERT INTO `modelo` VALUES ('VBCPO34XEX', 'SOPORTE CAMARA SAMSUNG SBP-300WM', '1', '1');
INSERT INTO `modelo` VALUES ('VERSATIS M250 LA', 'TELEFONO INALAMBRICO ALCATEL VERSATIS M250', '34', '1');
INSERT INTO `modelo` VALUES ('VGFX QB GSM', 'ANTENA GSM MULTIBANDA SETU VGFX', '20', '1');
INSERT INTO `modelo` VALUES ('VP-2009', 'IP VIDEO PHONE YEALINK VP-2009', '22', '1');
INSERT INTO `modelo` VALUES ('WD10PURX-64E5EY0', 'SATA/64MB Cache WD10PURX (1.0 TB)', '1', '1');
INSERT INTO `modelo` VALUES ('X0001MGLP1', 'PIN GROUNDING BLOCK', '1', '1');
INSERT INTO `modelo` VALUES ('X000B1SL7D', 'CARRIER PoE ADAPTER NANOSTATION', '26', '1');
INSERT INTO `modelo` VALUES ('X000G810R9', 'PASSIVE PoE KIT BLACK', '26', '1');
INSERT INTO `modelo` VALUES ('X000MABWIN', 'CASE FAN, 40X40X10 mm, Ball Bearing, 3 pin', '1', '1');
INSERT INTO `modelo` VALUES ('X00154FMQD', 'PASSIVE PoE KIT BLACK', '26', '1');
INSERT INTO `modelo` VALUES ('X3', 'FANVIL IP PHONE X3', '22', '1');
INSERT INTO `modelo` VALUES ('YHS32', 'HEADSET YEALINK', '36', '1');
INSERT INTO `modelo` VALUES ('Z-230PJ', 'DSL FILTER EXCELSUS SIMPLE', '35', '1');
INSERT INTO `modelo` VALUES ('Z9530003901A', 'FUENTE PARA CAMARA SAMSUNG 24V 2.5A', '1', '1');

-- ----------------------------
-- Table structure for persona
-- ----------------------------
DROP TABLE IF EXISTS `persona`;
CREATE TABLE `persona` (
  `identificacion_persona` varchar(20) NOT NULL COMMENT 'Número de cédula, pasaporte o carnet de refugiado',
  `nombres_persona` varchar(40) NOT NULL COMMENT 'Nombre de la persona',
  `apellidos_persona` varchar(40) NOT NULL COMMENT 'Apellidos de la persona',
  `genero_persona` tinyint(20) NOT NULL COMMENT 'Género de la persona (M=masculino F=femenino O=otro)',
  `estado_civil_persona` tinyint(20) NOT NULL COMMENT 'Estado civil de la persona (C=casado, S=soltero, V=viudo, D=divorciado, U=union libre)',
  `telefono_domicilio_persona` varchar(20) DEFAULT NULL COMMENT 'Teléfono domicilio de la persona',
  `telefono_celular_persona` varchar(20) DEFAULT NULL COMMENT 'Teléfono celular de la persona',
  `correo_persona` varchar(100) DEFAULT NULL COMMENT 'Correo personal de la persona',
  `fecha_nacimiento_persona` date NOT NULL COMMENT 'Fecha de nacimiento de la persona',
  `pais_nacimiento_persona` varchar(30) NOT NULL COMMENT 'País de nacimiento de la persona',
  `ciudad_nacimiento_persona` varchar(30) NOT NULL COMMENT 'Ciudad de nacimiento de la persona',
  `direccion_persona` varchar(100) NOT NULL COMMENT 'Dirección de domicilio de la persona',
  PRIMARY KEY (`identificacion_persona`),
  KEY `fk_genero` (`genero_persona`),
  KEY `fk_estadoCivilP` (`estado_civil_persona`),
  CONSTRAINT `fk_estadoCivil` FOREIGN KEY (`estado_civil_persona`) REFERENCES `estadocivil` (`id_estado_civil`),
  CONSTRAINT `fk_genero` FOREIGN KEY (`genero_persona`) REFERENCES `genero` (`id_genero`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Datos personales y de contacto de la persona';

-- ----------------------------
-- Records of persona
-- ----------------------------
INSERT INTO `persona` VALUES ('1724395536', 'MARIO FERNANDO', 'PALOMO ACELDO', '1', '1', '2647710', '0979212157', 'mpalomoa@gmail.com', '1996-12-24', 'Ecuador', 'Quito', 'Libertad');
INSERT INTO `persona` VALUES ('1789654123', 'LESLIE ISABEL', 'PEÑAHERRERA DOMINGUEZ', '2', '1', '022456123', '0987456321', 'leslie@gmail.com', '2000-11-11', 'ECUADOR', 'QUITO', 'QUITO SUR');

-- ----------------------------
-- Table structure for producto
-- ----------------------------
DROP TABLE IF EXISTS `producto`;
CREATE TABLE `producto` (
  `id_producto` int(50) NOT NULL AUTO_INCREMENT COMMENT 'Clave única de la tabla producto',
  `serie_producto` varchar(50) DEFAULT NULL COMMENT 'Serie del producto',
  `id_modelo` varchar(50) DEFAULT NULL COMMENT 'Nombre del producto',
  `observacion_producto` varchar(255) DEFAULT NULL COMMENT 'Observación del producto',
  `estado_producto` tinyint(1) DEFAULT '0' COMMENT 'Estado del producto (0=bodega, 1=asignado, 2=dañado)',
  `meses_garantia_producto` tinyint(255) DEFAULT NULL COMMENT 'Meses de garantía del producto',
  `anio_fabricacion` year(4) DEFAULT NULL COMMENT 'Año de fabricación del producto',
  `peso_neto_producto` decimal(6,2) DEFAULT NULL COMMENT 'Peso en kilogramos del producto',
  `fecha_ingreso_producto` date DEFAULT NULL COMMENT 'Fecha de ingreso del producto',
  `id_ubicacion_producto` int(11) DEFAULT NULL COMMENT 'Clave foranéa de la tabla ubicación',
  `id_proveedor` int(11) DEFAULT NULL COMMENT 'Clave foranéa de la tabla proveedor',
  `usuario` varchar(70) DEFAULT NULL COMMENT 'Nombre del usuario que realizó la acción',
  PRIMARY KEY (`id_producto`),
  KEY `fk_modelo` (`id_modelo`),
  KEY `fk_ubicacion` (`id_ubicacion_producto`),
  KEY `fk_proveedor` (`id_proveedor`),
  CONSTRAINT `fk_produc` FOREIGN KEY (`id_modelo`) REFERENCES `modelo` (`codigo_modelo`),
  CONSTRAINT `fk_proveedor` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedor` (`id_proveedor`),
  CONSTRAINT `fk_ubicacion` FOREIGN KEY (`id_ubicacion_producto`) REFERENCES `ubicacion` (`id_ubicacion`)
) ENGINE=InnoDB AUTO_INCREMENT=122933 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of producto
-- ----------------------------
INSERT INTO `producto` VALUES ('1', 'AAAAC9930620020075*', 'AAA1820062AA02', 'ENTREGA SANTIAGO REYES PARA REPUESTOS', '0', null, null, null, '2013-07-30', '1', '1', null);
INSERT INTO `producto` VALUES ('2', 'QB2M1A9000971', 'IES1008AA', 'DEVOLUCION DE ST SERVICIOS (CON FUENTE)', '0', null, null, null, '2015-05-28', '1', '1', null);
INSERT INTO `producto` VALUES ('3', 'ZBMN6V2GC00015E', 'SNP-3120VHN/DC', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-01-27', '1', '1', null);
INSERT INTO `producto` VALUES ('4', 'XKL05633', 'ST32122A', 'ENTREGA SANTIAGO REYES PARA REPUESTOS', '0', null, null, null, '2011-03-11', '1', '1', null);
INSERT INTO `producto` VALUES ('5', 'S/N', '2200UF 50V', 'RECUPERADO DE RESICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('6', '235211006', '130-195', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2011-08-31', '1', '1', null);
INSERT INTO `producto` VALUES ('7', 'S/S', 'ADU120150', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2014-03-12', '1', '1', null);
INSERT INTO `producto` VALUES ('8', 'S/S', 'ADU120150', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2014-03-12', '1', '1', null);
INSERT INTO `producto` VALUES ('9', 'S/S', 'ADU120150', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2015-01-28', '1', '1', null);
INSERT INTO `producto` VALUES ('10', 'S/S', 'T122000-24W', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-10-03', '3', '1', null);
INSERT INTO `producto` VALUES ('11', 'S/S', 'PS24VINT', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2015-12-29', '4', '1', null);
INSERT INTO `producto` VALUES ('12', '23EQ256', '2504548T01', 'UBICADO', '0', null, null, null, '2012-08-28', '1', '1', null);
INSERT INTO `producto` VALUES ('13', '23EQ366', '2504548T01', 'UBICADO', '0', null, null, null, '2012-08-28', '1', '1', null);
INSERT INTO `producto` VALUES ('14', 'S/S', 'MRD-MT001', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2015-09-02', '3', '1', null);
INSERT INTO `producto` VALUES ('15', 'S/S', 'VGFX QB GSM', 'SOBRANTE DE EQUIPO MATRIX ( CON BASE )', '0', null, null, null, '2014-10-28', '3', '1', null);
INSERT INTO `producto` VALUES ('16', 'S/S', 'ULT31418', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2014-04-07', '1', '1', null);
INSERT INTO `producto` VALUES ('17', 'S/S', '1100-0232', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2012-01-17', '1', '1', null);
INSERT INTO `producto` VALUES ('18', 'S/S', '1100-0233', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2012-01-17', '1', '1', null);
INSERT INTO `producto` VALUES ('19', 'FJ3143000168', 'IP GATEWAY', 'GUIA AERIA (41N02 03475) CAJA 22', '0', null, null, null, '2014-12-01', '5', '1', null);
INSERT INTO `producto` VALUES ('20', 'FJ3143001167', 'IP GATEWAY', 'GUIA AERIA (41N02 03475) CAJA 23', '0', null, null, null, '2014-12-01', '5', '1', null);
INSERT INTO `producto` VALUES ('21', 'FJ3143001162', 'IP GATEWAY', 'GUIA AERIA (41N02 03475) CAJA 23', '0', null, null, null, '2014-12-01', '5', '1', null);
INSERT INTO `producto` VALUES ('22', 'FJ3143000180', 'IP GATEWAY', 'GUIA AERIA (41N02 03475) CAJA 22', '0', null, null, null, '2014-12-01', '5', '1', null);
INSERT INTO `producto` VALUES ('23', 'FJ3143000165', 'IP GATEWAY', 'GUIA AERIA (41N02 03475) CAJA 22', '0', null, null, null, '2014-12-01', '5', '1', null);
INSERT INTO `producto` VALUES ('24', 'FJ3143000162', 'IP GATEWAY', 'GUIA AERIA (41N02 03475) CAJA 22', '0', null, null, null, '2014-12-01', '5', '1', null);
INSERT INTO `producto` VALUES ('25', 'FJ3143000161', 'IP GATEWAY', 'GUIA AERIA (41N02 03475) CAJA 22', '0', null, null, null, '2014-12-01', '5', '1', null);
INSERT INTO `producto` VALUES ('26', 'FJ3143000169', 'IP GATEWAY', 'GUIA AERIA (41N02 03475) CAJA 22', '0', null, null, null, '2014-12-01', '5', '1', null);
INSERT INTO `producto` VALUES ('27', 'FJ3143000167', 'IP GATEWAY', 'GUIA AERIA (41N02 03475) CAJA 22', '0', null, null, null, '2014-12-01', '5', '1', null);
INSERT INTO `producto` VALUES ('28', 'FJ3143000166', 'IP GATEWAY', 'GUIA AERIA (41N02 03475) CAJA 22', '0', null, null, null, '2014-12-01', '5', '1', null);
INSERT INTO `producto` VALUES ('29', 'FJ3143001166', 'IP GATEWAY', 'GUIA AERIA (41N02 03475) CAJA 23', '0', null, null, null, '2014-12-01', '5', '1', null);
INSERT INTO `producto` VALUES ('30', 'FJ3128000280', 'IP GATEWAY', '00A859C94A8E (POSIBLE ERROR DE ENTREGA ESPOCH EL QUE EXISTE EN EL INVENTARIO ES EL NS: FJ3128000303)', '0', null, null, null, '2012-09-26', '1', '1', null);
INSERT INTO `producto` VALUES ('31', 'FJ3143000170', 'IP GATEWAY', 'GUIA AERIA (41N02 03475) CAJA 22', '0', null, null, null, '2014-12-01', '5', '1', null);
INSERT INTO `producto` VALUES ('32', 'FJ3143001164', 'IP GATEWAY', 'GUIA AERIA (41N02 03475) CAJA 23', '0', null, null, null, '2014-12-01', '5', '1', null);
INSERT INTO `producto` VALUES ('33', 'FJ3143001163', 'IP GATEWAY', 'GUIA AERIA (41N02 03475) CAJA 23', '0', null, null, null, '2014-12-01', '5', '1', null);
INSERT INTO `producto` VALUES ('34', 'FJ3143001170', 'IP GATEWAY', 'GUIA AERIA (41N02 03475) CAJA 23', '0', null, null, null, '2014-12-01', '5', '1', null);
INSERT INTO `producto` VALUES ('35', 'FJ3143001169', 'IP GATEWAY', 'GUIA AERIA (41N02 03475) CAJA 23', '0', null, null, null, '2014-12-01', '5', '1', null);
INSERT INTO `producto` VALUES ('36', 'FJ3143001168', 'IP GATEWAY', 'GUIA AERIA (41N02 03475) CAJA 23', '0', null, null, null, '2014-12-01', '5', '1', null);
INSERT INTO `producto` VALUES ('37', 'FJ3143001161', 'IP GATEWAY', 'GUIA AERIA (41N02 03475) CAJA 23', '0', null, null, null, '2014-12-01', '5', '1', null);
INSERT INTO `producto` VALUES ('38', 'FJ3128000015', 'IP GATEWAY', 'DEVOLUCION DE ST SERVICIOS( CON FUENTE)', '0', null, null, null, '2014-12-11', '5', '1', null);
INSERT INTO `producto` VALUES ('39', '09600470', 'AG-188N', 'PROPIEDAD CINETO INCLUYE ADAPTADOR CABLE DE RED', '0', null, null, null, '2011-01-20', '1', '1', null);
INSERT INTO `producto` VALUES ('40', 'S/S', 'AURICULAR', 'ARMARIO CINT', '0', null, null, null, '2012-08-30', '6', '1', null);
INSERT INTO `producto` VALUES ('41', 'DCRD2300733ZB', '4115000', 'INGRESO REPARACIÓN (RAS)', '0', null, null, null, '2016-12-21', '5', '1', null);
INSERT INTO `producto` VALUES ('42', '3155151200017', 'K14', 'DEVOLUCION DE LA MUTUALISTA PICHINCHA', '0', null, null, null, '2016-02-11', '7', '1', null);
INSERT INTO `producto` VALUES ('43', 'S/S', 'SP-BC6A-ULS', 'COMPRA COPPER SYSTEMS (Factura 4400 )', '0', null, null, null, '2017-01-30', '1', '1', null);
INSERT INTO `producto` VALUES ('44', 'S/S', '97K8839', 'NEWARK OC 000026', '0', null, null, null, '2011-03-21', '1', '1', null);
INSERT INTO `producto` VALUES ('45', 'S/S', '3499', 'ENTREGA SANTIAGO REYES ( INSTALACION HACIENDA )', '0', null, null, null, '2016-05-10', '1', '1', null);
INSERT INTO `producto` VALUES ('46', 'S/S', '40Uf/2A', 'ARMARIO RESPUESTOS', '0', null, null, null, '2012-08-30', '8', '1', null);
INSERT INTO `producto` VALUES ('47', 'S/S', '22UH/3A', 'ARMARIO REPUESTOS', '0', null, null, null, '2012-08-30', '8', '1', null);
INSERT INTO `producto` VALUES ('48', 'S/S', '56UH/1.5A', 'ARMARIO REPUESTOS', '0', null, null, null, '2012-08-30', '8', '1', null);
INSERT INTO `producto` VALUES ('49', 'S/S', '14UH', 'ARMARIO REPUESTOS', '0', null, null, null, '2012-08-30', '8', '1', null);
INSERT INTO `producto` VALUES ('50', 'S/N', 'BOBINAS IEC IER', 'REPUSETOS DEL RECICLAJE', '0', null, null, null, '2012-09-03', '2', '1', null);
INSERT INTO `producto` VALUES ('51', 'S/S', 'B00MYNX0ZI', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-10-31', '4', '1', null);
INSERT INTO `producto` VALUES ('52', 'FT112B000743', 'C01', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '3', '1', null);
INSERT INTO `producto` VALUES ('53', 'FT112B000744', 'C01', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '3', '1', null);
INSERT INTO `producto` VALUES ('54', 'FT112B000750', 'C01', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '3', '1', null);
INSERT INTO `producto` VALUES ('55', 'FT112B000742', 'C01', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '3', '1', null);
INSERT INTO `producto` VALUES ('56', 'FT112B000748', 'C01', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '3', '1', null);
INSERT INTO `producto` VALUES ('57', 'FT112B000741', 'C01', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '3', '1', null);
INSERT INTO `producto` VALUES ('58', 'FT112B000745', 'C01', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '3', '1', null);
INSERT INTO `producto` VALUES ('59', 'FO1129000038', 'C56HP', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('60', 'FO1129000037', 'C56HP', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('61', 'FO1129000039', 'C56HP', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('62', 'FO1129000040', 'C56HP', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('63', 'FO1129000086', 'C56HP', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('64', 'FO1129000082', 'C56HP', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('65', 'FO1129000081', 'C56HP', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('66', 'FO1129000036', 'C56HP', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('67', 'FO1129000034', 'C56HP', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('68', 'FO1129000033', 'C56HP', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('69', 'FO1129000084', 'C56HP', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('70', 'FO1129000085', 'C56HP', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('71', 'FO1129000001', 'C56HP', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('72', 'FO1129000031', 'C56HP', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('73', 'FO1129000005', 'C56HP', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('74', 'FO1129000076', 'C56HP', 'DEVOLUCION DATA VOZ', '0', null, null, null, '2015-04-27', '1', '1', null);
INSERT INTO `producto` VALUES ('75', 'FO1129000002', 'C56HP', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('76', 'FO1129000010', 'C56HP', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('77', 'FO1129000003', 'C56HP', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('78', 'FO1129000004', 'C56HP', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('79', 'FO1129000008', 'C56HP', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('80', 'FO1129000032', 'C56HP', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('81', 'FO1129000035', 'C56HP', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('82', 'FO1129000091', 'C56HP', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('83', 'FO1129000006', 'C56HP', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('84', 'FO1129000090', 'C56HP', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('85', 'FO1129000079', 'C56HP', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('86', 'FO1129000083', 'C56HP', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('87', 'FO1129000100', 'C56HP', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('88', 'FO1129000088', 'C56HP', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('89', 'FO1129000009', 'C56HP', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('90', 'FO1129000027', 'C56HP', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('91', 'FO1129000007', 'C56HP', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('92', 'FO1129000028', 'C56HP', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('93', 'FO1129000087', 'C56HP', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('94', 'FO1129000089', 'C56HP', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('95', 'F81131001151', 'C56P', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('96', 'F81131001336', 'C56P', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('97', 'F81131001096', 'C56P', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('98', 'F81131001062', 'C56P', 'GUIA AEREA - SZX 841834 -2', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('99', 'F81131001240', 'C56P', 'GUIA AEREA - SZX 841834 -2', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('100', 'FS112C000175', 'C66P', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('101', 'FS112C000108', 'C66P', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('102', 'FS112C000163', 'C66P', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('103', 'S/S', '746320011370', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2012-07-04', '1', '1', null);
INSERT INTO `producto` VALUES ('104', 'S/S', 'KCS10', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2011-02-25', '1', '1', null);
INSERT INTO `producto` VALUES ('105', 'S/S', '6092110201', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-04-22', '3', '1', null);
INSERT INTO `producto` VALUES ('106', 'S/S', '6092110201', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-04-22', '9', '1', null);
INSERT INTO `producto` VALUES ('107', 'S/S', 'E209234', 'ENTREGA SANTIAGO REYES ( ROTO 79.33M )', '0', null, null, null, '2015-10-02', '10', '1', null);
INSERT INTO `producto` VALUES ('108', 'S/S', 'CABLE M26X', 'DEVOLUCION BODEGAS FLEX NET ALU', '0', null, null, null, '2012-07-09', '1', '1', null);
INSERT INTO `producto` VALUES ('109', 'S/S', 'CABLE M26X', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2012-07-02', '1', '1', null);
INSERT INTO `producto` VALUES ('110', 'S/S', 'MP-5609-60', 'CABLES TIPO PL75-9', '0', null, null, null, '2011-03-24', '1', '1', null);
INSERT INTO `producto` VALUES ('111', 'S/S', 'P-1091', 'COMPRA COPPER SYSTEMS (Factura 4400 )', '0', null, null, null, '2017-01-30', '1', '1', null);
INSERT INTO `producto` VALUES ('112', 'S/S', 'DXN5011S', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-10-03', '11', '1', null);
INSERT INTO `producto` VALUES ('113', '21JD44SD80586A7E', '967-00052-10A002', 'SO89623', '0', null, null, null, '2014-11-13', '1', '1', null);
INSERT INTO `producto` VALUES ('114', '9JIE34001259J', '4564008', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('115', '9JIE3400128AV', '4564008', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('116', '9JIE34001214A', '4564008', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('117', 'OD12122005797', '7896637643542', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-05-20', null, '1', null);
INSERT INTO `producto` VALUES ('118', '8R3B3600022OM', '7896637644969', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-05-20', null, '1', null);
INSERT INTO `producto` VALUES ('119', 'CSX002', 'CAMSX', 'ENTREGA SANTIAGO REYES (FACTURA SH001-293-030216)', '0', null, null, null, '2016-02-11', '14', '1', null);
INSERT INTO `producto` VALUES ('120', 'CSX003', 'CAMSX', 'ENTREGA SANTIAGO REYES (FACTURA SH001-293-030216)', '0', null, null, null, '2016-02-11', '14', '1', null);
INSERT INTO `producto` VALUES ('121', '1M9E3200059PK', '4564004', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '5', '1', null);
INSERT INTO `producto` VALUES ('122', '1M9E31003122W', '4564004', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('123', '1M9E3100325VC', '4564004', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '5', '1', null);
INSERT INTO `producto` VALUES ('124', '1M9E3100329F1', '4564004', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '5', '1', null);
INSERT INTO `producto` VALUES ('125', '1M9E31003234A', '4564004', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '5', '1', null);
INSERT INTO `producto` VALUES ('126', '1M9E3100326V4', '4564004', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '5', '1', null);
INSERT INTO `producto` VALUES ('127', '1M9E3100327SV', '4564004', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '5', '1', null);
INSERT INTO `producto` VALUES ('128', '1M9E3100324VA', '4564004', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '5', '1', null);
INSERT INTO `producto` VALUES ('129', '1M9E3100307M1', '4564004', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('130', '1M9E3100332DF', '4564004', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '5', '1', null);
INSERT INTO `producto` VALUES ('131', '1M9E3200061JN', '4564004', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '5', '1', null);
INSERT INTO `producto` VALUES ('132', '1M9E3100328OJ', '4564004', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '5', '1', null);
INSERT INTO `producto` VALUES ('133', '1M9E3100331XM', '4564004', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '5', '1', null);
INSERT INTO `producto` VALUES ('134', '1M9E3200060N8', '4564004', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '5', '1', null);
INSERT INTO `producto` VALUES ('135', '1M9E3100330VB', '4564004', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '5', '1', null);
INSERT INTO `producto` VALUES ('136', '1111-0058156', 'X000B1SL7D', 'GUIA AEREA LI11861244', '0', null, null, null, '2012-07-17', '1', '1', null);
INSERT INTO `producto` VALUES ('137', '1111-0058214', 'X000B1SL7D', 'GUIA AEREA LI11861244', '0', null, null, null, '2012-07-17', '1', '1', null);
INSERT INTO `producto` VALUES ('138', 'S/S', 'CASCOS', 'ENTREGA SANATIAGO REYES INCLUYE CREMALLERA Y QUIJADERA', '0', null, null, null, '2013-02-14', '15', '1', null);
INSERT INTO `producto` VALUES ('139', 'S/S', 'X000MABWIN', 'ENTREGA SANTIAGO REYES (EC4010M12CA DC 12V  0,07A)', '0', null, null, null, '2014-09-11', '1', '1', null);
INSERT INTO `producto` VALUES ('140', 'KMNE39000241T', '7896637658058', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('141', 'KMNE3900004D9', '7896637658058', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('142', 'KMND39000506V', '7896637658058', 'STOCK INTELBRAS 16-12-2015', '0', null, null, null, '2015-12-16', '4', '1', null);
INSERT INTO `producto` VALUES ('143', 'KMNE3900036FH', '7896637658058', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('144', 'KMND3900084OQ', '7896637658058', 'STOCK INTELBRAS 16-12-2015', '0', null, null, null, '2015-12-16', '4', '1', null);
INSERT INTO `producto` VALUES ('145', 'S/S', 'CHALECOS', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-02-14', '15', '1', null);
INSERT INTO `producto` VALUES ('146', 'CS8\'79121', 'LR79574', 'ARMARIO CINT', '0', null, null, null, '2012-08-30', '6', '1', null);
INSERT INTO `producto` VALUES ('147', 'S/S', '256550', 'HERRAMIENTAS DE CINETO', '0', null, null, null, '2013-06-20', '16', '1', null);
INSERT INTO `producto` VALUES ('148', 'S/S', '1124-0028-P1', 'ENTREGA SANTIAGO REYES  P.O 9150460-00', '0', null, null, null, '2012-01-17', '1', '1', null);
INSERT INTO `producto` VALUES ('149', 'S/S', '1124-0016-P1', 'ENTREGA SANTIAGO REYES  P.O 9150460-00', '0', null, null, null, '2012-01-17', '1', '1', null);
INSERT INTO `producto` VALUES ('150', 'S/S', '1124-0007-P1', 'ENTREGA SANTIAGO REYES  P.O 9150460-00', '0', null, null, null, '2012-01-17', '1', '1', null);
INSERT INTO `producto` VALUES ('151', 'S/S', '1124-0013-P1', 'ENTREGA SANTIAGO REYES  P.O 9150460-00', '0', null, null, null, '2012-01-17', '1', '1', null);
INSERT INTO `producto` VALUES ('152', 'S/S', '1124-0023-P1', 'ENTREGA SANTIAGO REYES  P.O 9150460-00', '0', null, null, null, '2012-01-17', '1', '1', null);
INSERT INTO `producto` VALUES ('153', 'S/S', '1124-0010-P1', 'ENTREGA SANTIAGO REYES  P.O 9150460-00,', '0', null, null, null, '2012-01-17', '1', '1', null);
INSERT INTO `producto` VALUES ('154', 'S/S', 'M21-750-499', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2015-06-08', '1', '1', null);
INSERT INTO `producto` VALUES ('155', 'S/S', 'M21-750-499', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-11-21', '1', '1', null);
INSERT INTO `producto` VALUES ('156', 'S/S', 'M21-500-499-TB', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2015-06-08', '1', '1', null);
INSERT INTO `producto` VALUES ('157', 'DNI152600RU', 'SF200-24P', 'DEVOLUCIÓN RUBÉN AGUILAR', '0', null, null, null, '2016-11-01', '5', '1', null);
INSERT INTO `producto` VALUES ('158', 'DNI1623087K', 'SF200-48P', 'REINGRESO CON DAÑO EN PUERTOS 3, 9 ,13,14,15,19,20,21', '0', null, null, null, '2017-01-09', '17', '1', null);
INSERT INTO `producto` VALUES ('159', 'S/S', '1AFO1226ADAA', 'SERETIRO DE LOS MODEN PARA BOTAR', '0', null, null, null, '2013-12-02', '1', '1', null);
INSERT INTO `producto` VALUES ('160', 'S/S', 'SDCFBI-32-201-80', 'RESICLAJE', '0', null, null, null, '2013-06-18', '1', '1', null);
INSERT INTO `producto` VALUES ('161', 'S/N', '0.33UF 120V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('162', 'S/N', '1000UF 100V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('163', 'S/N', '1000UF 10V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('164', 'S/N', '1000UF 15V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('165', 'S/N', '1000UF 25V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('166', 'S/N', '1000UF 40V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('167', 'S/N', '100UF 200V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('168', 'S/N', '100UF 25V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('169', 'S/N', '100UF 35V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('170', 'S/N', '100UF 40V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('171', 'S/N', '100UF 50V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('172', 'S/N', '100UF 6,3V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('173', 'S/N', '100UF 63V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('174', 'S/N', '100UF 16V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('175', 'S/N', '100UF 16V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('176', 'S/N', '10NF 630V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('177', 'S/N', '10UF 100V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('178', 'S/N', '10UF 16V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('179', 'S/N', '10UF 200V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('180', 'S/N', '10UF 250V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('181', 'S/N', '10UF 25V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('182', 'S/N', '10UF 35V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('183', 'S/N', '10UF 40V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('184', 'S/N', '10UF 50V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('185', 'S/N', '10UF 63V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('186', 'S/N', '120UF 100V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('187', 'S/S', '15000UF-63V', 'REPUESTOS DE LAS PLACAS', '0', null, null, null, '2012-08-27', '18', '1', null);
INSERT INTO `producto` VALUES ('188', 'S/N', '1500UF 10V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('189', 'S/N', '15UF 16V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('190', 'S/N', '1UF 200V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('191', 'S/N', '2,2UF 63V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('192', 'S/S', '2.2UF 250V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '18', '1', null);
INSERT INTO `producto` VALUES ('193', 'S/S', '2.2UF-900V', 'REPUESTOS DE LAS PLACAS', '0', null, null, null, '2012-08-27', '18', '1', null);
INSERT INTO `producto` VALUES ('194', 'S/N', '20UF 40V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('195', 'S/N', '2200UF 100V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('196', 'S/N', '2200UF 16V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('197', 'S/N', '2200UF 25V', 'REPUESTOS DEL RACICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('198', 'S/N', '220NF 1000V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('199', 'S/N', '220UF 100V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('200', 'S/N', '220UF 10V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('201', 'S/N', '220UF 16V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('202', 'S/N', '220UF 25V', 'REPOUSTO DE RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('203', 'S/N', '220UF 35V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('204', 'S/N', '220UF 50V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('205', 'S/N', '220UF 63V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('206', 'S/N', '22UF 100V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('207', 'S/N', '22UF 160V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('208', 'S/N', '22UF 35V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('209', 'S/N', '22UF 63V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('210', 'S/N', '3,3UF 250V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('211', 'S/N', '3300UF 12V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('212', 'S/N', '3300UF 35V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('213', 'S/N', '330UF 10V', 'REPUESTOS DEL RECICLAGE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('214', 'S/N', '330UF 16V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('215', 'S/N', '330UF 25V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('216', 'S/N', '33UF 100V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('217', 'S/N', '33UF 16V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('218', 'S/N', '33UF 250V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('219', 'S/N', '4,7NF 1000V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('220', 'S/N', '4,7UF 100V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('221', 'S/N', '4,7UF 16V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('222', 'S/N', '4,7UF 25V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('223', 'S/N', '4,7UF 40V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('224', 'S/N', '4,7UF 63V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('225', 'S/N', '4700UF 16V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('226', 'S/N', '470UF 10V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('227', 'S/N', '470UF 12V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('228', 'S/N', '470UF 16V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('229', 'S/N', '470UF 20V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('230', 'S/N', '470UF 40V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('231', 'S/N', '470UF 63V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('232', 'S/S', '470UF-400V', 'REPUESTOS DE LAS PLACAS', '0', null, null, null, '2012-08-27', '18', '1', null);
INSERT INTO `producto` VALUES ('233', 'S/N', '47UF 100V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('234', 'S/N', '47UF 16V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('235', 'S/N', '47UF 25V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('236', 'S/N', '47UF 40V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('237', 'S/N', '47UF 63V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('238', 'S/N', '6,8UF 100V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('239', 'S/N', '6,8UF 100V', 'REPUSETOS DEL RECICLAJE', '0', null, null, null, '2012-09-03', '2', '1', null);
INSERT INTO `producto` VALUES ('240', 'S/N', '6,8UF 25V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('241', 'S/N', '680UF 25V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('242', 'S/N', '680UF 6,3V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '19', '1', null);
INSERT INTO `producto` VALUES ('243', 'S/N', '680UF 63V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('244', 'S/S', '680UF-385V', 'REPUESTOS DE LAS PLACAS', '0', null, null, null, '2012-08-27', '18', '1', null);
INSERT INTO `producto` VALUES ('245', 'S/N', '68UF 16V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('246', 'S/N', '68UF 6,3V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('247', 'S/N', '68UF 63V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('248', 'S/N', '9UF 125V', 'REPUSTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('249', 'S/N', '9UF 20V', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-27', '2', '1', null);
INSERT INTO `producto` VALUES ('250', 'S/S', '22UF-16V', 'REPUESTOS DE LAS PLACAS', '0', null, null, null, '2012-08-27', '18', '1', null);
INSERT INTO `producto` VALUES ('251', 'S/S', '19C1693', 'NEWARK OC 000026', '0', null, null, null, '2011-03-21', '1', '1', null);
INSERT INTO `producto` VALUES ('252', 'S/S', '48F2772', 'NEWARK OC 000026', '0', null, null, null, '2011-03-21', '1', '1', null);
INSERT INTO `producto` VALUES ('253', 'S/S', '2200-050P', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2011-02-25', '1', '1', null);
INSERT INTO `producto` VALUES ('254', 'S/S', '97B2386', 'NEWARK OC 000026', '0', null, null, null, '2011-03-21', '1', '1', null);
INSERT INTO `producto` VALUES ('255', 'S/S', '2299121', 'ENTREGADA SANTIAGO REYES', '0', null, null, null, '2011-02-25', '1', '1', null);
INSERT INTO `producto` VALUES ('256', 'S/S', '3480405000000010549711', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-09-02', '1', '1', null);
INSERT INTO `producto` VALUES ('257', 'S/S', 'SH-J023', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2015-08-25', '1', '1', null);
INSERT INTO `producto` VALUES ('258', 'QW9C3300701WN', '4505200', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '20', '1', null);
INSERT INTO `producto` VALUES ('259', 'QW9C3300633QX', '4505200', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '20', '1', null);
INSERT INTO `producto` VALUES ('260', 'QW9C33007037V', '4505200', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '20', '1', null);
INSERT INTO `producto` VALUES ('261', 'QW9C3300660BW', '4505200', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '20', '1', null);
INSERT INTO `producto` VALUES ('262', 'QW9C3300634FD', '4505200', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '20', '1', null);
INSERT INTO `producto` VALUES ('263', 'QW9C3300645TF', '4505200', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '20', '1', null);
INSERT INTO `producto` VALUES ('264', 'QW9C3300644VX', '4505200', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '20', '1', null);
INSERT INTO `producto` VALUES ('265', 'QW9C33006425T', '4505200', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '20', '1', null);
INSERT INTO `producto` VALUES ('266', 'QW9C3300635RQ', '4505200', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '20', '1', null);
INSERT INTO `producto` VALUES ('267', 'QW9C3300643AO', '4505200', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '20', '1', null);
INSERT INTO `producto` VALUES ('268', 'QW9C3300704P0', '4505200', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '20', '1', null);
INSERT INTO `producto` VALUES ('269', 'QW9C3300631QP', '4505200', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '20', '1', null);
INSERT INTO `producto` VALUES ('270', 'M1054\'0000025', '8904133014373', 'DHL 3338321206', '0', null, null, null, '2014-12-16', '3', '1', null);
INSERT INTO `producto` VALUES ('271', 'AAAAC963028555', 'AAA1820028B05', 'ENTREGA SANTIAGO REYES PARA SACAR ELEMENTOS', '0', null, null, null, '2011-03-11', '1', '1', null);
INSERT INTO `producto` VALUES ('272', 'S/S', 'M32', 'HERRAMIENTA DE CINETO', '0', null, null, null, '2013-06-20', '16', '1', null);
INSERT INTO `producto` VALUES ('273', '68015847#DC', 'CT14', '', '0', null, null, null, '2017-02-20', '7', '1', null);
INSERT INTO `producto` VALUES ('274', '68007636#DC', 'CT14', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-09-14', '3', '1', null);
INSERT INTO `producto` VALUES ('275', '68014506#DC', 'CT14', '', '0', null, null, null, '2017-02-20', '7', '1', null);
INSERT INTO `producto` VALUES ('276', '68014048#DC', 'CT14', '', '0', null, null, null, '2017-02-20', '7', '1', null);
INSERT INTO `producto` VALUES ('277', '68014760#DC', 'CT14', '', '0', null, null, null, '2017-02-20', '7', '1', null);
INSERT INTO `producto` VALUES ('278', '68007391#DC', 'CT14', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-10-05', '7', '1', null);
INSERT INTO `producto` VALUES ('279', '68014282#DC', 'CT14', '', '0', null, null, null, '2017-02-20', '7', '1', null);
INSERT INTO `producto` VALUES ('280', '68007094#DC', 'CT14', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-10-05', '7', '1', null);
INSERT INTO `producto` VALUES ('281', '55ELTFH6T', 'MQ01ABD100', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-05-10', '21', '1', null);
INSERT INTO `producto` VALUES ('282', '34XC33004529B', '4505300', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '20', '1', null);
INSERT INTO `producto` VALUES ('283', '34XC3300462II', '4505300', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '20', '1', null);
INSERT INTO `producto` VALUES ('284', '34XC3300475JT', '4505300', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '20', '1', null);
INSERT INTO `producto` VALUES ('285', '34XC33004027R', '4505300', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '20', '1', null);
INSERT INTO `producto` VALUES ('286', '34XC33004780Q', '4505300', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '20', '1', null);
INSERT INTO `producto` VALUES ('287', '34XC3300487SV', '4505300', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '20', '1', null);
INSERT INTO `producto` VALUES ('288', '34XC3300470HG', '4505300', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '20', '1', null);
INSERT INTO `producto` VALUES ('289', '34XC3300502L5', '4505300', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '20', '1', null);
INSERT INTO `producto` VALUES ('290', '34XC33004646M', '4505300', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '20', '1', null);
INSERT INTO `producto` VALUES ('291', '34XC3300479AO', '4505300', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '20', '1', null);
INSERT INTO `producto` VALUES ('292', '34XC3300485HW', '4505300', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '20', '1', null);
INSERT INTO `producto` VALUES ('293', '34XC3300459XH', '4505300', 'ENTREGA INTELBRAS POR GARANTIA A CAMBIO DE 34XC3300463H0', '0', null, null, null, '2016-10-07', '20', '1', null);
INSERT INTO `producto` VALUES ('294', 'S/S', '1121-0625-P5', 'ENTREGA SANTIAGO REYES  P.O 9150460-00', '0', null, null, null, '2012-01-17', '1', '1', null);
INSERT INTO `producto` VALUES ('295', 'S/S', '1121-0624-P5', 'ENTREGA SANTIAGO REYES  P.O 9150460-00', '0', null, null, null, '2012-01-17', '1', '1', null);
INSERT INTO `producto` VALUES ('296', 'S/S', '1121-0626-P5', 'ENTREGA SANTIAGO REYES  P.O 9150460-00', '0', null, null, null, '2012-01-17', '1', '1', null);
INSERT INTO `producto` VALUES ('297', 'S/S', '1121-0627-P5', 'ENTREGA SANTIAGO REYES  P.O 9150460-00', '0', null, null, null, '2012-01-17', '1', '1', null);
INSERT INTO `producto` VALUES ('298', 'S/S', 'Z-230PJ', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-09-05', '12', '1', null);
INSERT INTO `producto` VALUES ('299', 'CCQ19300LH0', '74\'12358\'02 B0', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-01-12', '22', '1', null);
INSERT INTO `producto` VALUES ('300', 'CCQ19300LLC', '74\'12358\'02 B0', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-01-12', '22', '1', null);
INSERT INTO `producto` VALUES ('301', 'CCQ19300LL7', '74\'12358\'02 B0', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-01-12', '22', '1', null);
INSERT INTO `producto` VALUES ('302', 'T26P0909000630', 'SIP-T26P', 'PROPIEDAD CINETO (INCLUYE: CABLE DE RED, CD MANUAL, ADAPTADOR)', '0', null, null, null, '2010-03-01', '1', '1', null);
INSERT INTO `producto` VALUES ('303', 'T26P0909000687', 'SIP-T26P', 'SE RETIRA DE IMPREXCOM PARA PRUEBAS', '0', null, null, null, '2012-08-08', '1', '1', null);
INSERT INTO `producto` VALUES ('304', 'T26P0909000647', 'SIP-T26P', 'PROPIEDAD CINETO (INCLUYE: CABLE DE RED, CD MANUAL, ADAPTADOR)', '0', null, null, null, '2010-03-01', '1', '1', null);
INSERT INTO `producto` VALUES ('305', 'T26P0909000663', 'SIP-T26P', 'DEVOLUCION DE SISMODE ( SE REALIZA MANTENIMIENTO SOLO SE CAMBIO EL TELEFONOLO DEMAS ESTA NUEVO)', '0', null, null, null, '2015-09-21', '1', '1', null);
INSERT INTO `producto` VALUES ('306', 'S/S', 'MRD-RT004', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-02-01', '3', '1', null);
INSERT INTO `producto` VALUES ('307', 'M0459\'0000754', '8904133006705', 'DHL 3338321206', '0', null, null, null, '2014-12-16', '3', '1', null);
INSERT INTO `producto` VALUES ('308', 'C0289\'0008767', '8904133004183', 'DHL 3338321206', '0', null, null, null, '2014-12-16', '3', '1', null);
INSERT INTO `producto` VALUES ('309', 'C0289\'0008790', '8904133004183', 'DHL 3338321206', '0', null, null, null, '2014-12-16', '3', '1', null);
INSERT INTO `producto` VALUES ('310', 'C0294\'0000580', '8904133004602', 'DHL 3338321206', '0', null, null, null, '2014-12-16', '3', '1', null);
INSERT INTO `producto` VALUES ('311', 'C291\'000396', '8904133004152', 'DHL 3338321206', '0', null, null, null, '2014-12-16', '3', '1', null);
INSERT INTO `producto` VALUES ('312', 'C0296\'0000244', '8904133004664', 'DHL 3338321206', '0', null, null, null, '2014-12-16', '3', '1', null);
INSERT INTO `producto` VALUES ('313', 'M0328\'0001048', '8904133004244', 'DHL 3338321206', '0', null, null, null, '2014-12-16', '3', '1', null);
INSERT INTO `producto` VALUES ('314', 'FD1128000156', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('315', 'FD1128000158', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('316', 'FD1128000151', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('317', 'FD1128000157', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('318', 'FD1128000488', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('319', 'FD1128000152', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('320', 'FD1128000142', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('321', 'FD1128000153', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('322', 'FD1133000607', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('323', 'FD1128000141', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('324', 'FD1128000143', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('325', 'FD1133000609', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('326', 'FD1128000150', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('327', 'FD1128000144', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('328', 'FD1128000149', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('329', 'FD1128000145', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('330', 'FD1128000455', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '25', '1', null);
INSERT INTO `producto` VALUES ('331', 'FD1128000482', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('332', 'FD1128000456', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('333', 'FD1128000460', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('334', 'FD1133000605', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('335', 'FD1128000484', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('336', 'FD1128000458', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('337', 'FD1128000154', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('338', 'FD1128000485', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('339', 'FD1128000148', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('340', 'FD1128000155', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('341', 'FD1128000160', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('342', 'FD1128000159', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('343', 'FD1128000487', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('344', 'FD1128000457', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('345', 'FD1128000481', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('346', 'FD1133000603', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('347', 'FD1128000490', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('348', 'FD1133000610', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('349', 'FD1128000486', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('350', 'FD1128000459', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('351', 'FD1128000146', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('352', 'FD1133000604', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('353', 'FD1128000489', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('354', 'FD1133000602', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('355', 'FD1133000608', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('356', 'FD1133000601', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('357', 'FD1133000606', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('358', 'FD1128000483', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('359', 'FD1128000147', 'C10', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('360', 'YG5C3900102I3', '4520800', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-05-20', '3', '1', null);
INSERT INTO `producto` VALUES ('361', 'YG5C39001014Z', '4520800', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-05-20', '3', '1', null);
INSERT INTO `producto` VALUES ('362', 'FA6447001908', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 17', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('363', 'FA6447001946', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 12', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('364', 'FA6444002122', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 6', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('365', 'FA6447001944', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 12', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('366', 'FA6444002369', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 8', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('367', 'FA6447001949', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 12', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('368', 'FA6447000937', 'C58P', 'GUIA AERIA (41N02 03475) CAJA1', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('369', 'FA6447001948', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 12', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('370', 'FA6444002130', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 6', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('371', 'FA6444002124', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 6', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('372', 'FA6444002129', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 6', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('373', 'FA6444002121', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 6', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('374', 'FA6447000990', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 5', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('375', 'FA6447001478', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 14', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('376', 'FA6447000988', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 5', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('377', 'FA6447000987', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 5', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('378', 'FA6447000986', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 5', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('379', 'FA6447000985', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 5', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('380', 'FA6447000984', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 5', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('381', 'FA6444002123', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 6', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('382', 'FA1132001153', 'C58P', 'RECUPERACION', '0', null, null, null, '2016-09-12', '18', '1', null);
INSERT INTO `producto` VALUES ('383', 'FA6447000989', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 5', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('384', 'FA6444002126', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 6', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('385', 'FA6444002365', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 8', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('386', 'FA6444002364', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 8', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('387', 'FA6444002363', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 8', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('388', 'FA6444002361', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 8', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('389', 'FA6444002366', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 8', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('390', 'FA1133002508', 'C58P', 'RECUPERACION SIN AURICULAR SIN CABLE', '0', null, null, null, '2016-09-12', '18', '1', null);
INSERT INTO `producto` VALUES ('391', 'FA6447001008', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 7 - NO FUNCIONA', '0', null, null, null, '2014-12-01', '18', '1', null);
INSERT INTO `producto` VALUES ('392', 'FA6447001004', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 7', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('393', 'FA6444002367', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 8', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('394', 'FA6447001005', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 7', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('395', 'FA6447001009', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 7', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('396', 'FA6444002362', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 8', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('397', 'FA6447001010', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 7', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('398', 'FA6447000868', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 21 (DIFERENCIA ENTRE LA CAJA EXTERNA Y LA CAJAS DE LOS TELEFONOS)0C383E062146', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('399', 'FA6447001942', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 12', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('400', 'FA6447001941', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 12', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('401', 'FA6447000503', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 10 NO ACTUALIZA', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('402', 'FA6444002370', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 8', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('403', 'FA6447001947', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 12', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('404', 'FA6447000867', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 21 (DIFERENCIA ENTRE LA CAJA EXTERNA Y LA CAJAS DE LOS TELEFONOS)0C383E062144', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('405', 'FA1133002166', 'C58P', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('406', 'FA2126001795', 'C58P', 'DEVUELVE IMPREXCOM DE PERU', '0', null, null, null, '2015-08-06', '24', '1', null);
INSERT INTO `producto` VALUES ('407', 'FA6447000983', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 5', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('408', 'FA1132001154', 'C58P', 'REGRESO DE OFICINA COMERCIAL DEL PERU ECUADOR (SIN CABLE DE RED)', '0', null, null, null, '2015-04-17', '1', '1', null);
INSERT INTO `producto` VALUES ('409', 'FA2126001754', 'C58P', 'RECUPERACION - NO FUNCIONA DHCP DE WAN SIN ACCESORIOS', '0', null, null, null, '2016-09-12', '18', '1', null);
INSERT INTO `producto` VALUES ('410', 'FA6444002125', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 6', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('411', 'FA6447001906', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 17', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('412', 'FA6447001943', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 12', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('413', 'FA6447001907', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 17', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('414', 'FA6447000866', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 21 (DIFERENCIA ENTRE LA CAJA EXTERNA Y LA CAJAS DE LOS TELEFONOS)0C383E062142', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('415', 'FA6447000865', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 21 (DIFERENCIA ENTRE LA CAJA EXTERNA Y LA CAJAS DE LOS TELEFONOS)0C383E062140', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('416', 'FA6447000864', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 21 (DIFERENCIA ENTRE LA CAJA EXTERNA Y LA CAJAS DE LOS TELEFONOS)0C383E06213E', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('417', 'FA6447000863', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 21 (DIFERENCIA ENTRE LA CAJA EXTERNA Y LA CAJAS DE LOS TELEFONOS)0C383E06213C', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('418', 'FA6447000862', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 21 (DIFERENCIA ENTRE LA CAJA EXTERNA Y LA CAJAS DE LOS TELEFONOS)0C383E06213A', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('419', 'FA6447000861', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 21 (DIFERENCIA ENTRE LA CAJA EXTERNA Y LA CAJAS DE LOS TELEFONOS)0C383E062138', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('420', 'FA6447001950', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 12', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('421', 'FA6447000869', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 21 (DIFERENCIA ENTRE LA CAJA EXTERNA Y LA CAJAS DE LOS TELEFONOS)0C383E062148', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('422', 'FA6444002368', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 8', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('423', 'FA6444002128', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 6', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('424', 'FA6444002127', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 6', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('425', 'FA6447000870', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 21 (DIFERENCIA ENTRE LA CAJA EXTERNA Y LA CAJAS DE LOS TELEFONOS)0C383E06214A', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('426', 'FA1132001310', 'C58P', 'DEVOLUCION ANDE PETROLEM', '0', null, null, null, '2013-10-18', '1', '1', null);
INSERT INTO `producto` VALUES ('427', 'FA1133002168', 'C58P', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('428', 'FA6447001686', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 4', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('429', 'FA6447001685', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 4', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('430', 'FA6447001684', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 4', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('431', 'FA6447000933', 'C58P', 'GUIA AERIA (41N02 03475) CAJA1', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('432', 'FA6447001682', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 4', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('433', 'FA6447000931', 'C58P', 'GUIA AERIA (41N02 03475) CAJA1', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('434', 'FA6447000940', 'C58P', 'GUIA AERIA (41N02 03475) CAJA1', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('435', 'FA2126001750', 'C58P', 'DEVOLUCION ENTREGAS ESPECIALES(SIN CABLE DE RED)', '0', null, null, null, '2014-09-04', '1', '1', null);
INSERT INTO `producto` VALUES ('436', 'FA6447000938', 'C58P', 'GUIA AERIA (41N02 03475) CAJA1', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('437', 'FA6447001688', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 4', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('438', 'FA6447000936', 'C58P', 'GUIA AERIA (41N02 03475) CAJA1', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('439', 'FA1133002192', 'C58P', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('440', 'FA2126001724', 'C58P', 'DEVOLUCION ENTREGAS ESPECIALES(SIN CABLE DE RED)', '0', null, null, null, '2014-09-05', '1', '1', null);
INSERT INTO `producto` VALUES ('441', 'FA1133002163', 'C58P', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('442', 'fa2126001748', 'C58P', 'DEVOLUCION MUTUALISTA PICHINCHA', '0', null, null, null, '2013-09-26', '1', '1', null);
INSERT INTO `producto` VALUES ('443', 'FA1133002191', 'C58P', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('444', 'FA1133002170', 'C58P', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('445', 'FA1133002169', 'C58P', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('446', 'FA6447000939', 'C58P', 'GUIA AERIA (41N02 03475) CAJA1', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('447', 'FA2126001734', 'C58P', 'DEVOLUCION ENTREGAS ESPECIALES(SIN CABLE DE RED)', '0', null, null, null, '2014-09-10', '1', '1', null);
INSERT INTO `producto` VALUES ('448', 'FA1132001308', 'C58P', 'GUIA AEREA - SZX 841834', '0', null, null, null, '2013-06-07', '1', '1', null);
INSERT INTO `producto` VALUES ('449', 'FA1133002198', 'C58P', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('450', 'FA1133002195', 'C58P', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('451', 'fa2126001733', 'C58P', 'DEVOLUCION MUTUALISTA PICHINCHA', '0', null, null, null, '2013-09-26', '1', '1', null);
INSERT INTO `producto` VALUES ('452', 'FA1133002193', 'C58P', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('453', 'FA6447000982', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 5', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('454', 'FA1133002197', 'C58P', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('455', 'FA6447000935', 'C58P', 'GUIA AERIA (41N02 03475) CAJA1', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('456', 'FA6447001687', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 4', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('457', 'FA2126001794', 'C58P', 'DEVOLUCION ENTREGAS ESPECIALES(SIN CABLE DE RED)', '0', null, null, null, '2014-09-10', '1', '1', null);
INSERT INTO `producto` VALUES ('458', 'FA6447001683', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 4', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('459', 'FA2126001709', 'C58P', 'DEVOLUCION ENTREGAS ESPECIALES(SIN CABLE DE RED)', '0', null, null, null, '2014-09-10', null, '1', null);
INSERT INTO `producto` VALUES ('460', 'FA2126001735', 'C58P', 'DEVOLUCION ENTREGAS ESPECIALES(SIN CABLE DE RED)', '0', null, null, null, '2014-09-10', '1', '1', null);
INSERT INTO `producto` VALUES ('461', 'FA1133002196', 'C58P', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('462', 'FA6447001681', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 4', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('463', 'FA6447001471', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 14', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('464', 'FA6447000981', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 5', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('465', 'FA6447001690', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 4', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('466', 'FA6447001689', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 4', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('467', 'FA2126001736', 'C58P', 'DEVOLUCION ENTREGAS ESPECIALES(SIN CABLE DE RED)', '0', null, null, null, '2014-09-10', '1', '1', null);
INSERT INTO `producto` VALUES ('468', 'FA2126001738', 'C58P', 'DEVOLUCION ENTREGAS ESPECIALES( SIN CABLE DE RED)', '0', null, null, null, '2014-09-04', '1', '1', null);
INSERT INTO `producto` VALUES ('469', 'FA2126001737', 'C58P', 'DEVOLUCION ENTREGAS ESPECIALES(SIN CABLE DE RED)', '0', null, null, null, '2014-09-04', '1', '1', null);
INSERT INTO `producto` VALUES ('470', 'FA2126001755', 'C58P', 'DEVOLUCION ENTREGAS ESPECIALES(SIN CABLE DE RED)', '0', null, null, null, '2014-09-04', '1', '1', null);
INSERT INTO `producto` VALUES ('471', 'FA1133002194', 'C58P', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('472', 'FA2126001591', 'C58P', 'DEVOLUCION ENTREGAS ESPECIALES(SIN CABLE DE RED)', '0', null, null, null, '2014-09-04', '1', '1', null);
INSERT INTO `producto` VALUES ('473', 'FA1133002167', 'C58P', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('474', 'FA2126001732', 'C58P', 'DEVOLUCION ENTREGAS ESPECIALES(SIN CABLE DE RED)', '0', null, null, null, '2014-09-04', '1', '1', null);
INSERT INTO `producto` VALUES ('475', 'FA6447000934', 'C58P', 'GUIA AERIA (41N02 03475) CAJA1', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('476', 'FA2126001723', 'C58P', 'DEVOLUCION ENTREGAS ESPECIALES(SIN CABLE DE RED)', '0', null, null, null, '2014-09-04', '1', '1', null);
INSERT INTO `producto` VALUES ('477', 'FA2126001729', 'C58P', 'DEVOLUCION ENTREGAS ESPECIALES(SIN CABLE DE RED)', '0', null, null, null, '2014-09-04', '1', '1', null);
INSERT INTO `producto` VALUES ('478', 'FA1133002643', 'C58P', 'DEVOLUCION ENTREGAS ESPECIALES(SIN CABLE DE RED)', '0', null, null, null, '2014-09-04', '1', '1', null);
INSERT INTO `producto` VALUES ('479', 'FA1133002162', 'C58P', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('480', 'FA2126001646', 'C58P', 'DEVOLUCION ENTREGAS ESPECIALES (SIN CABLE DE RED)', '0', null, null, null, '2014-09-04', '1', '1', null);
INSERT INTO `producto` VALUES ('481', 'FA2126001728', 'C58P', 'DEVOLUCION ENTREGAS ESPECIALES (SIN CABLE DE RED)', '0', null, null, null, '2014-09-04', '1', '1', null);
INSERT INTO `producto` VALUES ('482', 'FA1133002199', 'C58P', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('483', 'FA2126001733', 'C58P', 'DEVOLUCION ENTREGAS ESPECIALES(SIN CABLE DE RED)', '0', null, null, null, '2014-09-05', '1', '1', null);
INSERT INTO `producto` VALUES ('484', 'FA1133002648', 'C58P', 'DEVOLUCION ENTREGAS ESPECIALES(SIN CABLE DE RED)', '0', null, null, null, '2014-09-04', '1', '1', null);
INSERT INTO `producto` VALUES ('485', 'FA6447001945', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 12', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('486', 'FA6447001905', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 17', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('487', 'FA6447001904', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 17', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('488', 'FA6447001903', 'C58P', 'GUIA AERIA (41N02 03475) CAJA 17', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('489', 'FA1132001309', 'C58P', 'DEVOLUCION ANDES PETROLEM', '0', null, null, null, '2013-10-18', '1', '1', null);
INSERT INTO `producto` VALUES ('490', 'FA1133002063', 'C58P', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('491', 'FA1133002070', 'C58P', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('492', 'FA2126001747', 'C58P', 'DEVOLUCION ENTREGAS ESPECIALES(SIN CABLE DE RED)', '0', null, null, null, '2014-09-04', '1', '1', null);
INSERT INTO `producto` VALUES ('493', 'FA2126001642', 'C58P', 'DEVOLUCION MUTUALISTA PICHINCHA', '0', null, null, null, '2013-09-26', '1', '1', null);
INSERT INTO `producto` VALUES ('494', 'FA1133002161', 'C58P', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('495', 'FA1133002165', 'C58P', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('496', 'FA1133002164', 'C58P', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('497', 'FA1133002067', 'C58P', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('498', 'FA1133002066', 'C58P', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('499', 'FA1133002065', 'C58P', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('500', 'FA1133002062', 'C58P', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('501', 'FA2126001725', 'C58P', 'DEVOLUCION ENTREGAS ESPECIALES(SIN CABLE DE RED)', '0', null, null, null, '2014-09-04', '1', '1', null);
INSERT INTO `producto` VALUES ('502', 'FA2126001641', 'C58P', 'DEVOLUCION ENTREGAS ESPECIALES(SIN CABLE DE RED)', '0', null, null, null, '2014-09-04', '1', '1', null);
INSERT INTO `producto` VALUES ('503', 'FA2126001758', 'C58P', 'DEVOLUCION ENTREGAS ESPECIALES(SIN CABLE DE RED)', '0', null, null, null, '2014-09-05', '1', '1', null);
INSERT INTO `producto` VALUES ('504', 'FA2126001739', 'C58P', 'DEVOLUCION ENTREGAS ESPECIALES(SIN CABLE DE RED)', '0', null, null, null, '2014-09-05', '1', '1', null);
INSERT INTO `producto` VALUES ('505', 'FA1133002061', 'C58P', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('506', 'FA1133002069', 'C58P', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('507', '80139155', 'C62P', 'GUIA AERE 7377664766', '0', null, null, null, '2012-06-27', '1', '1', null);
INSERT INTO `producto` VALUES ('508', '80193781', 'C62P', 'AEREA SZX831959 MAC:00A859C77ED4', '0', null, null, null, '2012-09-26', '1', '1', null);
INSERT INTO `producto` VALUES ('509', '80193786', 'C62P', 'AEREA SZX831959 MAC:00A859C77EDE', '0', null, null, null, '2012-09-26', '1', '1', null);
INSERT INTO `producto` VALUES ('510', '80139368', 'C62P', 'RECUPERACION TELPROYEC', '0', null, null, null, '2016-09-12', '3', '1', null);
INSERT INTO `producto` VALUES ('511', '80193787', 'C62P', 'AEREA SZX831959 MAC:00A859C77EE0', '0', null, null, null, '2012-09-26', '1', '1', null);
INSERT INTO `producto` VALUES ('512', '80194002', 'C62P', 'AEREA SZX831959 MAC:00A859C7808E', '0', null, null, null, '2012-09-26', '1', '1', null);
INSERT INTO `producto` VALUES ('513', '80138888', 'C62P', 'GUIA AERE 7377664766 (RECUPERADO DE POSTMODE)', '0', null, null, null, '2012-06-27', '1', '1', null);
INSERT INTO `producto` VALUES ('514', '80194003', 'C62P', 'AEREA SZX831959 MAC:00A859C78090', '0', null, null, null, '2012-09-26', '1', '1', null);
INSERT INTO `producto` VALUES ('515', '80193729', 'C62P', 'AEREA SZX831959 MAC:00A859C77E6C', '0', null, null, null, '2012-09-26', '1', '1', null);
INSERT INTO `producto` VALUES ('516', '80194006', 'C62P', 'AEREA SZX831959 MAC:00A859C78096', '0', null, null, null, '2012-09-26', '1', '1', null);
INSERT INTO `producto` VALUES ('517', '80194027', 'C62P', 'DEVOLUCION ENTREGAS ESPECIALES(SIN CABLE DE RED)', '0', null, null, null, '2014-09-10', '1', '1', null);
INSERT INTO `producto` VALUES ('518', '80139362', 'C62P', 'RECUPERACION TELPROYEC SIN CABLE DE AURICULAR', '0', null, null, null, '2016-09-12', '3', '1', null);
INSERT INTO `producto` VALUES ('519', '80138963', 'C62P', 'RECUPERACION TELPROYEC', '0', null, null, null, '2016-09-12', '3', '1', null);
INSERT INTO `producto` VALUES ('520', '80193824', 'C62P', 'AEREA SZX831959 MAC:00A859C77F2A', '0', null, null, null, '2012-09-26', '1', '1', null);
INSERT INTO `producto` VALUES ('521', '80138945', 'C62P', 'RECUPERACION TELPROYEC', '0', null, null, null, '2016-09-12', '3', '1', null);
INSERT INTO `producto` VALUES ('522', '80138949', 'C62P', 'RECUPERACION TELPROYEC', '0', null, null, null, '2016-09-12', '3', '1', null);
INSERT INTO `producto` VALUES ('523', '80193782', 'C62P', 'AEREA SZX831959 MAC:00A859C77ED6', '0', null, null, null, '2012-09-26', '1', '1', null);
INSERT INTO `producto` VALUES ('524', '80139367', 'C62P', 'RECUPERACION TELPROYEC - REPARACION AURICULAR - ALAMBRE SIN PARLANTE', '0', null, null, null, '2016-09-12', '3', '1', null);
INSERT INTO `producto` VALUES ('525', '80138966', 'C62P', 'RECUPERACION TELPROYEC', '0', null, null, null, '2016-09-12', '3', '1', null);
INSERT INTO `producto` VALUES ('526', '80138890', 'C62P', 'CINETO-014-12', '0', null, null, null, '2013-04-25', '1', '1', null);
INSERT INTO `producto` VALUES ('527', '80139156', 'C62P', 'RECUPERACION TELPROYEC', '0', null, null, null, '2016-09-12', '3', '1', null);
INSERT INTO `producto` VALUES ('528', 'GD7149000387', 'X3', 'GUIA AERIA (41N02 03475) CAJA 24 EN PUESTO DE SANTY P.', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('529', 'FF3133000681', 'D800', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('530', 'FF3133000646', 'D800', 'DEVOLUCION', '0', null, null, null, '2013-12-18', '1', '1', null);
INSERT INTO `producto` VALUES ('531', 'FF3133000678', 'D800', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-07-15', '1', '1', null);
INSERT INTO `producto` VALUES ('532', 'FZ6249000033', 'D900', 'GUIA AERIA (41N02 03475) CAJA1', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('533', 'FZ6249000093', 'D900', 'GUIA AERIA (41N02 03475) CAJA 24', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('534', 'FZ6249000034', 'D900', 'GUIA AERIA (41N02 03475) CAJA 2', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('535', 'FZ6249000036', 'D900', 'GUIA AERIA (41N02 03475) CAJA1', '0', null, null, null, '2014-12-01', '1', '1', null);
INSERT INTO `producto` VALUES ('536', 'S/S', '1AB1747700033', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2011-02-25', '1', '1', null);
INSERT INTO `producto` VALUES ('537', 'S/S', 'SFP-401101', 'COMPRA COPPER SYSTEMS (Factura 4400 )', '0', null, null, null, '2017-01-30', '1', '1', null);
INSERT INTO `producto` VALUES ('538', 'S/S', 'SFP-401101', 'ENTREGA SANTIGO REYES (MARCA SIGMA)', '0', null, null, null, '2016-10-03', '11', '1', null);
INSERT INTO `producto` VALUES ('539', 'S/S', '1309-0054', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2012-01-17', '1', '1', null);
INSERT INTO `producto` VALUES ('540', 'S/S', 'Z9530003901A', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-01-29', '3', '1', null);
INSERT INTO `producto` VALUES ('541', '23HQUNH97121060A', '966-00004-13B', 'PASO INVENTARIO ALU', '0', null, null, null, '2015-10-07', '26', '1', null);
INSERT INTO `producto` VALUES ('542', '23HQUNH97121060C', '966-00004-13B', 'ENTREG ALCATEL LUCENT', '0', null, null, null, '2015-10-07', '26', '1', null);
INSERT INTO `producto` VALUES ('543', '23HQUNH971210608', '966-00004-13B', 'PASO INVENTARIO ALU', '0', null, null, null, '2015-10-07', '26', '1', null);
INSERT INTO `producto` VALUES ('544', '01XD38000235M', '4340002', 'INTELBRAS', '0', null, null, null, '2016-09-14', '21', '1', null);
INSERT INTO `producto` VALUES ('545', '1106312033408606', 'SIP-T38G', 'ENTREGA SANTIAGO REYES GUIA MIA351317', '0', null, null, null, '2012-08-03', '1', '1', null);
INSERT INTO `producto` VALUES ('546', '1106312033408610', 'SIP-T38G', 'DEVOLUCION TELMAT (UBICADO)', '0', null, null, null, '2016-05-02', '3', '1', null);
INSERT INTO `producto` VALUES ('547', '1106312033408598', 'SIP-T38G', 'ENTREGA SANTIAGO REYES GUIA MIA351317', '0', null, null, null, '2012-08-03', '1', '1', null);
INSERT INTO `producto` VALUES ('548', '1106312033408596', 'SIP-T38G', 'ENTREGA SANTIAGO REYES GUIA MIA351317', '0', null, null, null, '2012-08-03', '1', '1', null);
INSERT INTO `producto` VALUES ('549', '1106311063400697', 'SIP-T38G', 'ENTREGA SANTIAQGO REYES', '0', null, null, null, '2012-08-03', '1', '1', null);
INSERT INTO `producto` VALUES ('550', '1106312033408597', 'SIP-T38G', 'ENTREGA SANTIAGO REYES GUIA MIA351317', '0', null, null, null, '2012-08-03', '1', '1', null);
INSERT INTO `producto` VALUES ('551', '1106311063400696', 'SIP-T38G', 'ENTREGA SANTIAQGO REYES', '0', null, null, null, '2012-08-03', '1', '1', null);
INSERT INTO `producto` VALUES ('552', '1106312033408609', 'SIP-T38G', 'ENTREGA SANTIAGO REYES GUIA MIA351317', '0', null, null, null, '2012-08-03', '1', '1', null);
INSERT INTO `producto` VALUES ('553', '1106312033408607', 'SIP-T38G', 'ENTREGA SANTIAGO REYES GUIA MIA351317', '0', null, null, null, '2012-08-03', '1', '1', null);
INSERT INTO `producto` VALUES ('554', '1106311063400700', 'SIP-T38G', 'ENTREGA SANTIAQGO REYES', '0', null, null, null, '2012-08-03', '1', '1', null);
INSERT INTO `producto` VALUES ('555', '1106312033408600', 'SIP-T38G', 'ENTREGA SANTIAGO REYES GUIA MIA351317', '0', null, null, null, '2012-08-03', '1', '1', null);
INSERT INTO `producto` VALUES ('556', 'S/S', '1265-0011', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2012-01-17', '1', '1', null);
INSERT INTO `producto` VALUES ('557', '6LIE0400096YI', '4580155', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '3', '1', null);
INSERT INTO `producto` VALUES ('558', '6LIE040005000', '4580155', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '3', '1', null);
INSERT INTO `producto` VALUES ('559', '6LIE0400049PN', '4580155', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '3', '1', null);
INSERT INTO `producto` VALUES ('560', '6LIE0400060HU', '4580155', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '3', '1', null);
INSERT INTO `producto` VALUES ('561', '6LIE0400006ZW', '4580155', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '3', '1', null);
INSERT INTO `producto` VALUES ('562', 'S/S', '10038769', 'DEVOLUVION COMACO ( NO ES LA QUE SOLICITARON)', '0', null, null, null, '2015-09-07', '1', '1', null);
INSERT INTO `producto` VALUES ('563', '25QK46E970210DB5', '966-00008-02C', 'PASO INVENTARIO ALU', '0', null, null, null, '2015-10-07', '4', '1', null);
INSERT INTO `producto` VALUES ('564', '25QK46E970210E9C', '966-00008-02C', 'PASO INVENTARIO ALU', '0', null, null, null, '2015-10-07', '26', '1', null);
INSERT INTO `producto` VALUES ('565', 'S/S', 'MRD-QD002( A )', 'ENTREGADO POR DHL GUIA AEREA 6599055046 (CHINA)', '0', null, null, null, '2016-12-29', '4', '1', null);
INSERT INTO `producto` VALUES ('566', 'S/S', 'MRD-QD002', 'PO 00062 XIAMEN MAIRDI ELECTRONIC TECHNOLOGY', '0', null, null, null, '2015-07-14', '4', '1', null);
INSERT INTO `producto` VALUES ('567', 'S/S', 'MRD-QD002( C )', 'PO 00062 XIAMEN MAIRDI ELECTRONIC TECHNOLOGY', '0', null, null, null, '2016-08-01', '4', '1', null);
INSERT INTO `producto` VALUES ('568', 'S/S', 'MRD-QD002( C )', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2015-09-02', '3', '1', null);
INSERT INTO `producto` VALUES ('569', 'S/N', 'MRD-QD002', 'ENTREGADO POR DHL GUIA AEREA 6599055046 (CHINA)', '0', null, null, null, '2016-09-27', '4', '1', null);
INSERT INTO `producto` VALUES ('570', '201601001', 'MRD-USB', 'DEVOLUCION LIFE AND HOPE', '0', null, null, null, '2016-01-20', '4', '1', null);
INSERT INTO `producto` VALUES ('571', 'S/S', 'MRD-USB', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-01-20', '4', '1', null);
INSERT INTO `producto` VALUES ('572', 'S/S', 'MRD-QD001', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-09-14', '4', '1', null);
INSERT INTO `producto` VALUES ('573', 'S/N', 'MRD-QD001', 'ENTREGADO POR DHL GUIA AEREA 6599055046 (CHINA)', '0', null, null, null, '2016-09-27', '4', '1', null);
INSERT INTO `producto` VALUES ('574', 'S/S', 'MRD-QD001', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-07-05', '4', '1', null);
INSERT INTO `producto` VALUES ('575', 'S/N', 'MRD-QD011', 'ENTREGADO POR DHL GUIA AEREA 6599055046 (CHINA)', '0', null, null, null, '2016-09-27', '4', '1', null);
INSERT INTO `producto` VALUES ('576', 'S/S', 'MRD-QD011', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2017-01-23', '4', '1', null);
INSERT INTO `producto` VALUES ('577', 'S/S', 'MRD-QD012', 'PO 00062 XIAMEN MAIRDI ELECTRONIC TECHNOLOGY', '0', null, null, null, '2016-09-14', '4', '1', null);
INSERT INTO `producto` VALUES ('578', 'S/S', 'MRD-QD012', 'PO 00062 XIAMEN MAIRDI ELECTRONIC TECHNOLOGY', '0', null, null, null, '2015-05-12', '4', '1', null);
INSERT INTO `producto` VALUES ('579', 'YHS3214050001676', 'YHS32', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2014-09-18', '1', '1', null);
INSERT INTO `producto` VALUES ('580', 'YHS3214050001667', 'YHS32', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2014-09-18', '1', '1', null);
INSERT INTO `producto` VALUES ('581', 'YHS3214050001661', 'YHS32', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2014-09-18', '1', '1', null);
INSERT INTO `producto` VALUES ('582', 'YHS3214050001663', 'YHS32', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2014-09-18', '1', '1', null);
INSERT INTO `producto` VALUES ('583', 'YHS3214050001665', 'YHS32', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2014-09-18', '1', '1', null);
INSERT INTO `producto` VALUES ('584', 'YHS3213110000242', 'YHS32', 'DEVOLUCION DATA VOZ', '0', null, null, null, '2015-04-27', '1', '1', null);
INSERT INTO `producto` VALUES ('585', 'YHS3214050001670', 'YHS32', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2014-09-18', '1', '1', null);
INSERT INTO `producto` VALUES ('586', 'YHS3211060001302', 'YHS32', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-03-12', '1', '1', null);
INSERT INTO `producto` VALUES ('587', 'YHS3214050001673', 'YHS32', 'DEVOLUCION DATA VOZ', '0', null, null, null, '2015-04-27', '1', '1', null);
INSERT INTO `producto` VALUES ('588', 'YHS3213110000244', 'YHS32', 'DEVOLUCION DATA VOZ', '0', null, null, null, '2015-04-27', '1', '1', null);
INSERT INTO `producto` VALUES ('589', 'YHS3213110000250', 'YHS32', 'DEVOLUCION DATA VOZ', '0', null, null, null, '2015-04-27', '1', '1', null);
INSERT INTO `producto` VALUES ('590', 'YHS3210110002383', 'YHS32', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2011-06-01', '1', '1', null);
INSERT INTO `producto` VALUES ('591', 'YHS3214050001669', 'YHS32', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2014-09-18', '1', '1', null);
INSERT INTO `producto` VALUES ('592', '50-0491-0091', '9137430E', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2012-02-16', '1', '1', null);
INSERT INTO `producto` VALUES ('593', 'S/N', '4116R', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-29', '2', '1', null);
INSERT INTO `producto` VALUES ('594', 'S/N', '74259', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-29', '2', '1', null);
INSERT INTO `producto` VALUES ('595', 'S/N', '74574', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-29', '2', '1', null);
INSERT INTO `producto` VALUES ('596', 'S/N', '74HC00', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-29', '2', '1', null);
INSERT INTO `producto` VALUES ('597', 'S/N', '74HC161', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-29', '2', '1', null);
INSERT INTO `producto` VALUES ('598', 'S/N', '74HC4316', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-29', '2', '1', null);
INSERT INTO `producto` VALUES ('599', 'S/N', '74HC74', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-29', '2', '1', null);
INSERT INTO `producto` VALUES ('600', 'S/N', '75C188', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-29', '2', '1', null);
INSERT INTO `producto` VALUES ('601', 'S/N', '75C189AN', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-29', '2', '1', null);
INSERT INTO `producto` VALUES ('602', 'S/N', 'AM7910PC', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-29', '2', '1', null);
INSERT INTO `producto` VALUES ('603', 'S/N', 'AT28HC256', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-29', '2', '1', null);
INSERT INTO `producto` VALUES ('604', 'S/N', 'AT29C040A', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-29', '2', '1', null);
INSERT INTO `producto` VALUES ('605', 'S/N', 'D43256BCZ', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-29', '2', '1', null);
INSERT INTO `producto` VALUES ('606', 'S/N', 'EF7910JLD', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-29', '2', '1', null);
INSERT INTO `producto` VALUES ('607', 'S/N', 'HD63C09EP', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-28', '2', '1', null);
INSERT INTO `producto` VALUES ('608', 'S/N', 'M5M5256', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-29', '2', '1', null);
INSERT INTO `producto` VALUES ('609', 'S/N', 'MC14002BCLD', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-29', '2', '1', null);
INSERT INTO `producto` VALUES ('610', 'S/N', 'MC1489P', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-29', '2', '1', null);
INSERT INTO `producto` VALUES ('611', 'S/N', 'MC54HC273AJ', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-29', '2', '1', null);
INSERT INTO `producto` VALUES ('612', 'S/N', 'MC68901P', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-28', '2', '1', null);
INSERT INTO `producto` VALUES ('613', 'S/N', 'NSC810AN-3I', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-29', '2', '1', null);
INSERT INTO `producto` VALUES ('614', 'S/N', 'P80C31BH', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-29', '2', '1', null);
INSERT INTO `producto` VALUES ('615', 'S/N', 'P80C88A-2', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-28', '2', '1', null);
INSERT INTO `producto` VALUES ('616', 'S/N', 'P9452BJ', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-29', '2', '1', null);
INSERT INTO `producto` VALUES ('617', 'S/N', 'PAL20X8ACNS', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-29', '2', '1', null);
INSERT INTO `producto` VALUES ('618', 'S/N', 'PAL32VX10ACJS', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-29', '2', '1', null);
INSERT INTO `producto` VALUES ('619', 'S/N', 'PEB2085P', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-29', '2', '1', null);
INSERT INTO `producto` VALUES ('620', '21JD0E4B9037786A', '967-00009-04', 'DEVUELVE ANDRES PARRA', '0', null, null, null, '2014-06-26', '27', '1', null);
INSERT INTO `producto` VALUES ('621', 'Q14041058', 'CDV-3VM800', 'CAMARA IP CLIENTE QUE NO PAGO PORTERO', '0', null, null, null, '2016-09-14', '21', '1', null);
INSERT INTO `producto` VALUES ('622', '22MT5389501FDE2D', '962-00010-02 B', 'PASO DE INVENTARIO ALU', '0', null, null, null, '2015-10-07', '26', '1', null);
INSERT INTO `producto` VALUES ('623', '22MT5389501FDE2F', '962-00010-02 B', 'PASO DE INVENTARIO ALU', '0', null, null, null, '2015-10-07', '26', '1', null);
INSERT INTO `producto` VALUES ('624', '22MT5389501FDE2E', '962-00010-02 B', 'PASO DE INVENTARIO ALU', '0', null, null, null, '2015-10-07', '26', '1', null);
INSERT INTO `producto` VALUES ('625', '2009P10091300195', 'VP-2009', 'GUIA AEREA MIAGUQ2415998 PROPIEDAD CINETO', '0', null, null, null, '2011-02-04', '1', '1', null);
INSERT INTO `producto` VALUES ('626', '2009P10101300124', 'VP-2009', 'ENTREGA SANTIAGO REYES SIN DOCUMENTOS', '0', null, null, null, '2011-11-18', '1', '1', null);
INSERT INTO `producto` VALUES ('627', '2009P10101300125', 'VP-2009', 'DEVOLUCIÓN TELMAT (UBICADO)', '0', null, null, null, '2016-05-02', '3', '1', null);
INSERT INTO `producto` VALUES ('628', '2009P10101300193', 'VP-2009', 'DEVOLUCION PRUEBAS PANASONIC', '0', null, null, null, '2013-12-18', '3', '1', null);
INSERT INTO `producto` VALUES ('629', 'S/S', 'SL5KJU0011201', 'ENTREGA SANTIAGO REYES (MARCA SIGMA)', '0', null, null, null, '2016-10-03', '11', '1', null);
INSERT INTO `producto` VALUES ('630', 'S/S', 'SKJ-XA3111', 'ENTREGA SANTIAGO REYES (MARCA SIGMA)', '0', null, null, null, '2016-10-03', '11', '1', null);
INSERT INTO `producto` VALUES ('631', 'S/S', 'SKJ-XA3111', 'COMPRA COPPER SYSTEMS (Factura 4400 )', '0', null, null, null, '2017-01-30', '1', '1', null);
INSERT INTO `producto` VALUES ('632', 'S/S', 'SKJXA3111', 'COMPRA COPPER SYSTEMS (Factura 4400 )', '0', null, null, null, '2017-01-30', '1', '1', null);
INSERT INTO `producto` VALUES ('633', 'S/S', 'SKJXA3111', 'ENTREGA SANTIAGO REYES (MARCA SIGMA)', '0', null, null, null, '2016-11-10', '11', '1', null);
INSERT INTO `producto` VALUES ('634', 'S/S', '6018-0097', 'ENTREGA SANTIAGO REYES  P.O 9150460-00', '0', null, null, null, '2012-01-17', '1', '1', null);
INSERT INTO `producto` VALUES ('635', 'S/S', '6993-0136', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2012-01-17', '1', '1', null);
INSERT INTO `producto` VALUES ('636', '1796B001', 'CC364A', 'PROVEDOR LINFONI', '0', null, null, null, '2013-11-05', '1', '1', null);
INSERT INTO `producto` VALUES ('637', 'S/S', '4504500', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '20', '1', null);
INSERT INTO `producto` VALUES ('638', 'S/S', '4504500', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2017-01-23', '20', '1', null);
INSERT INTO `producto` VALUES ('639', 'S/S', 'LL/M', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2012-02-16', '1', '1', null);
INSERT INTO `producto` VALUES ('640', 'CIN06003', 'PB8000', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2015-06-29', '1', '1', null);
INSERT INTO `producto` VALUES ('641', 'M0309\'0001340', '8904133003896', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-12-30', '7', '1', null);
INSERT INTO `producto` VALUES ('642', 'M0309\'0001341', '8904133003896', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-12-30', '7', '1', null);
INSERT INTO `producto` VALUES ('643', 'M1078-0000070', 'SETU VG8', 'ENTREGA SANTIAGO REYES ( estos equipos llego por el caso de envio en mal estado)', '0', null, null, null, '2016-11-24', '7', '1', null);
INSERT INTO `producto` VALUES ('644', 'M1078-0000071', 'SETU VG8', 'ENTREGA SANTIAGO REYES ( estos equipos llego por el caso de envio en mal estado)', '0', null, null, null, '2016-11-24', '7', '1', null);
INSERT INTO `producto` VALUES ('645', '020-099-B-001-39756', '7008-0287-01', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2012-01-17', '1', '1', null);
INSERT INTO `producto` VALUES ('646', 'S/N', '271001', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-28', '2', '1', null);
INSERT INTO `producto` VALUES ('647', 'S/N', '27128', 'REPUSETOS DEL RECICLAJE', '0', null, null, null, '2012-08-28', '2', '1', null);
INSERT INTO `producto` VALUES ('648', 'S/N', '27256', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-28', '2', '1', null);
INSERT INTO `producto` VALUES ('649', 'S/N', '27512', 'REPUESTOS DEL RECICLAJE', '0', null, null, null, '2012-08-28', '2', '1', null);
INSERT INTO `producto` VALUES ('650', 'S/S', 'RMN4018A', 'ARMARIO CINT', '0', null, null, null, '2012-08-30', '6', '1', null);
INSERT INTO `producto` VALUES ('651', 'S/S', 'ATLSP04119AAAA', '', '0', null, null, null, '2015-08-12', '26', '1', null);
INSERT INTO `producto` VALUES ('652', '4r63605494', '30\'42709\'01', 'ARMARIO CINT', '0', null, null, null, '2012-08-30', '6', '1', null);
INSERT INTO `producto` VALUES ('653', 'AAAAC970249026', '1AF00089AAAA04', 'ENTREGADO A CINETO DE ALCATEL', '0', null, null, null, '2012-08-24', '1', '1', null);
INSERT INTO `producto` VALUES ('654', 'B6AD3800026BV', '4520801', 'GUÍA 10327', '0', null, null, null, '2016-07-04', '3', '1', null);
INSERT INTO `producto` VALUES ('655', 'B6AD4000026O7', '4520801', 'GUÍA 10327', '0', null, null, null, '2016-07-04', '3', '1', null);
INSERT INTO `producto` VALUES ('656', 'S/S', 'M-545', 'ARMARIO CINT', '0', null, null, null, '2012-08-30', '6', '1', null);
INSERT INTO `producto` VALUES ('657', '10B399636', 'MR500', 'INCLUYE CABLE DE RED Y FUENTE DE PODER', '0', null, null, null, '2011-07-05', '3', '1', null);
INSERT INTO `producto` VALUES ('658', '10B399640', 'MR500', 'INCLUYE CABLE DE RED Y FUENTE DE PODER', '0', null, null, null, '2011-07-05', '1', '1', null);
INSERT INTO `producto` VALUES ('659', 'M0678\'0000025', '8904133011365', 'DHL 3338321206', '0', null, null, null, '2014-12-16', '3', '1', null);
INSERT INTO `producto` VALUES ('660', 'M0678\'0000021', '8904133011365', 'DHL 3338321206', '0', null, null, null, '2014-12-16', '3', '1', null);
INSERT INTO `producto` VALUES ('661', 'OD12082811680', '4580017', 'INTELBRAS', '0', null, null, null, '2016-09-14', '3', '1', null);
INSERT INTO `producto` VALUES ('662', 'S/S', 'AA-091A', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2017-01-18', '21', '1', null);
INSERT INTO `producto` VALUES ('663', '123380126', 'OM2P', 'DEVUELTO POR ENTREGAS ESPECIALES MAC: AC:86:74:03:8E:70', '0', null, null, null, '2014-06-16', '1', '1', null);
INSERT INTO `producto` VALUES ('664', '157294629', 'OM2P-HS v2', 'MAC: AC:86:74:49:B7:40', '0', null, null, null, '2015-12-29', '22', '1', null);
INSERT INTO `producto` VALUES ('665', '157294595', 'OM2P-HS v2', 'MAC: AC:86:74:49:B6:30', '0', null, null, null, '2015-12-29', '22', '1', null);
INSERT INTO `producto` VALUES ('666', '157294613', 'OM2P-HS v2', 'MAC: AC:86:74:49:B6:C0', '0', null, null, null, '2015-12-29', '22', '1', null);
INSERT INTO `producto` VALUES ('667', '123380079', 'OM2P', 'GUIA AEREA UIO0021938393', '0', null, null, null, '2012-07-17', '1', '1', null);
INSERT INTO `producto` VALUES ('668', '12A300721', 'OM2P', 'ENTREGA SANTIAGO REYES MAC:AC:86:74:0C:DA:30', '0', null, null, null, '2013-03-19', '1', '1', null);
INSERT INTO `producto` VALUES ('669', '123380109', 'OM2P', 'DEVOLUCION STSERVICIOS GYE MAC: AC:86:74:03:8D:E8', '0', null, null, null, '2014-06-16', '1', '1', null);
INSERT INTO `producto` VALUES ('670', '123380110', 'OM2P', 'GUIA AEREA UIO0021938393', '0', null, null, null, '2012-07-17', '1', '1', null);
INSERT INTO `producto` VALUES ('671', '12A300726', 'OM2P', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-03-19', '1', '1', null);
INSERT INTO `producto` VALUES ('672', 'S/S', 'SL0CM023024', 'COMPRA COPPER SYSTEMS (Factura 4400 )', '0', null, null, null, '2017-01-30', '1', '1', null);
INSERT INTO `producto` VALUES ('673', 'S/S', 'ODHOM1P', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2015-12-29', '22', '1', null);
INSERT INTO `producto` VALUES ('674', 'QCDC4800009ZS', '4320083', 'INGRESO DE CREAVLATEK COMPRA DIRECTA', '0', null, null, null, '2017-02-16', '3', '1', null);
INSERT INTO `producto` VALUES ('675', 'S/S', 'SL6APC26271006', 'ENTREGA SANTIAGO REYES (MARCA SIGMA)', '0', null, null, null, '2016-10-03', '11', '1', null);
INSERT INTO `producto` VALUES ('676', 'S/S', 'NPC-6203', 'ENTREGA SANTIAGO REYES (MARCA QUEST)', '0', null, null, null, '2016-10-03', '11', '1', null);
INSERT INTO `producto` VALUES ('677', 'S/S', 'SL6APC2617102', 'COMPRA COPPER SYSTEMS (Factura 4400 )', '0', null, null, null, '2017-01-30', '1', '1', null);
INSERT INTO `producto` VALUES ('678', 'S/S', 'SL6APC2617102', 'ENTREGA SANTIAGO REYES (MARCA SIGMA)', '0', null, null, null, '2016-11-10', '11', '1', null);
INSERT INTO `producto` VALUES ('679', 'S/S', 'PST-1908', 'ENTREGA WILLIAM ROMERO', '0', null, null, null, '2016-10-03', '1', '1', null);
INSERT INTO `producto` VALUES ('680', 'P207700', 'UNSP2000000002', 'ENTREGADO A CINETO DE ALCATEL', '0', null, null, null, '2012-08-24', '1', '1', null);
INSERT INTO `producto` VALUES ('681', 'P207737', 'UNSP2000000002', 'ENTREGADO A CINETO DE ALCATEL', '0', null, null, null, '2012-08-24', '1', '1', null);
INSERT INTO `producto` VALUES ('682', 'S/S', 'POEPASS-01', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2014-06-27', '1', '1', null);
INSERT INTO `producto` VALUES ('683', 'BYL2016106592', 'X00154FMQD', 'ENTREGA SANTIAGO REYES (PAQUETE DE 2 )', '0', null, null, null, '2016-11-10', '3', '1', null);
INSERT INTO `producto` VALUES ('684', 'BYL2016106597', 'X00154FMQD', 'ENTREGA SANTIAGO REYES (PAQUETE DE 2 )', '0', null, null, null, '2016-11-10', '3', '1', null);
INSERT INTO `producto` VALUES ('685', 'BYL2016106584', 'X00154FMQD', 'ENTREGA SANTIAGO REYES (PAQUETE DE 2 )', '0', null, null, null, '2016-11-10', '3', '1', null);
INSERT INTO `producto` VALUES ('686', 'S/S', 'C2007B', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-12-07', '3', '1', null);
INSERT INTO `producto` VALUES ('687', 'S/S', 'X000G810R9', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2017-02-06', '3', '1', null);
INSERT INTO `producto` VALUES ('688', 'S/S', 'APOE02-WM', 'ENTREGA SANTIAGO', '0', null, null, null, '2011-02-08', '3', '1', null);
INSERT INTO `producto` VALUES ('689', 'S/S', '492014-3', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2015-10-02', '10', '1', null);
INSERT INTO `producto` VALUES ('690', 'S/S', 'OCJ-T-F1-05MASCA-F1', 'USADOS 4 NUEVOS 7', '0', null, null, null, '2015-10-20', '10', '1', null);
INSERT INTO `producto` VALUES ('691', 'S/S', '8VFO', 'NUEVO', '0', null, null, null, '2015-10-20', '10', '1', null);
INSERT INTO `producto` VALUES ('692', 'S/S', '9/125', 'NUEVO', '0', null, null, null, '2015-10-20', '10', '1', null);
INSERT INTO `producto` VALUES ('693', 'S/S', '1AB079840007', 'NUEVO', '0', null, null, null, '2015-10-20', '10', '1', null);
INSERT INTO `producto` VALUES ('694', 'S/S', 'P-20021447', 'NUEVO', '0', null, null, null, '2015-10-20', '10', '1', null);
INSERT INTO `producto` VALUES ('695', 'S/S', '3AF00888AFAA', 'DISTANCIAS: 20 M (QTY=1); 10 M (QTY=2); 3 M (QTY=3)', '0', null, null, null, '2015-10-20', '10', '1', null);
INSERT INTO `producto` VALUES ('696', 'S/S', '3AF00888AEAA', 'ENTREGA SANTIAGO REYES (CODIGO ALCATEL) 4M', '0', null, null, null, '2015-10-02', '10', '1', null);
INSERT INTO `producto` VALUES ('697', 'S/S', '98301747.7', 'ENTREGA SANTIAGO REYES ( USADOS ) ( QTY=1 (8M) QTY=8 (5M) QTY=1 (7M) )', '0', null, null, null, '2015-10-02', '10', '1', null);
INSERT INTO `producto` VALUES ('698', 'S/S', '1AB079840016', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2015-10-02', '10', '1', null);
INSERT INTO `producto` VALUES ('699', 'S/S', '1-0233400-0', 'NUEVOS', '0', null, null, null, '2015-10-20', '10', '1', null);
INSERT INTO `producto` VALUES ('700', 'S/S', 'IL03DBRL50DBSCST', '', '0', null, null, null, '2015-08-12', '10', '1', null);
INSERT INTO `producto` VALUES ('701', 'S/S', 'F52054-000', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2015-10-02', '10', '1', null);
INSERT INTO `producto` VALUES ('702', 'S/S', '5617NMA1', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2015-10-02', '10', '1', null);
INSERT INTO `producto` VALUES ('703', 'S/S', 'OCJ-T-F1-OSMASCA-F1', 'ENTREGA SANTIAGO REYES ( NUEVOS=7 USADOS=4 )', '0', null, null, null, '2015-10-01', '10', '1', null);
INSERT INTO `producto` VALUES ('704', 'S/S', '47725', 'NUEVO', '0', null, null, null, '2015-10-20', '10', '1', null);
INSERT INTO `producto` VALUES ('705', 'S/S', 'MS2EP-EP', 'NUEVOS', '0', null, null, null, '2015-10-20', '10', '1', null);
INSERT INTO `producto` VALUES ('706', 'S/S', 'ST-SC', 'USADOS', '0', null, null, null, '2015-10-20', '10', '1', null);
INSERT INTO `producto` VALUES ('707', 'S/S', 'SP-24PP-C6', 'COMPRA COPPER SYSTEMS (Factura 4400 )', '0', null, null, null, '2017-01-30', '1', '1', null);
INSERT INTO `producto` VALUES ('708', 'S/S', 'DT1E8', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2011-02-25', '1', '1', null);
INSERT INTO `producto` VALUES ('709', '29EQ710', '3872C782', 'VENTA', '0', null, null, null, '2012-01-20', '1', '1', null);
INSERT INTO `producto` VALUES ('710', '10923443', '37602837', 'ENTREGADO A CINETO DE ALCATEL', '0', null, null, null, '2012-08-24', '1', '1', null);
INSERT INTO `producto` VALUES ('711', '10923566', '37602837', 'ENTREGADO A CINETO DE ALCATEL', '0', null, null, null, '2012-08-24', '1', '1', null);
INSERT INTO `producto` VALUES ('712', '10923542', '37602837', 'ENTREGADO A CINETO DE ALCATEL', '0', null, null, null, '2012-08-24', '1', '1', null);
INSERT INTO `producto` VALUES ('713', '200131', '37602837', 'ENTREGADO A CINETO DE ALCATEL', '0', null, null, null, '2012-08-24', '1', '1', null);
INSERT INTO `producto` VALUES ('714', '9511', '37606387', 'ARMARIO CINT', '0', null, null, null, '2012-08-30', '6', '1', null);
INSERT INTO `producto` VALUES ('715', 'S/S', '492014-4', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2015-10-20', '10', '1', null);
INSERT INTO `producto` VALUES ('716', 'S/S', 'OCP-U-F0-03MASEN-XX', 'NUEVO', '0', null, null, null, '2015-10-20', '10', '1', null);
INSERT INTO `producto` VALUES ('717', 'S/S', '492014-9', 'ENTREGA SANTIAGO REYES ( NUEVO=4 USADOS=1 )', '0', null, null, null, '2015-10-02', '10', '1', null);
INSERT INTO `producto` VALUES ('718', 'S/S', 'OCP-T-F1-03MASCA-XX', 'NUEVO', '0', null, null, null, '2015-10-20', '10', '1', null);
INSERT INTO `producto` VALUES ('719', 'S/S', 'X0001MGLP1', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-05-15', '1', '1', null);
INSERT INTO `producto` VALUES ('720', 'AHCD2900007NM', '4400145', 'INTELBRAS', '0', null, null, null, '2016-09-14', '21', '1', null);
INSERT INTO `producto` VALUES ('721', 'OELG58', '84693-11', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-10-05', '7', '1', null);
INSERT INTO `producto` VALUES ('722', 'OELG59', '84693-11', 'ENTREGA SANTIGO REYES', '0', null, null, null, '2016-10-05', '7', '1', null);
INSERT INTO `producto` VALUES ('723', 'S/S', '83648-03', 'REPUESTOS PLANTRONICS CT14 - UBICADO', '0', null, null, null, '2016-09-14', '3', '1', null);
INSERT INTO `producto` VALUES ('724', 'S/S', '81086-01', 'ORDEN DE COMPRA 0004887494', '0', null, null, null, '2017-02-20', '3', '1', null);
INSERT INTO `producto` VALUES ('725', 'S/S', '81086-01', 'REPUESTOS PLANTRONICS (Santiago Reyes trae 5 de EEUU )', '0', null, null, null, '2016-09-14', '3', '1', null);
INSERT INTO `producto` VALUES ('726', 'S/S', '72913-01', 'REPUESTOS PLANTRONICS - DENTRO DE LA FUNDA SE LEE P/N 66935-05 EAR TIP KIT CS70', '0', null, null, null, '2016-09-14', '3', '1', null);
INSERT INTO `producto` VALUES ('727', '0N4E1500376VD', '4080107', 'GUÍA 10327 (CAJA 010-1)', '0', null, null, null, '2016-07-04', '28', '1', null);
INSERT INTO `producto` VALUES ('728', '0N4E15006776D', '4080107', 'GUÍA 10327 (CAJA 010)', '0', null, null, null, '2016-07-04', '28', '1', null);
INSERT INTO `producto` VALUES ('729', '0N4E1500939TP', '4080107', 'GUÍA 10327 (CAJA 010-4)', '0', null, null, null, '2016-07-04', '28', '1', null);
INSERT INTO `producto` VALUES ('730', '0N4E1500403OP', '4080107', 'GUÍA 10327 (CAJA 010-3)', '0', null, null, null, '2016-07-04', '28', '1', null);
INSERT INTO `producto` VALUES ('731', '0N4E1500937XY', '4080107', 'GUÍA 10327 (CAJA 010-4)', '0', null, null, null, '2016-07-04', '28', '1', null);
INSERT INTO `producto` VALUES ('732', '0N4E1500940OJ', '4080107', 'GUÍA 10327 (CAJA 010-4)', '0', null, null, null, '2016-07-04', '28', '1', null);
INSERT INTO `producto` VALUES ('733', '0N4E1500374RF', '4080107', 'GUÍA 10327 (CAJA 010-1)', '0', null, null, null, '2016-07-04', '28', '1', null);
INSERT INTO `producto` VALUES ('734', '0N4E1500678SH', '4080107', 'GUÍA 10327 (CAJA 010)', '0', null, null, null, '2016-07-04', '28', '1', null);
INSERT INTO `producto` VALUES ('735', '0N4E1500675HR', '4080107', 'GUÍA 10327 (CAJA 010)', '0', null, null, null, '2016-07-04', '28', '1', null);
INSERT INTO `producto` VALUES ('736', '0N4E15006736H', '4080107', 'GUÍA 10327 (CAJA 010)', '0', null, null, null, '2016-07-04', '28', '1', null);
INSERT INTO `producto` VALUES ('737', '0N4E1500377S9', '4080107', 'GUÍA 10327 (CAJA 010-1)', '0', null, null, null, '2016-07-04', '28', '1', null);
INSERT INTO `producto` VALUES ('738', '0N4E1500371D7', '4080107', 'GUÍA 10327 (CAJA 010-1)', '0', null, null, null, '2016-07-04', '28', '1', null);
INSERT INTO `producto` VALUES ('739', '0N4E15009564C', '4080107', 'GUÍA 10327 (CAJA 010-3)', '0', null, null, null, '2016-07-04', '28', '1', null);
INSERT INTO `producto` VALUES ('740', '0N4E1500936LS', '4080107', 'GUÍA 10327 (CAJA 010-4)', '0', null, null, null, '2016-07-04', '28', '1', null);
INSERT INTO `producto` VALUES ('741', '0N4E1500370KH', '4080107', 'GUÍA 10327 (CAJA 010-1)', '0', null, null, null, '2016-07-04', '28', '1', null);
INSERT INTO `producto` VALUES ('742', '0N4E1500654PZ', '4080107', 'GUÍA 10327 (CAJA 010-4)', '0', null, null, null, '2016-07-04', '28', '1', null);
INSERT INTO `producto` VALUES ('743', '0N4E15006725F', '4080107', 'GUÍA 10327 (CAJA 010)', '0', null, null, null, '2016-07-04', '28', '1', null);
INSERT INTO `producto` VALUES ('744', '0N4E15006710M', '4080107', 'GUÍA 10327 (CAJA 010)', '0', null, null, null, '2016-07-04', '28', '1', null);
INSERT INTO `producto` VALUES ('745', '0N4E15006704S', '4080107', 'GUÍA 10327 (CAJA 010)', '0', null, null, null, '2016-07-04', '28', '1', null);
INSERT INTO `producto` VALUES ('746', '0N4E1500669JM', '4080107', 'GUÍA 10327 (CAJA 010)', '0', null, null, null, '2016-07-04', '28', '1', null);
INSERT INTO `producto` VALUES ('747', '0N4E150037334', '4080107', 'GUÍA 10327 (CAJA 010-1)', '0', null, null, null, '2016-07-04', '28', '1', null);
INSERT INTO `producto` VALUES ('748', '0N4E1500676L8', '4080107', 'GUÍA 10327 (CAJA 010)', '0', null, null, null, '2016-07-04', '28', '1', null);
INSERT INTO `producto` VALUES ('749', '0N4E1500378NB', '4080107', 'GUÍA 10327 (CAJA 010-1)', '0', null, null, null, '2016-07-04', '28', '1', null);
INSERT INTO `producto` VALUES ('750', '0N4E15003758U', '4080107', 'GUÍA 10327 (CAJA 010-1)', '0', null, null, null, '2016-07-04', '28', '1', null);
INSERT INTO `producto` VALUES ('751', '0N4E15003799V', '4080107', 'GUÍA 10327 (CAJA 010-1)', '0', null, null, null, '2016-07-04', '28', '1', null);
INSERT INTO `producto` VALUES ('752', '0N4E15009384E', '4080107', 'GUÍA 10327 (CAJA 010-4)', '0', null, null, null, '2016-07-04', '28', '1', null);
INSERT INTO `producto` VALUES ('753', '0N4E150037235', '4080107', 'GUÍA 10327 (CAJA 010-1)', '0', null, null, null, '2016-07-04', '28', '1', null);
INSERT INTO `producto` VALUES ('754', '0N4E1500656IW', '4080107', 'GUÍA 10327 (CAJA 010-4)', '0', null, null, null, '2016-07-04', '28', '1', null);
INSERT INTO `producto` VALUES ('755', '0N4E1500657ZV', '4080107', 'GUÍA 10327 (CAJA 010-4)', '0', null, null, null, '2016-07-04', '28', '1', null);
INSERT INTO `producto` VALUES ('756', '0N4E1500655WL', '4080107', 'GUÍA 10327 (CAJA 010-4)', '0', null, null, null, '2016-07-04', '28', '1', null);
INSERT INTO `producto` VALUES ('757', '0N4E1500658SB', '4080107', 'GUÍA 10327 (CAJA 010-4)', '0', null, null, null, '2016-07-04', '28', '1', null);
INSERT INTO `producto` VALUES ('758', '0N4E15009597V', '4080107', 'GUÍA 10327 (CAJA 010-3)', '0', null, null, null, '2016-07-04', '28', '1', null);
INSERT INTO `producto` VALUES ('759', '0N4E150096013', '4080107', 'GUÍA 10327 (CAJA 010-3)', '0', null, null, null, '2016-07-04', '28', '1', null);
INSERT INTO `producto` VALUES ('760', '0N4E1500674G8', '4080107', 'GUÍA 10327 (CAJA 010)', '0', null, null, null, '2016-07-04', '28', '1', null);
INSERT INTO `producto` VALUES ('761', '106383181', 'EPD-5818', 'POE PARA MR500', '0', null, null, null, '2011-07-05', '3', '1', null);
INSERT INTO `producto` VALUES ('762', '106383180', 'EPD-5818', 'POE PARA MR500', '0', null, null, null, '2011-07-05', '3', '1', null);
INSERT INTO `producto` VALUES ('763', '075234089', 'NPD-5818', 'POE PARA MR500', '0', null, null, null, '2011-07-05', '3', '1', null);
INSERT INTO `producto` VALUES ('764', 'AA0810301D451', 'U2200-07800-160', 'SE RECIBE SIN DOCUMENTOS, INCLUYE ACCESORIOS', '0', null, null, null, '2011-12-23', '1', '1', null);
INSERT INTO `producto` VALUES ('765', 'N0WC210000621', '4501003', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-07-13', '12', '1', null);
INSERT INTO `producto` VALUES ('766', 'N0WC2100005NO', '4501003', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-07-13', '12', '1', null);
INSERT INTO `producto` VALUES ('767', 'N0WC2100004TU', '4501003', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-07-13', '12', '1', null);
INSERT INTO `producto` VALUES ('768', 'D4ED4500242U1', '4501015', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-07-13', '12', '1', null);
INSERT INTO `producto` VALUES ('769', 'D4ED45002884K', '4501015', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-07-13', '12', '1', null);
INSERT INTO `producto` VALUES ('770', 'D4ED4500240PA', '4501015', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-07-13', '12', '1', null);
INSERT INTO `producto` VALUES ('771', 'S/S', '800-001-0316', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2015-11-27', '3', '1', null);
INSERT INTO `producto` VALUES ('772', 'S/S', 'PS12VUS', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-04-03', '1', '1', null);
INSERT INTO `producto` VALUES ('773', 'S/S', 'PS12VUS', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2014-06-27', '1', '1', null);
INSERT INTO `producto` VALUES ('774', 'S/S', 'PS12VUS', '', '0', null, null, null, '2015-09-22', '1', '1', null);
INSERT INTO `producto` VALUES ('775', 'S/S', 'PS18VUS', 'GUIA AEREA UIO0021938393', '0', null, null, null, '2015-11-27', '4', '1', null);
INSERT INTO `producto` VALUES ('776', 'M0035\'0029892', '8904133002516', 'DEVOLUCION ACCELL', '0', null, null, null, '2016-11-10', '3', '1', null);
INSERT INTO `producto` VALUES ('777', 'M0035\'0029884', '8904133002516', 'DHL 3338321206', '0', null, null, null, '2014-12-16', '3', '1', null);
INSERT INTO `producto` VALUES ('778', 'M0035\'0029991', '8904133002516', 'DHL 3338321206', '0', null, null, null, '2014-12-16', '3', '1', null);
INSERT INTO `producto` VALUES ('779', 'M0035\'0029987', '8904133002516', 'DHL 3338321206', '0', null, null, null, '2014-12-16', '3', '1', null);
INSERT INTO `producto` VALUES ('780', 'M0035\'0030005', '8904133002516', 'DHL 3338321206', '0', null, null, null, '2014-12-16', '3', '1', null);
INSERT INTO `producto` VALUES ('781', 'M0035\'0029899', '8904133002516', 'DHL 3338321206', '0', null, null, null, '2014-12-16', '3', '1', null);
INSERT INTO `producto` VALUES ('782', 'M0035\'0030008', '8904133002516', 'DHL 3338321206', '0', null, null, null, '2014-12-16', '3', '1', null);
INSERT INTO `producto` VALUES ('783', 'M0035\'0029894', '8904133002516', 'DHL 3338321206', '0', null, null, null, '2014-12-16', '3', '1', null);
INSERT INTO `producto` VALUES ('784', 'M0035\'0029990', '8904133002516', 'DEVOLUCION ACCELL', '0', null, null, null, '2016-11-10', '3', '1', null);
INSERT INTO `producto` VALUES ('785', 'M0035\'0029989', '8904133002516', 'DHL 3338321206', '0', null, null, null, '2014-12-16', '3', '1', null);
INSERT INTO `producto` VALUES ('786', '70:72:CF:25:DE:F8', 'OM1P', 'ENTREGA SANTIAGO REYES INCLUYE ADAPTADOR Y ANTENA', '0', null, null, null, '2011-02-08', '1', '1', null);
INSERT INTO `producto` VALUES ('787', 'S/S', 'OM1P US', 'ENTREGA SANTIAGO REYES OPEN-MESH', '0', null, null, null, '2015-08-12', '1', '1', null);
INSERT INTO `producto` VALUES ('788', '70:72:CF:4F:74:A0', 'OM1P US', 'ENTREGA SANTIAGO REYES, GUIA UIO0021935799, SIN DOCUMENTOS', '0', null, null, null, '2012-02-07', '1', '1', null);
INSERT INTO `producto` VALUES ('789', '70:72:CF:4F.74:46', 'OM1P US', 'ENTREGA SANTIAGO REYES, GUIA UIO0021935799, SIN DOCUMENTOS', '0', null, null, null, '2012-02-07', '1', '1', null);
INSERT INTO `producto` VALUES ('790', '70:72:CF:4F:67:38', 'OM1P US', 'ENTREGA SANTIAGO REYES, GUIA UIO0021935799, SIN DOCUMENTOS (\"Regresa de Imprescom 11/12/2012\")', '0', null, null, null, '2012-02-07', '1', '1', null);
INSERT INTO `producto` VALUES ('791', '70:72:CF:4F:5C:D6', 'OM1P US', 'ENTREGA SANTIAGO REYES, GUIA UIO0021935799, SIN DOCUMENTOS', '0', null, null, null, '2012-02-07', '1', '1', null);
INSERT INTO `producto` VALUES ('792', '70:72:CF:4F:69:98', 'OM1P US', 'ENTREGA SANTIAGO REYES, GUIA UIO0021935799, SIN DOCUMENTOS', '0', null, null, null, '2012-02-07', '1', '1', null);
INSERT INTO `producto` VALUES ('793', 'S/S', 'IPAX1', 'ENTREGA SANTIAGO REYES (FACTURA SH001-293-030216)', '0', null, null, null, '2016-02-11', '14', '1', null);
INSERT INTO `producto` VALUES ('794', '132343895146', 'SASY-MICRO-0501-1101', 'GUIA AEREA MIA39177586 (DEVOLUCIÓN CON PROGRAMACIÓN DE HIGH SPEED MOTORS)', '0', null, null, null, '2013-07-30', '3', '1', null);
INSERT INTO `producto` VALUES ('795', '132343958368', 'SASY-MICRO-0501-1002', 'DEVOLUCIÓN PAÚL SALAS', '0', null, null, null, '2015-02-03', '17', '1', null);
INSERT INTO `producto` VALUES ('796', '132343348868', 'SASY-SOHO-0103-1101', 'DEVOLUCION ENTREGAS ESPECIALES( SIN FUENTE )', '0', null, null, null, '2014-10-03', '17', '1', null);
INSERT INTO `producto` VALUES ('797', '132343297892', 'SASY-MICRO-0300-0300', 'DEVOLUCION EMBAJADA DE PERU', '0', null, null, null, '2014-09-30', '3', '1', null);
INSERT INTO `producto` VALUES ('798', '132343338530', 'SASY-MICRO-0300-0100', 'DEVOLUCION ACCEL SOLO VIENE CABLE DE PODER', '0', null, null, null, '2016-01-11', '3', '1', null);
INSERT INTO `producto` VALUES ('799', '132343689720', 'SASY-MIDI-0201-1000', 'GUIA AEREA MIA333746', '0', null, null, null, '2011-12-22', '1', '1', null);
INSERT INTO `producto` VALUES ('800', '132343834079', 'SASY-MIDI-0201-1000', 'GUIA AEREA MIA39177586', '0', null, null, null, '2013-07-30', '1', '1', null);
INSERT INTO `producto` VALUES ('801', '132343689610', 'SASY-MIDI-0201-1000', 'GUIA AEREA MIA333746', '0', null, null, null, '2011-12-22', '1', '1', null);
INSERT INTO `producto` VALUES ('802', 'S/S', 'QX\'0RMK\'0000', 'ENTREGA SANTIAGO REYES (GUIA 9758236751)', '0', null, null, null, '2015-05-13', '3', '1', null);
INSERT INTO `producto` VALUES ('803', 'S/S', 'QX\'0RMK\'0000', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2014-12-03', '3', '1', null);
INSERT INTO `producto` VALUES ('804', 'S/S', 'QX\'0RMK\'0000', 'ENTREGA SANTIAGO REYES (GUIA 9758236751)', '0', null, null, null, '2015-05-13', '3', '1', null);
INSERT INTO `producto` VALUES ('805', '232344103004', 'QX\'0200\'0000', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2014-12-03', '3', '1', null);
INSERT INTO `producto` VALUES ('806', '232344103554', 'QX\'0200\'0000', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2014-12-03', '3', '1', null);
INSERT INTO `producto` VALUES ('807', '232344104123', 'QX\'0200\'0000', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2014-12-03', '3', '1', null);
INSERT INTO `producto` VALUES ('808', '232344188563', 'QX-0050-0000', 'ENTREGA SANTIAGO REYES (GUIA 9758236751)', '0', null, null, null, '2015-05-13', '3', '1', null);
INSERT INTO `producto` VALUES ('809', '232344166309', 'QX\'0FXO\'0400', 'ENTREGA SANTIAGO REYES (GUIA 9758236751)', '0', null, null, null, '2015-05-13', '3', '1', null);
INSERT INTO `producto` VALUES ('810', '232344166419', 'QX\'0FXO\'0400', 'ENTREGA SANTIAGO REYES (GUIA 9758236751)', '0', null, null, null, '2015-05-13', '3', '1', null);
INSERT INTO `producto` VALUES ('811', '232344153264', 'QX\'0FXO\'0400', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2014-12-03', '3', '1', null);
INSERT INTO `producto` VALUES ('812', 'S/S', 'KCS10N', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2011-02-25', '1', '1', null);
INSERT INTO `producto` VALUES ('813', 'S/S', 'STTC-101', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2011-09-15', '1', '1', null);
INSERT INTO `producto` VALUES ('814', 'S/S', '5K', 'ARMARIO REPUESTOS', '0', null, null, null, '2012-08-30', '8', '1', null);
INSERT INTO `producto` VALUES ('815', 'S/S', 'MD12W', 'ENTREGA SANTIAGO REYES (FACTURA SH001-293-030216)', '0', null, null, null, '2016-02-11', '14', '1', null);
INSERT INTO `producto` VALUES ('816', 'LWFE3800880OW', '4750031', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('817', 'LWFE1203641JZ', '4750031', 'GUÍA 10327', '0', null, null, null, '2016-07-04', '20', '1', null);
INSERT INTO `producto` VALUES ('818', 'LWFE38009321C', '4750031', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('819', 'LWFE12038375O', '4750031', 'GUÍA 10327', '0', null, null, null, '2016-07-04', '20', '1', null);
INSERT INTO `producto` VALUES ('820', 'LWFE1203741ZL', '4750031', 'GUÍA 10327', '0', null, null, null, '2016-07-04', '20', '1', null);
INSERT INTO `producto` VALUES ('821', 'LWFE3800888D4', '4750031', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('822', 'LWFE1203805KF', '4750031', 'GUÍA 10327', '0', null, null, null, '2016-07-04', '20', '1', null);
INSERT INTO `producto` VALUES ('823', 'LWFE1203668HU', '4750031', 'GUÍA 10327', '0', null, null, null, '2016-07-04', '20', '1', null);
INSERT INTO `producto` VALUES ('824', 'LWFE1203827CQ', '4750031', 'GUÍA 10327', '0', null, null, null, '2016-07-04', '20', '1', null);
INSERT INTO `producto` VALUES ('825', 'LWFE1203749PH', '4750031', 'GUÍA 10327', '0', null, null, null, '2016-07-04', '20', '1', null);
INSERT INTO `producto` VALUES ('826', 'LWFE1203575UZ', '4750031', 'GUÍA 10327', '0', null, null, null, '2016-07-04', '20', '1', null);
INSERT INTO `producto` VALUES ('827', 'LWFE3800934E4', '4750031', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('828', 'LWFE12035936O', '4750031', 'GUÍA 10327', '0', null, null, null, '2016-07-04', '20', '1', null);
INSERT INTO `producto` VALUES ('829', 'LWFE1203759QY', '4750031', 'GUÍA 10327', '0', null, null, null, '2016-07-04', '20', '1', null);
INSERT INTO `producto` VALUES ('830', 'LWFE3800933WW', '4750031', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('831', 'LWFE1203836JY', '4750031', 'GUÍA 10327', '0', null, null, null, '2016-07-04', '20', '1', null);
INSERT INTO `producto` VALUES ('832', 'LWFE3800935TM', '4750031', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('833', 'LWFE12036824N', '4750031', 'GUÍA 10327', '0', null, null, null, '2016-07-04', '20', '1', null);
INSERT INTO `producto` VALUES ('834', 'LWFE380089226', '4750031', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('835', 'LWFE38008875D', '4750031', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('836', 'LWFE1203597RS', '4750031', 'GUÍA 10327', '0', null, null, null, '2016-07-04', '20', '1', null);
INSERT INTO `producto` VALUES ('837', 'LWFE38008919C', '4750031', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('838', 'LWFE38008890F', '4750031', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('839', 'LWFE3800876LE', '4750031', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('840', 'LWFE3800886NE', '4750031', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('841', 'LWFE3800890F8', '4750031', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('842', 'LWFE3800879WF', '4750031', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('843', 'LWFE1203576MK', '4750031', 'GUÍA 10327', '0', null, null, null, '2016-07-04', '20', '1', null);
INSERT INTO `producto` VALUES ('844', 'LWFE38009318Q', '4750031', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('845', 'LWFE1203747HS', '4750031', 'GUÍA 10327', '0', null, null, null, '2016-07-04', '20', '1', null);
INSERT INTO `producto` VALUES ('846', 'LWFE380089509', '4750031', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('847', 'LWFE3800878YH', '4750031', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('848', 'LWFE3800894T9', '4750031', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('849', 'LWFE1203594SG', '4750031', 'GUÍA 10327', '0', null, null, null, '2016-07-04', '20', '1', null);
INSERT INTO `producto` VALUES ('850', 'LWFE38008932C', '4750031', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('851', 'RV8H11AHC3W', 'SM-J500M/DS', 'IMEI 352137/07235572/4 (INCLUYE BATERIA, CABLE USB, CARGADOR)', '0', null, null, null, '2016-03-03', '1', '1', null);
INSERT INTO `producto` VALUES ('852', 'WCC4J3AXAESZ', 'WD10PURX-64E5EY0', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-10-07', '21', '1', null);
INSERT INTO `producto` VALUES ('853', '476274072', '8904133013611', 'DHL 3338321206', '0', null, null, null, '2014-12-16', '3', '1', null);
INSERT INTO `producto` VALUES ('854', '475384757', '8904133013628', 'DHL 3338321206', '0', null, null, null, '2014-12-16', '1', '1', null);
INSERT INTO `producto` VALUES ('855', 'M1020\'0000060', '8904133013987', 'DHL 3338321206', '0', null, null, null, '2014-12-16', '1', '1', null);
INSERT INTO `producto` VALUES ('856', '3147621', 'TRPDG1LXDABS-ALB', 'ENTREGADA POR SANTIAGO REYES', '0', null, null, null, '2014-07-31', '1', '1', null);
INSERT INTO `producto` VALUES ('857', '3096005', 'TRPDG1LXDABS-ALB', 'ENTREGADA POR SANTIAGO REYES', '0', null, null, null, '2014-07-31', '1', '1', null);
INSERT INTO `producto` VALUES ('858', '3147386', 'TRPDG1LXDABS-ALB', 'ENTREGADA POR SANTIAGO REYES', '0', null, null, null, '2014-07-31', '1', '1', null);
INSERT INTO `producto` VALUES ('859', '3147458', 'TRPDG1LXDABS-ALB', 'ENTREGADA POR SANTIAGO REYES', '0', null, null, null, '2014-07-31', '1', '1', null);
INSERT INTO `producto` VALUES ('860', '3147566', 'TRPDG1LXDABS-ALB', 'ENTREGADA POR SANTIAGO REYES', '0', null, null, null, '2014-07-31', '1', '1', null);
INSERT INTO `producto` VALUES ('861', '3096021', 'TRPDG1LXDABS-ALB', 'ENTREGADA POR SANTIAGO REYES', '0', null, null, null, '2014-07-31', '1', '1', null);
INSERT INTO `producto` VALUES ('862', 'L13E80154', '3HE00028CA 01', 'ENTREGADO POR SANTIAGO REYES', '0', null, null, null, '2014-07-31', '1', '1', null);
INSERT INTO `producto` VALUES ('863', 'S/S', 'SL6APC2627101', 'COMPRA COPPER SYSTEMS (Factura 4400 )', '0', null, null, null, '2017-01-30', '1', '1', null);
INSERT INTO `producto` VALUES ('864', 'S/S', '1124-0034-P1', 'ENTREGA SANTIAGO REYES  P.O 9150460-00', '0', null, null, null, '2016-04-26', '1', '1', null);
INSERT INTO `producto` VALUES ('865', '00041341A664', 'SNOM 870', 'ENTREGA SANTIAGO REYES CAPACITACION MEXICO (USANDO SANTIAGO PEREZ)', '0', null, null, null, '2013-07-22', '1', '1', null);
INSERT INTO `producto` VALUES ('866', 'C63I69SG9010HAZ', 'VBCPO34XEX', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-01-27', '1', '1', null);
INSERT INTO `producto` VALUES ('867', 'AA0810301D451', '2201-67810-160', 'CINETO', '0', null, null, null, '2013-07-04', '1', '1', null);
INSERT INTO `producto` VALUES ('868', 'AA0810301D451', '2201-67880-160', 'CINETO', '0', null, null, null, '2013-07-04', '1', '1', null);
INSERT INTO `producto` VALUES ('869', 'S/S', '81087-01', 'REPUESTOS PLANTRONICS', '0', null, null, null, '2016-09-14', '3', '1', null);
INSERT INTO `producto` VALUES ('870', 'S/S', '81083-01', 'AMAZON PO DRCXF8RWK', '0', null, null, null, '2017-02-20', '3', '1', null);
INSERT INTO `producto` VALUES ('871', 'S/S', '81083-01', 'ENTREGA SANTIAGO REYES (Primero se entrega 3 en fundas normales y luego 2 en fundas de plantronics)', '0', null, null, null, '2016-10-05', '3', '1', null);
INSERT INTO `producto` VALUES ('872', 'S/S', 'OMYA-NEE-38', 'PRPOPIEDAD CINETO LOTE Nº: 6-115061-0', '0', null, null, null, '2011-02-21', '1', '1', null);
INSERT INTO `producto` VALUES ('873', 'S/S', 'OMYA-NEE-38', 'PRPOPIEDAD CINETO LOTE Nº: 6-115061-0', '0', null, null, null, '2010-12-15', '1', '1', null);
INSERT INTO `producto` VALUES ('874', '1656', 'IP-AX-M', 'GUIA Nº 415526275 1', '0', null, null, null, '2013-09-12', '9', '1', null);
INSERT INTO `producto` VALUES ('875', '1627', 'IP-AX-M', 'GUIA Nº 415526275 1', '0', null, null, null, '2013-09-12', '9', '1', null);
INSERT INTO `producto` VALUES ('876', '1628', 'IP-AX-M', 'GUIA Nº 415526275', '0', null, null, null, '2013-09-12', '9', '1', null);
INSERT INTO `producto` VALUES ('877', '1645', 'IP-AX-M', 'GUIA Nº 415526275 1', '0', null, null, null, '2013-09-12', '9', '1', null);
INSERT INTO `producto` VALUES ('878', '1649', 'IP-AX-M', 'DEVOLUCIÓN RUBÉN AGUILAR', '0', null, null, null, '2015-05-27', '9', '1', null);
INSERT INTO `producto` VALUES ('879', '1658', 'IP-AX-M', 'GUIA Nº 415526275 1', '0', null, null, null, '2013-09-12', '9', '1', null);
INSERT INTO `producto` VALUES ('880', '1644', 'IP-AX-M', 'GUIA Nº 415526275 1, CON LICENCIA DE VIDEO', '0', null, null, null, '2013-09-12', '9', '1', null);
INSERT INTO `producto` VALUES ('881', '4050', 'IP-AX-M', 'IPAC-16 SIN LICENCIAS (CHASIS DE 1636) FACTURA SH001-293-030216 (HUECO)', '0', null, null, null, '2016-02-23', '9', '1', null);
INSERT INTO `producto` VALUES ('882', '1638', 'IP-AX-M', 'GUIA Nº 415526275', '0', null, null, null, '2013-09-12', '9', '1', null);
INSERT INTO `producto` VALUES ('883', '1643', 'IP-AX-M', 'GUIA Nº 415526275 1', '0', null, null, null, '2013-09-12', '9', '1', null);
INSERT INTO `producto` VALUES ('884', '1646', 'IP-AX-M', 'DEVOLUCION PRUEBAS PANASONIC', '0', null, null, null, '2013-12-18', '9', '1', null);
INSERT INTO `producto` VALUES ('885', '1631', 'IP-AX-M', 'GUIA Nº 415526275, EN MAQUETA', '0', null, null, null, '2013-09-12', '29', '1', null);
INSERT INTO `producto` VALUES ('886', '4145', 'IP-AX-M', 'UBICADO, PROBARO OK, VERSIÓN TPA', '0', null, null, null, '2016-04-22', '9', '1', null);
INSERT INTO `producto` VALUES ('887', '4146', 'IP-AX-M', 'UBICADO, PROBARO OK, VERSIÓN TPA', '0', null, null, null, '2016-04-22', '9', '1', null);
INSERT INTO `producto` VALUES ('888', '1637', 'IP-AX-M', 'GUIA Nº 415526275', '0', null, null, null, '2013-09-12', '9', '1', null);
INSERT INTO `producto` VALUES ('889', '1613', 'IP-AX-M', 'GUIA Nº 415526275 1', '0', null, null, null, '2013-09-12', '9', '1', null);
INSERT INTO `producto` VALUES ('890', '1641', 'IP-AX-M', 'GUIA Nº 415526275', '0', null, null, null, '2013-09-12', '9', '1', null);
INSERT INTO `producto` VALUES ('891', '1652', 'IP-AX-M', 'GUIA Nº 415526275 1', '0', null, null, null, '2013-09-12', '9', '1', null);
INSERT INTO `producto` VALUES ('892', '1639', 'IP-AX-M', 'GUIA Nº 415526275', '0', null, null, null, '2013-09-12', '9', '1', null);
INSERT INTO `producto` VALUES ('893', '1635', 'IP-AX-M', 'GUIA Nº 415526275', '0', null, null, null, '2013-09-12', '9', '1', null);
INSERT INTO `producto` VALUES ('894', '1636', 'IP-AX-M', 'GUIA Nº 415526275 (SOLO PBA)', '0', null, null, null, '2013-09-12', '14', '1', null);
INSERT INTO `producto` VALUES ('895', '1630', 'IP-AX-M', 'GUIA Nº 415526275', '0', null, null, null, '2013-09-12', '9', '1', null);
INSERT INTO `producto` VALUES ('896', '1629', 'IP-AX-M', 'GUIA Nº 415526275', '0', null, null, null, '2013-09-12', '9', '1', null);
INSERT INTO `producto` VALUES ('897', '1657', 'IP-AX-M', 'GUIA Nº 415526275 1', '0', null, null, null, '2013-09-12', '9', '1', null);
INSERT INTO `producto` VALUES ('898', '1659', 'IP-AX-M', 'GUIA Nº 415526275 1', '0', null, null, null, '2013-09-12', '9', '1', null);
INSERT INTO `producto` VALUES ('899', '1625', 'IP-AX-M', 'GUIA Nº 415526275 (SOLO PBA)', '0', null, null, null, '2013-09-12', '14', '1', null);
INSERT INTO `producto` VALUES ('900', '1634', 'IP-AX-M', 'GUIA Nº 415526275', '0', null, null, null, '2013-09-12', '9', '1', null);
INSERT INTO `producto` VALUES ('901', '1611', 'IP-AX-T', 'GUIA Nº 415526275 (DEVOLUCIÓN PARRISH VILLALVA)', '0', null, null, null, '2016-11-10', '9', '1', null);
INSERT INTO `producto` VALUES ('902', '1665', 'IP-AXTT-M', 'GUIA Nº 415526275 1', '0', null, null, null, '2013-09-12', '9', '1', null);
INSERT INTO `producto` VALUES ('903', '4043', 'IP-AXTT-M', 'IPAC-16 SIN LICENCIAS (CHASIS DE 1667) FACTURA SH001-293-030216', '0', null, null, null, '2016-02-23', '9', '1', null);
INSERT INTO `producto` VALUES ('904', '1661', 'IP-AXTT-M', 'GUIA Nº 415526275 1', '0', null, null, null, '2013-09-12', '9', '1', null);
INSERT INTO `producto` VALUES ('905', '4060', 'IP-AxTT-M', 'IPAC-16 SIN LICENCIAS (CHASIS DE 1664) FACTURA SH001-293-030216', '0', null, null, null, '2016-02-23', '9', '1', null);
INSERT INTO `producto` VALUES ('906', '4051', 'IP-AXTT-M', 'IPAC-16 (CHASIS DE 1663) CON LICENCIA DE VIDEO FACTURA SH001-293-030216', '0', null, null, null, '2016-02-23', '9', '1', null);
INSERT INTO `producto` VALUES ('907', '1664', 'IP-AXTT-M', 'GUIA Nº 415526275 (SOLO PBA)', '0', null, null, null, '2013-09-12', '14', '1', null);
INSERT INTO `producto` VALUES ('908', '1663', 'IP-AXTT-M', 'GUIA Nº 415526275 (SOLO PBA)', '0', null, null, null, '2013-09-12', '14', '1', null);
INSERT INTO `producto` VALUES ('909', '4041', 'IP-AXTT-M', 'IPAC-16 SIN LICENCIAS (CHASIS DE 1625) FACTURA SH001-293-030216', '0', null, null, null, '2016-02-23', '9', '1', null);
INSERT INTO `producto` VALUES ('910', '1662', 'IP-AXTT-M', 'GUIA Nº 415526275 1', '0', null, null, null, '2013-09-12', '9', '1', null);
INSERT INTO `producto` VALUES ('911', '1666', 'IP-AXTT-M', 'GUIA Nº 415526275 1, NO UBICADO', '0', null, null, null, '2013-09-12', '1', '1', null);
INSERT INTO `producto` VALUES ('912', '1667', 'IP-AXTT-M', 'GUIA Nº 415526275 (SOLO PBA)', '0', null, null, null, '2013-09-12', '14', '1', null);
INSERT INTO `producto` VALUES ('913', '1674', 'IP-AXTT-T', 'GUIA Nº 415526275 1', '0', null, null, null, '2013-09-12', '9', '1', null);
INSERT INTO `producto` VALUES ('914', '1670', 'IP-AXTT-T', 'GUIA Nº 415526275 1, CON LICENCIA DE VIDEO', '0', null, null, null, '2013-09-12', '9', '1', null);
INSERT INTO `producto` VALUES ('915', '0541', 'IP-AXTT-T', 'ENTREGA SANTIAGO REYES, (RFID, DISPLAY READY)', '0', null, null, null, '2012-02-07', '9', '1', null);
INSERT INTO `producto` VALUES ('916', '1647', 'IP-AXTT-T', 'GUIA Nº 415526275 (SOLO PBA)', '0', null, null, null, '2013-09-12', '14', '1', null);
INSERT INTO `producto` VALUES ('917', '1668', 'IP-AXTT-T', 'GUIA Nº 415526275, MAQUETA POSVENTA', '0', null, null, null, '2013-09-12', '29', '1', null);
INSERT INTO `producto` VALUES ('918', '3071', 'IP-Ti-T', 'DEVOLUCIÓN PRUEBAS ECU 911', '0', null, null, null, '2015-06-26', '29', '1', null);
INSERT INTO `producto` VALUES ('919', '0010', 'SXWE02-20-W', 'DEVOLUCIÓN PRUEBAS ECU 911', '0', null, null, null, '2015-06-26', '3', '1', null);
INSERT INTO `producto` VALUES ('920', 'PSJ1547069T', 'SF 100-16', 'DEVOLUCION PRACTUM', '0', null, null, null, '2016-10-10', '5', '1', null);
INSERT INTO `producto` VALUES ('921', '2164240009013', '1730502068', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-07-18', '1', '1', null);
INSERT INTO `producto` VALUES ('922', '2164240009006', '1730502068', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-07-18', '1', '1', null);
INSERT INTO `producto` VALUES ('923', 'S/S', 'GPSU15B-8', 'ARMARIO CINT', '0', null, null, null, '2012-08-30', '6', '1', null);
INSERT INTO `producto` VALUES ('924', 'S/S', '6019-0082', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2012-01-17', '1', '1', null);
INSERT INTO `producto` VALUES ('925', 'S/S', '6993-0266', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2012-01-17', '1', '1', null);
INSERT INTO `producto` VALUES ('926', 'S/S', 'TDR', 'DEVOLUCION', '0', null, null, null, '2015-03-23', '1', '1', null);
INSERT INTO `producto` VALUES ('927', 'S/S', 'C88E000208', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2011-02-25', '1', '1', null);
INSERT INTO `producto` VALUES ('928', 'BO3E2100529L9', '4990083', 'COMPRA DIRECTA CREAVALTEK', '0', null, null, null, '2017-01-31', '3', '1', null);
INSERT INTO `producto` VALUES ('929', 'CA11072600306', '4990083', 'INGRESO DE CREAVLATEK COMPRA DIRECTA', '0', null, null, null, '2017-02-16', '3', '1', null);
INSERT INTO `producto` VALUES ('930', 'CA12070300167', '4990083', 'INGRESO DE CREAVLATEK COMPRA DIRECTA', '0', null, null, null, '2017-02-16', '3', '1', null);
INSERT INTO `producto` VALUES ('931', 'BO3E2100523YL', '4990083', 'INGRESO DE CREAVLATEK COMPRA DIRECTA', '0', null, null, null, '2017-02-16', '3', '1', null);
INSERT INTO `producto` VALUES ('932', 'CA12092600105', '4990084', 'INGRESO DE CREAVLATEK COMPRA DIRECTA', '0', null, null, null, '2017-02-16', '3', '1', null);
INSERT INTO `producto` VALUES ('933', 'AOXD4700671H8', '4990084', 'INGRESO DE CREAVLATEK COMPRA DIRECTA', '0', null, null, null, '2017-02-16', '3', '1', null);
INSERT INTO `producto` VALUES ('934', 'S/S', 'T/M', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2012-02-16', '1', '1', null);
INSERT INTO `producto` VALUES ('935', 'S/S', '6993-0263', 'ENTREGA SANTIAGO REYES  P.O 9150460-00', '0', null, null, null, '2012-01-17', '1', '1', null);
INSERT INTO `producto` VALUES ('936', 'S/S', '6019-0079', 'ENTREGA SANTIAGO REYES  P.O 9150460-00', '0', null, null, null, '2012-01-17', '1', '1', null);
INSERT INTO `producto` VALUES ('937', 'K0401009612', 'K9852RF', 'PROPIEDAD CINETO ETREGA SANTIAGO REYES - USO CINETO - AREA DE TRABAJO 6', '0', null, null, null, '2010-11-24', '1', '1', null);
INSERT INTO `producto` VALUES ('938', '1T5E3501099OG', 'HSB 50', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('939', '1T5E3501102DJ', 'HSB 50', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('940', '1T5E35010592Y', 'HSB 50', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('941', '1T5E35010604U', 'HSB 50', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('942', '1T5E3501122CQ', 'HSB 50', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('943', '1T5E3501101NA', 'HSB 50', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('944', '1T5E3501065O2', 'HSB 50', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('945', '1T5E35010980G', 'HSB 50', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('946', '1T5E3501124FT', 'HSB 50', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('947', '1T5E3501097WR', 'HSB 50', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('948', '1T5E350109689', 'HSB 50', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('949', '1T5E3501105YK', 'HSB 50', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('950', '1T5E3501104W4', 'HSB 50', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('951', '1T5E3501103GZ', 'HSB 50', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('952', '1T5E3501100DG', 'HSB 50', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('953', '1T5E35010577Q', 'HSB 50', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('954', '1T5E3501061WX', 'HSB 50', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('955', '1T5E35010625Q', 'HSB 50', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('956', '1T5E3501063ZV', 'HSB 50', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('957', '1T5E35010580R', 'HSB 50', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('958', '1T5E35010564Y', 'HSB 50', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('959', '1T5E35010642T', 'HSB 50', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('960', '1T5E3501121TR', 'HSB 50', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('961', '1T5E3501110QD', 'HSB 50', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('962', '1T5E35011096T', 'HSB 50', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('963', '1T5E3501108Z4', 'HSB 50', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('964', '1T5E3501107RD', 'HSB 50', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('965', '1T5E3501106Z4', 'HSB 50', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('966', '1T5E3501125OD', 'HSB 50', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('967', '1T5E3501123T8', 'HSB 50', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', '1', null);
INSERT INTO `producto` VALUES ('968', '9ABD0800734K6', '7896637614702', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2015-08-18', '1', '1', null);
INSERT INTO `producto` VALUES ('969', '9ABD080074085', '7896637614702', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2015-08-18', '1', '1', null);
INSERT INTO `producto` VALUES ('970', '9ABD0800736P2', '7896637614702', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2015-08-18', '3', '1', null);
INSERT INTO `producto` VALUES ('971', '9ABD0800739U0', '7896637614702', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2015-08-18', '1', '1', null);
INSERT INTO `producto` VALUES ('972', '5BBAC217309', 'KX-TS500LXB', 'ENTREGA SANTIAGO REYES LOCUTORIOS', '0', null, null, null, '2010-11-24', '1', '1', null);
INSERT INTO `producto` VALUES ('973', '5BBAC217310', 'KX-TS500LXB', 'ENTREGA SANTIAGO REYES LOCUTORIOS', '0', null, null, null, '2010-11-24', '1', '1', null);
INSERT INTO `producto` VALUES ('974', '5BBAC217391', 'KX-TS500LXB', 'ENTREGA SANTIAGO REYES LOCUTORIOS 1', '0', null, null, null, '2010-11-24', '1', '1', null);
INSERT INTO `producto` VALUES ('975', '5BBAC217314', 'KX-TS500LXB', 'ENTREGA SANTIAGO REYES LOCUTORIOS', '0', null, null, null, '2010-11-24', '1', '1', null);
INSERT INTO `producto` VALUES ('976', 'F11848', '1AF00398AAAA', 'ARMARIO CINT', '0', null, null, null, '2012-08-30', '6', '1', null);
INSERT INTO `producto` VALUES ('977', 'F14650', '1AF00398AAAA', 'ARMARIO CINT', '0', null, null, null, '2012-08-30', '6', '1', null);
INSERT INTO `producto` VALUES ('978', '7JYC4503889TS', 'TC8312', 'ENTREGA SANTIAGO REYES (AVERIDADO PARA EXIBICIÓN)', '0', null, null, null, '2016-06-06', '3', '1', null);
INSERT INTO `producto` VALUES ('979', 'WJND2100857P4', '4310012', 'INGRESO DE CREAVLATEK COMPRA DIRECTA', '0', null, null, null, '2017-02-16', '3', '1', null);
INSERT INTO `producto` VALUES ('980', 'M0270\'0004534', '8904133003070', 'DHL 3338321206', '0', null, null, null, '2014-12-16', '3', '1', null);
INSERT INTO `producto` VALUES ('981', 'M0268\'0034125', '8904133003056', 'DHL 3338321206', '0', null, null, null, '2014-12-16', '3', '1', null);
INSERT INTO `producto` VALUES ('982', 'X5GC1501904K3', 'TS 3522', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '15', '1', null);
INSERT INTO `producto` VALUES ('983', 'X5GC15017711G', 'TS 3522', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '15', '1', null);
INSERT INTO `producto` VALUES ('984', 'X5GC1501320OJ', 'TS 3522', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '15', '1', null);
INSERT INTO `producto` VALUES ('985', 'X5GC1501517R5', 'TS 3522', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '15', '1', null);
INSERT INTO `producto` VALUES ('986', 'X5GC1501136YB', 'TS 3522', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '15', '1', null);
INSERT INTO `producto` VALUES ('987', 'X5GC1501051V5', 'TS 3522', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '15', '1', null);
INSERT INTO `producto` VALUES ('988', 'XMOC0601436VU', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', '1', null);
INSERT INTO `producto` VALUES ('989', 'XMOD0601345V9', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', '1', null);
INSERT INTO `producto` VALUES ('990', '004B4800761DR', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', '1', null);
INSERT INTO `producto` VALUES ('991', 'XMOB4801916QN', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', '1', null);
INSERT INTO `producto` VALUES ('992', 'XMOC08003037K', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', '1', null);
INSERT INTO `producto` VALUES ('993', 'XMOB480186776', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', '1', null);
INSERT INTO `producto` VALUES ('994', 'XMOC06008397N', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', '1', null);
INSERT INTO `producto` VALUES ('995', 'XMOD0601940NJ', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', '1', null);
INSERT INTO `producto` VALUES ('996', 'XMOD0601058SC', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', '1', null);
INSERT INTO `producto` VALUES ('997', 'XMOB4802833J1', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', '1', null);
INSERT INTO `producto` VALUES ('998', 'XMOB480026834', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', '1', null);
INSERT INTO `producto` VALUES ('999', 'XMOB4801869GH', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', '1', null);
INSERT INTO `producto` VALUES ('1000', 'XMOD06011352T', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', '1', null);
INSERT INTO `producto` VALUES ('1001', 'XMOB4802731U3', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', null, null);
INSERT INTO `producto` VALUES ('1002', 'XMOD0601652GC', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', null, null);
INSERT INTO `producto` VALUES ('1003', 'XMOC0600667EG', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', null, null);
INSERT INTO `producto` VALUES ('1004', 'XMOD06014951Q', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', null, null);
INSERT INTO `producto` VALUES ('1005', 'XMOC0600963QR', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', null, null);
INSERT INTO `producto` VALUES ('1006', 'XMOD0601876S0', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', null, null);
INSERT INTO `producto` VALUES ('1007', 'XMOD0601027XZ', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', null, null);
INSERT INTO `producto` VALUES ('1008', 'XMOB4800266IC', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', null, null);
INSERT INTO `producto` VALUES ('1009', 'XMOD0601791E0', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', null, null);
INSERT INTO `producto` VALUES ('1010', 'XMOD0601278R2', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', null, null);
INSERT INTO `producto` VALUES ('1011', 'XMOC0600506WP', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', null, null);
INSERT INTO `producto` VALUES ('1012', 'XMOB4801759Q0', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', null, null);
INSERT INTO `producto` VALUES ('1013', 'XMOD0600591E5', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', null, null);
INSERT INTO `producto` VALUES ('1014', 'XMOD0601545CY', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', null, null);
INSERT INTO `producto` VALUES ('1015', 'XMOD06013589B', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', null, null);
INSERT INTO `producto` VALUES ('1016', 'XMOB4802066U0', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', null, null);
INSERT INTO `producto` VALUES ('1017', 'XMOD06007616V', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', null, null);
INSERT INTO `producto` VALUES ('1018', 'XMOB4801868RF', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', null, null);
INSERT INTO `producto` VALUES ('1019', 'XMOB480195004', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', null, null);
INSERT INTO `producto` VALUES ('1020', 'XMOD0601575V3', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', null, null);
INSERT INTO `producto` VALUES ('1021', 'XMOD0600032YY', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', null, null);
INSERT INTO `producto` VALUES ('1022', 'XMOD060188019', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', null, null);
INSERT INTO `producto` VALUES ('1023', 'XMOD0601357GE', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', null, null);
INSERT INTO `producto` VALUES ('1024', 'XMOD0601896GS', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', null, null);
INSERT INTO `producto` VALUES ('1025', 'XMOB4802465VY', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', null, null);
INSERT INTO `producto` VALUES ('1026', 'XMOD0601578PF', 'TS 3530', 'A CONSIGNACIÓN POR FERIA', '0', null, null, null, '2016-04-13', '4', null, null);
INSERT INTO `producto` VALUES ('1027', 'T3LD06005200T', 'TS 3532', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '15', null, null);
INSERT INTO `producto` VALUES ('1028', 'T3LB4801811YK', 'TS 3532', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '15', null, null);
INSERT INTO `producto` VALUES ('1029', 'T3LC06011102C', 'TS 3532', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '15', null, null);
INSERT INTO `producto` VALUES ('1030', 'T3LB48004028D', 'TS 3532', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '15', null, null);
INSERT INTO `producto` VALUES ('1031', 'T3LB4801839MT', 'TS 3532', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '15', null, null);
INSERT INTO `producto` VALUES ('1032', 'T3LD0600861J4', 'TS 3532', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '15', null, null);
INSERT INTO `producto` VALUES ('1033', 'T3LD0600167LW', 'TS 3532', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '15', null, null);
INSERT INTO `producto` VALUES ('1034', 'T3LD06007216M', 'TS 3532', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '15', null, null);
INSERT INTO `producto` VALUES ('1035', 'T3LD060019MV', 'TS 3532', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '15', null, null);
INSERT INTO `producto` VALUES ('1036', 'T3LB480068126', 'TS 3532', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '15', null, null);
INSERT INTO `producto` VALUES ('1037', 'T3LD0600215BO', 'TS 3532', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '15', null, null);
INSERT INTO `producto` VALUES ('1038', '00020472', 'VERSATIS M250 LA', 'COMPRA PARA LA ARMADA', '0', null, null, null, '2011-07-19', '1', null, null);
INSERT INTO `producto` VALUES ('1039', 'VAXD02163473Z', 'TS 30 ID', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '26', null, null);
INSERT INTO `producto` VALUES ('1040', 'VAXD0214656SM', 'TS 30 ID', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '26', null, null);
INSERT INTO `producto` VALUES ('1041', 'VAXD0214424WG', 'TS 30 ID', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '26', null, null);
INSERT INTO `producto` VALUES ('1042', 'VAXB38031284P', 'TS 30 ID', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '26', null, null);
INSERT INTO `producto` VALUES ('1043', 'VAXD0214459CE', 'TS 30 ID', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '26', null, null);
INSERT INTO `producto` VALUES ('1044', 'VAXD0216575E9', 'TS 30 ID', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '26', null, null);
INSERT INTO `producto` VALUES ('1045', 'VAXD0216595E9', 'TS 30 ID', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '26', null, null);
INSERT INTO `producto` VALUES ('1046', 'VAXD0216038DT', 'TS 30 ID', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '26', null, null);
INSERT INTO `producto` VALUES ('1047', 'VAXD02167159J', 'TS 30 ID', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '26', null, null);
INSERT INTO `producto` VALUES ('1048', 'VAXD0216060SW', 'TS 30 ID', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '26', null, null);
INSERT INTO `producto` VALUES ('1049', 'VAXB3805020IQ', 'TS 30 ID', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '26', null, null);
INSERT INTO `producto` VALUES ('1050', 'VAXD0216036WD', 'TS 30 ID', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '26', null, null);
INSERT INTO `producto` VALUES ('1051', 'VAXD0214603W6', 'TS 30 ID', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '26', null, null);
INSERT INTO `producto` VALUES ('1052', 'VAXD0216070DC', 'TS 30 ID', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '26', null, null);
INSERT INTO `producto` VALUES ('1053', 'VAXD02162163R', 'TS 30 ID', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '26', null, null);
INSERT INTO `producto` VALUES ('1054', 'VAXD0213077H1', 'TS 30 ID', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '26', null, null);
INSERT INTO `producto` VALUES ('1055', 'VAXD0216183F6', 'TS 30 ID', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '26', null, null);
INSERT INTO `producto` VALUES ('1056', 'VAXD0216094O3', 'TS 30 ID', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '26', null, null);
INSERT INTO `producto` VALUES ('1057', '004C1500586JL', 'TS 3533', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '15', null, null);
INSERT INTO `producto` VALUES ('1058', '004B4800431NW', 'TS 3533', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '15', null, null);
INSERT INTO `producto` VALUES ('1059', '004D0600345LL', 'TS 3533', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '15', null, null);
INSERT INTO `producto` VALUES ('1060', '004D0600981PV', 'TS 3533', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '15', null, null);
INSERT INTO `producto` VALUES ('1061', '004D06001682D', 'TS 3533', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '15', null, null);
INSERT INTO `producto` VALUES ('1062', '004B4800601IE', 'TS 3533', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '15', null, null);
INSERT INTO `producto` VALUES ('1063', '004D06008963J', 'TS 3533', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '15', null, null);
INSERT INTO `producto` VALUES ('1064', '004C0800889EQ', 'TS 3533', 'DEVOLUCIÓN BETTY ORDOÑEZ GARANTÍA', '0', null, null, null, '2016-06-01', '15', null, null);
INSERT INTO `producto` VALUES ('1065', '004C08009662D', 'TS 3533', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '15', null, null);
INSERT INTO `producto` VALUES ('1066', '004B4800176CB', 'TS 3533', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '15', null, null);
INSERT INTO `producto` VALUES ('1067', '004D2900095NB', 'TS 3533', 'SE RETIRA DE CREAVALTEC', '0', null, null, null, '2016-12-05', '7', null, null);
INSERT INTO `producto` VALUES ('1068', '004B4800603S0', 'TS 3533', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '15', null, null);
INSERT INTO `producto` VALUES ('1069', '004D060083150', 'TS 3533', 'SE RETIRA DE CREAVALTEC', '0', null, null, null, '2016-12-05', '7', null, null);
INSERT INTO `producto` VALUES ('1070', '004D06007419D', 'TS 3533', 'SE RETIRA DE CREAVALTEC', '0', null, null, null, '2016-12-05', '7', null, null);
INSERT INTO `producto` VALUES ('1071', '004D06009131N', 'TS 3533', 'SE RETIRA DE CREAVALTEC', '0', null, null, null, '2016-12-05', '7', null, null);
INSERT INTO `producto` VALUES ('1072', '004D0600862N1', 'TS 3533', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '15', null, null);
INSERT INTO `producto` VALUES ('1073', '004D06004908R', 'TS 3533', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '15', null, null);
INSERT INTO `producto` VALUES ('1074', '004B48004638U', 'TS 3533', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '15', null, null);
INSERT INTO `producto` VALUES ('1075', '004D0600015MJ', 'TS 3533', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '15', null, null);
INSERT INTO `producto` VALUES ('1076', '004B4800326L0', 'TS 3533', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '15', null, null);
INSERT INTO `producto` VALUES ('1077', '004B4800026J1', 'TS 3533', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '15', null, null);
INSERT INTO `producto` VALUES ('1078', '004D06009799P', 'TS 3533', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '15', null, null);
INSERT INTO `producto` VALUES ('1079', '004B4800371NB', 'TS 3533', 'A CONSIGNACION POR FERIA', '0', null, null, null, '2016-04-13', '15', null, null);
INSERT INTO `producto` VALUES ('1080', '615E0400111E2', '4700007', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '20', null, null);
INSERT INTO `producto` VALUES ('1081', 'S/S', 'KXTY', 'DEVUELVE DANIEL DAVILA', '0', null, null, null, '2015-05-15', '30', null, null);
INSERT INTO `producto` VALUES ('1082', '6CYE39000048L', '7896637658102', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', null, null);
INSERT INTO `producto` VALUES ('1083', '6CYD3900027V5', '7896637658102', 'STOCK INTELBRAS 16-12-2015', '0', null, null, null, '2015-12-16', '4', null, null);
INSERT INTO `producto` VALUES ('1084', '6CYD3900084JO', '7896637658102', 'STOCK INTELBRAS 16-12-2015', '0', null, null, null, '2015-12-16', '4', null, null);
INSERT INTO `producto` VALUES ('1085', '6CYE390002448', '7896637658102', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', null, null);
INSERT INTO `producto` VALUES ('1086', '6CYD3900050QA', '7896637658102', 'STOCK INTELBRAS 16-12-2015', '0', null, null, null, '2015-12-16', '4', null, null);
INSERT INTO `producto` VALUES ('1087', '6CYE3900036H1', '7896637658102', 'INGRESO INTELBRAS', '0', null, null, null, '2016-11-16', '12', null, null);
INSERT INTO `producto` VALUES ('1088', 'ZKDD1600036YE', '7896637645928', 'STOCK INTELBRAS 16-12-2015', '0', null, null, null, '2015-12-16', '3', null, null);
INSERT INTO `producto` VALUES ('1089', 'ZKDD1600076D9', '7896637645928', 'STOCK INTELBRAS 16-12-2015', '0', null, null, null, '2015-12-16', '3', null, null);
INSERT INTO `producto` VALUES ('1090', 'ZKDD1600017Z5', '7896637645928', 'STOCK INTELBRAS 16-12-2015', '0', null, null, null, '2015-12-16', '3', null, null);
INSERT INTO `producto` VALUES ('1091', 'ZKDD1600057WL', '7896637645928', 'STOCK INTELBRAS 16-12-2015', '0', null, null, null, '2015-12-16', '3', null, null);
INSERT INTO `producto` VALUES ('1092', 'ZKDD16000806K', '7896637645928', 'STOCK INTELBRAS 16-12-2015', '0', null, null, null, '2015-12-16', '3', null, null);
INSERT INTO `producto` VALUES ('1093', 'ZKDD1600016SV', '7896637645928', 'STOCK INTELBRAS 16-12-2015', '0', null, null, null, '2015-12-16', '3', null, null);
INSERT INTO `producto` VALUES ('1094', 'ZKDD16000405T', '7896637645928', 'STOCK INTELBRAS 16-12-2015', '0', null, null, null, '2015-12-16', '3', null, null);
INSERT INTO `producto` VALUES ('1095', 'ZKDD16000605B', '7896637645928', 'STOCK INTELBRAS 16-12-2015', '0', null, null, null, '2015-12-16', '3', null, null);
INSERT INTO `producto` VALUES ('1096', 'ZKDD1600037HF', '7896637645928', 'STOCK INTELBRAS 16-12-2015', '0', null, null, null, '2015-12-16', '3', null, null);
INSERT INTO `producto` VALUES ('1097', 'ZKDD1600164V3', '7896637645928', 'STOCK INTELBRAS 16-12-2015', '0', null, null, null, '2015-12-16', '4', null, null);
INSERT INTO `producto` VALUES ('1098', 'ZKDD1600056NI', '7896637645928', 'STOCK INTELBRAS 16-12-2015', '0', null, null, null, '2015-12-16', '3', null, null);
INSERT INTO `producto` VALUES ('1099', 'S/S', 'MRD-308DS', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-08-01', '4', null, null);
INSERT INTO `producto` VALUES ('1100', 'S/S', 'MRD-308S', 'ENTREGADO POR DHL GUIA AEREA 6599055046 (CHINA)', '0', null, null, null, '2017-01-23', '4', null, null);
INSERT INTO `producto` VALUES ('1101', 'S/S', 'CCR2-5/16', 'METALMECANICA INDUSTRIAL RICAP REMISION 3651 BOGOTA COLOMBIA SIMILAR A PANDUIT CODE LCC2-56B-Q', '0', null, null, null, '2015-10-12', '17', null, null);
INSERT INTO `producto` VALUES ('1102', 'S/S', '22-18', '0.6 MM DE DIAMETRO INTERNO - CABLE AWG 22', '0', null, null, null, '2015-10-20', '17', null, null);
INSERT INTO `producto` VALUES ('1103', 'S/S', '33461', 'NORMA AMP 8 PARA TORNILLO DE 1/4\"', '0', null, null, null, '2015-10-20', '17', null, null);
INSERT INTO `producto` VALUES ('1104', '100045R', 'TYPE 32', 'ARMARIO CINT', '0', null, null, null, '2012-08-30', '6', null, null);
INSERT INTO `producto` VALUES ('1105', 'S/S', '16-6', '1/4\" PARA 6AWG', '0', null, null, null, '2015-10-20', '17', null, null);
INSERT INTO `producto` VALUES ('1106', 'S/S', '16-8', '5/16\" PARA 6AWG', '0', null, null, null, '2015-10-20', '17', null, null);
INSERT INTO `producto` VALUES ('1107', 'S/S', '0606328', '5.3 MM PARA 16-14 AWG', '0', null, null, null, '2015-10-20', '17', null, null);
INSERT INTO `producto` VALUES ('1108', 'S/S', '0606339', '5.3 MM PARA 12-10 AWG', '0', null, null, null, '2015-10-20', '17', null, null);
INSERT INTO `producto` VALUES ('1109', 'S/S', '0606341', '8.4 MM PARA 12-10 AWG', '0', null, null, null, '2015-10-20', '17', null, null);
INSERT INTO `producto` VALUES ('1110', 'S/N', 'MRD-QD008', 'ENTREGADO POR DHL GUIA AEREA 6599055046 (CHINA)', '0', null, null, null, '2016-09-27', '4', null, null);
INSERT INTO `producto` VALUES ('1111', 'S/S', 'ATLSP-02598-AAAA', '', '0', null, null, null, '2015-08-12', '26', null, null);
INSERT INTO `producto` VALUES ('1112', 'S/N', '121559102A', 'REPUSETOS DEL RECICLAJE', '0', null, null, null, '2012-09-03', '2', null, null);
INSERT INTO `producto` VALUES ('1113', 'S/N', '2N3251', 'REPUSETOS DEL RECICLAJE', '0', null, null, null, '2012-09-03', '2', null, null);
INSERT INTO `producto` VALUES ('1114', 'S/N', '2N3439', 'REPUSETOS DEL RECICLAJE', '0', null, null, null, '2012-09-03', '2', null, null);
INSERT INTO `producto` VALUES ('1115', 'S/N', '2N3440', 'REPUSETOS DEL RECICLAJE', '0', null, null, null, '2012-09-03', '2', null, null);
INSERT INTO `producto` VALUES ('1116', 'S/N', '2N5415', 'REPUSETOS DEL RECICLAJE', '0', null, null, null, '2012-09-03', '2', null, null);
INSERT INTO `producto` VALUES ('1117', 'S/N', '2N5416', 'REPUSETOS DEL RECICLAJE', '0', null, null, null, '2012-09-03', '2', null, null);
INSERT INTO `producto` VALUES ('1118', 'S/N', '7805', 'REPUSETOS DEL RECICLAJE', '0', null, null, null, '2012-09-03', '2', null, null);
INSERT INTO `producto` VALUES ('1119', 'S/N', '7906', 'REPUSETOS DEL RECICLAJE', '0', null, null, null, '2012-09-03', '2', null, null);
INSERT INTO `producto` VALUES ('1120', 'S/N', 'BD201', 'REPUSETOS DEL RECICLAJE', '0', null, null, null, '2012-09-03', '2', null, null);
INSERT INTO `producto` VALUES ('1121', 'S/N', '7808', 'REPUSETOS DEL RECICLAJE', '0', null, null, null, '2012-09-03', '2', null, null);
INSERT INTO `producto` VALUES ('1122', 'S/N', '7912', 'REPUSETOS DEL RECICLAJE', '0', null, null, null, '2012-09-03', '2', null, null);
INSERT INTO `producto` VALUES ('1123', 'S/N', 'LM333', 'REPUSETOS DEL RECICLAJE', '0', null, null, null, '2012-09-03', '2', null, null);
INSERT INTO `producto` VALUES ('1124', 'S/N', 'TIP41', 'REPUSETOS DEL RECICLAJE', '0', null, null, null, '2012-09-03', '2', null, null);
INSERT INTO `producto` VALUES ('1125', 'S/N', 'TIP42', 'REPUSETOS DEL RECICLAJE', '0', null, null, null, '2012-09-03', '2', null, null);
INSERT INTO `producto` VALUES ('1126', 'S/N', 'BC287', 'REPUSETOS DEL RECICLAJE', '0', null, null, null, '2012-09-03', '2', null, null);
INSERT INTO `producto` VALUES ('1127', '34760153WS', '376', 'ENTREGA SANTIAGO REYES ( EQUIPAMIENTO ELTEK )', '0', null, null, null, '2016-08-22', '1', null, null);
INSERT INTO `producto` VALUES ('1128', '02633003', 'MHC3000', 'PROPIEDAD CINETO - CENTRAL CINETO - MAQUETA', '0', null, null, null, '2011-02-03', '1', null, null);
INSERT INTO `producto` VALUES ('1129', '201546011', '662774019680', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2015-11-09', '26', null, null);
INSERT INTO `producto` VALUES ('1130', 'CIN201506004', '662774019680', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2015-06-29', '1', null, null);
INSERT INTO `producto` VALUES ('1131', '201546012', '662774019680', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2015-11-09', '26', null, null);
INSERT INTO `producto` VALUES ('1132', 'S/S', 'USB PHONE', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2011-02-25', '1', null, null);
INSERT INTO `producto` VALUES ('1133', 'S/S', 'SL0PP2412U101', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-10-07', '7', null, null);
INSERT INTO `producto` VALUES ('1134', '22VC3CS9201DD524', '963-01001-42 B', 'SE PASA DE INVENTARIO ALU', '0', null, null, null, '2015-10-07', '26', null, null);
INSERT INTO `producto` VALUES ('1135', '22VC3CS9201DD522', '963-01001-42 B', 'STOCK CINETO-DAÑADO DEVOLUCION COMACO', '0', null, null, null, '2015-10-07', '26', null, null);
INSERT INTO `producto` VALUES ('1136', '22VC3CS9201DD526', '963-01001-42 B', 'SE PASA DE INVENTARIO ALU', '0', null, null, null, '2015-10-07', '26', null, null);
INSERT INTO `producto` VALUES ('1137', '22VC3CS9201DD525', '963-01001-42 B', 'SE PASA DE INVENTARIO ALU', '0', null, null, null, '2015-10-07', '26', null, null);
INSERT INTO `producto` VALUES ('1138', '22VC3CS9201DD527', '963-01001-42 B', 'SE PASA DE INVENTARIO ALU', '0', null, null, null, '2015-10-07', '26', null, null);
INSERT INTO `producto` VALUES ('1139', '22VC3CS9201DD525', '963-01001-42 B', 'SE PASA DE INVENTARIO ALU', '0', null, null, null, '2015-10-07', '26', null, null);
INSERT INTO `producto` VALUES ('1140', '40AC3300424PG', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1141', '40AC33001589O', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1142', '40AC3300526QF', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1143', '40AC330060568', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1144', '40AC33006047Z', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1145', '40AC330060322', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1146', '40AC3000061RM', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1147', '40AC3000106RE', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1148', '40AC33005423U', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1149', '40AC33001054W', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1150', '40AC3300037WK', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1151', '40AC3300550BN', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1152', '40AC3300551IZ', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1153', '40AC3300540L6', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1154', '40AC33005415M', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1155', '40AC3300045F9', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1156', '40AC3000027BW', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1157', '40AC3300646E5', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1158', '40AC3300156MY', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1159', '40AC3000005B4', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1160', '40AC3000025YV', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1161', '40AC33002530X', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1162', '40AC3300529UY', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1163', '40AC30001051F', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1164', '40AC3300624A3', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1165', '40AC3000058TH', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1166', '40AC33005727D', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1167', '40AC3000033HV', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1168', '40AC3300051XR', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1169', '40AC3300553OK', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1170', '40AC3000108Z6', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1171', '40AC3300270DR', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1172', '40AC3300406RQ', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1173', '40AC3300500DV', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1174', '40AC300005686', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1175', '40AC3000088Q4', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1176', '40AC3300335J5', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1177', '40AC3000028GK', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1178', '40AC30000772D', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1179', '40AC3300587OC', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1180', '40AC3300627PE', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1181', '40AC3000085KD', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1182', '40AC3000008DY', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1183', '40AC3300491YT', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1184', '40AC3000095XC', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1185', '40AC330042174', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1186', '40AC3300350S3', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1187', '40AC33005671F', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1188', '40AC3000054J2', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1189', '40AC3300475YV', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1190', '40AC3000036DX', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1191', '40AC3300555W2', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1192', '40AC3300487BZ', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1193', '40AC120037502', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1194', '40AC3000087AS', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1195', '40AC33006188B', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1196', '40AC3000017H2', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1197', '40AC3000079I8', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1198', '40AC3300337KY', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1199', '40AC12000213A', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1200', '40AC3300423HM', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1201', '40AC3300240G0', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1202', '40AC3300331RJ', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1203', '40AC33006361O', '4505000', 'ORDEN DE COMPRA INTELBRAS FACTURA 17952016', '0', null, null, null, '2016-02-23', '12', null, null);
INSERT INTO `producto` VALUES ('1204', 'AESB180036964', '4520010', 'GUÍA 10327 (CAJA 005-2)', '0', null, null, null, '2016-07-04', '3', null, null);
INSERT INTO `producto` VALUES ('1205', 'AESB1800367QS', '4520010', 'GUÍA 10327 (CAJA 005-2)', '0', null, null, null, '2016-07-04', '3', null, null);
INSERT INTO `producto` VALUES ('1206', 'AESB3300101XB', '4520010', 'GUÍA 10327 (CAJA 005-1)', '0', null, null, null, '2016-07-04', '3', null, null);
INSERT INTO `producto` VALUES ('1207', 'AESB33001045B', '4520010', 'GUÍA 10327 (CAJA 005-1)', '0', null, null, null, '2016-07-04', '3', null, null);
INSERT INTO `producto` VALUES ('1208', 'AESB3300105KT', '4520010', 'GUÍA 10327 (CAJA 005-1)', '0', null, null, null, '2016-07-04', '3', null, null);
INSERT INTO `producto` VALUES ('1209', 'S/S', 'IDWHOM1P', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2013-03-19', '4', null, null);
INSERT INTO `producto` VALUES ('1210', 'S/S', 'IDWHOM1P', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2016-05-13', '1', null, null);
INSERT INTO `producto` VALUES ('1211', 'S/S', 'SKU:23067', 'ENTREGA SANTIAGO REYES', '0', null, null, null, '2014-04-07', '1', null, null);
INSERT INTO `producto` VALUES ('1212', 'S/N', 'MRD-QD006', 'ENTREGADO POR DHL GUIA AEREA 6599055046 (CHINA)', '0', null, null, null, '2016-09-27', '4', null, null);
INSERT INTO `producto` VALUES ('1213', '1103311090500372', 'SIP-T20P', 'DEVOLUCION IMPREXCOM', '0', null, null, null, '2015-10-16', '1', null, null);
INSERT INTO `producto` VALUES ('1214', '1103312040507763', 'SIP-T20P', 'ENTREGA SANTIAGO REYES GUIA MIA351317', '0', null, null, null, '2012-08-03', '1', null, null);
INSERT INTO `producto` VALUES ('1215', '1103311090500521', 'SIP-T20P', 'DEVOLUCION TELPROYEC', '0', null, null, null, '2015-10-16', '31', null, null);
INSERT INTO `producto` VALUES ('1216', '1103312040507762', 'SIP-T20P', 'DEVULVE IMPREXCOM DE PERU', '0', null, null, null, '2015-08-06', '24', null, null);
INSERT INTO `producto` VALUES ('1217', '1103312040507768', 'SIP-T20P', 'DEVOLUCION IMPREXCOM', '0', null, null, null, '2016-09-12', '31', null, null);
INSERT INTO `producto` VALUES ('1218', '1100312084403570', 'SIP-T28P', 'ENTREGA SANTIAGO REYES CAPACITACION MEXICO', '0', null, null, null, '2013-07-22', '1', null, null);
INSERT INTO `producto` VALUES ('1219', 'PRUEBITA', 'TS 3530', 'PRUEBA', '0', '12', '1994', '12.00', '2017-03-29', '4', '1', null);
INSERT INTO `producto` VALUES ('1220', 'prueba', '1415-PRUEBA', 'ESTA PRUEBA', '0', '12', '1999', '45.00', '2017-01-01', '1', '1', null);
INSERT INTO `producto` VALUES ('1221', 'prueba', '1415-PRUEBA', 'ESTA PRUEBA', '0', '12', '1999', '45.00', '2017-01-01', '1', '1', null);
INSERT INTO `producto` VALUES ('1222', 'prueba', '1415-PRUEBA', 'ESTA PRUEBA', '0', '12', '1999', '45.00', '2017-01-01', '1', '1', null);
INSERT INTO `producto` VALUES ('1223', 'prueba', '1415-PRUEBA', 'ESTA PRUEBA', '0', '12', '1999', '45.00', '2017-01-01', '1', '1', null);
INSERT INTO `producto` VALUES ('1224', 'prueba', '1415-PRUEBA', 'ESTA PRUEBA', '0', '12', '1999', '45.00', '2017-01-01', '1', '1', null);
INSERT INTO `producto` VALUES ('1225', 'prueba', '1415-PRUEBA', 'ESTA PRUEBA', '0', '12', '1999', '45.00', '2017-01-01', '1', '1', null);
INSERT INTO `producto` VALUES ('1226', 'prueba', '1415-PRUEBA', 'ESTA PRUEBA', '0', '12', '1999', '45.00', '2017-01-01', '1', '1', null);
INSERT INTO `producto` VALUES ('1227', 'prueba', '1415-PRUEBA', 'ESTA PRUEBA', '0', '12', '1999', '45.00', '2017-01-01', '1', '1', null);
INSERT INTO `producto` VALUES ('1228', 'prueba', '1415-PRUEBA', 'ESTA PRUEBA', '0', '12', '1999', '45.00', '2017-01-01', '1', '1', null);
INSERT INTO `producto` VALUES ('1229', 'prueba', '1415-PRUEBA', 'ESTA PRUEBA', '0', '12', '1999', '45.00', '2017-01-01', '1', '1', null);
INSERT INTO `producto` VALUES ('1230', 'prueba', '1415-PRUEBA', 'ESTA PRUEBA', '0', '12', '1999', '45.00', '2017-01-01', '1', '1', null);
INSERT INTO `producto` VALUES ('1231', 'prueba', '1415-PRUEBA', 'ESTA PRUEBA', '0', '12', '1999', '45.00', '2017-01-01', '1', '1', null);
INSERT INTO `producto` VALUES ('1232', 'prueba', '1415-PRUEBA', 'ESTA PRUEBA', '0', '12', '1999', '45.00', '2017-01-01', '1', '1', null);
INSERT INTO `producto` VALUES ('1234', 'prueba', '1415-PRUEBA', 'ESTA PRUEBA', '0', '12', '1999', '45.00', '2017-01-01', '1', '1', null);
INSERT INTO `producto` VALUES ('1235', 'prueba', '1415-PRUEBA', 'ESTA PRUEBA', '0', '12', '1999', '45.00', '2017-01-01', '1', '1', null);
INSERT INTO `producto` VALUES ('1236', 'prueba', '1415-PRUEBA', 'ESTA PRUEBA', '0', '12', '1999', '45.00', '2017-01-01', '1', '1', null);
INSERT INTO `producto` VALUES ('1237', 'prueba', '1415-PRUEBA', 'ESTA PRUEBA', '0', '12', '1999', '45.00', '2017-01-01', '1', '1', null);
INSERT INTO `producto` VALUES ('1238', 'prueba', '1415-PRUEBA', 'ESTA PRUEBA', '0', '12', '1999', '45.00', '2017-01-01', '1', '1', null);
INSERT INTO `producto` VALUES ('1239', 'prueba', '1415-PRUEBA', 'ESTA PRUEBA', '0', '12', '1999', '45.00', '2017-01-01', '1', '1', null);
INSERT INTO `producto` VALUES ('1240', 'prueba', '1415-PRUEBA', 'ESTA PRUEBA', '0', '12', '1999', '45.00', '2017-01-01', '1', '1', null);
INSERT INTO `producto` VALUES ('1241', 'prueba', '1415-PRUEBA', 'ESTA PRUEBA', '0', '12', '1999', '45.00', '2017-01-01', '1', '1', null);
INSERT INTO `producto` VALUES ('1264', 'sadasdasd', 'codigo-prueba2', '123', '0', '4', '1994', '25.00', '2017-03-15', '17', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('1277', 'S/N', '4115000', 'SDD', '0', '12', '1999', '1.00', '2017-03-31', '17', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14805', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14806', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14807', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14808', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14809', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14810', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14811', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14812', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14813', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14814', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14815', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14816', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14817', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14818', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14819', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14820', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14821', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14822', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14823', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14824', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14825', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14826', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14827', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14828', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14829', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14830', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14831', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14832', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14833', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14834', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14835', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14836', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14837', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14838', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14839', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14840', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14841', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14842', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14843', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14844', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14845', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14846', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14847', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14848', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14849', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14850', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14851', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14852', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14853', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14854', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14855', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14856', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14857', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14858', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14859', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14860', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14861', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14862', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14863', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14864', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14865', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14866', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14867', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14868', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14869', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14870', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14871', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14872', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14873', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14874', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14875', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14876', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14877', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14878', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14879', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14880', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14881', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14882', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14883', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14884', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14885', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14886', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14887', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14888', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14889', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14890', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14891', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14892', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14893', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14894', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14895', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14896', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14897', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14898', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14899', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14900', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14901', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14902', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14903', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14904', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14905', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14906', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14907', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14908', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14909', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14910', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14911', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14912', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14913', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14914', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14915', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14916', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14917', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14918', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14919', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14920', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14921', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14922', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14923', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14924', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14925', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14926', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14927', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14928', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14929', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14930', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14931', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14932', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14933', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14934', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14935', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14936', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14937', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14938', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14939', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14940', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14941', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14942', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14943', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14944', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14945', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14946', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14947', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14948', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14949', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14950', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14951', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14952', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14953', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14954', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14955', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14956', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14957', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14958', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14959', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14960', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14961', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14962', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14963', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14964', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14965', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14966', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14967', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14968', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14969', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14970', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14971', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14972', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14973', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14974', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14975', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14976', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14977', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14978', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14979', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14980', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14981', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14982', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14983', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14984', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14985', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14986', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14987', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14988', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14989', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14990', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14991', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14992', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14993', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14994', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14995', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14996', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14997', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14998', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('14999', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15000', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15001', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15002', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15003', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15004', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15005', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15006', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15007', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15008', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15009', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15010', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15011', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15012', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15013', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15014', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15015', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15016', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15017', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15018', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15019', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15020', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15021', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15022', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15023', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15024', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15025', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15026', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15027', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15028', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15029', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15030', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15031', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15032', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15033', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15034', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15035', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15036', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15037', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15038', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15039', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15040', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15041', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15042', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15043', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15044', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15045', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15046', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15047', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15048', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15049', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15050', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15051', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15052', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15053', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15054', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15055', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15056', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15057', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15058', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15059', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15060', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15061', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15062', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15063', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15064', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15065', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15066', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15067', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15068', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15069', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15070', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15071', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15072', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15073', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15074', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15075', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15076', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15077', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15078', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15079', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15080', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15081', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15082', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15083', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15084', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15085', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15086', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15087', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15088', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15089', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15090', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15091', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15092', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15093', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15094', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15095', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15096', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15097', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15098', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15099', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15100', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15101', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15102', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15103', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15104', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15105', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15106', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15107', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15108', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15109', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15110', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15111', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15112', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15113', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15114', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15115', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15116', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15117', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15118', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15119', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15120', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15121', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15122', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15123', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15124', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15125', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15126', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15127', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15128', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15129', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15130', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15131', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15132', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15133', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15134', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15135', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15136', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15137', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15138', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15139', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15140', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15141', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15142', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15143', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15144', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15145', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15146', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15147', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15148', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15149', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15150', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15151', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15152', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15153', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15154', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15155', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15156', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15157', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15158', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15159', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15160', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15161', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15162', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15163', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15164', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15165', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15166', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15167', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15168', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15169', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15170', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15171', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15172', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15173', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15174', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15175', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15176', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15177', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15178', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15179', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15180', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15181', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15182', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15183', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15184', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15185', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15186', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15187', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15188', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15189', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15190', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15191', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15192', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15193', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15194', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15195', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15196', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15197', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15198', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15199', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15200', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15201', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15202', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15203', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15204', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15205', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15206', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15207', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15208', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15209', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15210', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15211', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15212', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15213', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15214', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15215', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15216', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15217', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15218', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15219', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15220', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15221', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15222', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15223', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15224', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15225', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15226', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15227', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15228', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15229', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15230', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15231', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15232', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15233', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15234', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15235', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15236', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15237', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15238', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15239', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15240', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15241', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15242', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15243', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15244', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15245', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15246', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15247', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15248', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15249', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15250', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15251', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15252', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15253', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15254', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15255', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15256', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15257', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15258', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15259', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15260', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15261', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15262', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15263', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15264', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15265', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15266', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15267', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15268', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15269', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15270', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15271', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15272', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15273', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15274', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15275', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15276', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15277', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15278', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15279', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15280', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15281', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15282', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15283', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15284', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15285', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15286', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15287', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15288', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15289', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15290', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15291', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15292', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15293', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15294', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15295', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15296', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15297', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15298', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15299', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15300', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15301', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15302', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15303', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15304', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15305', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15306', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15307', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15308', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15309', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15310', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15311', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15312', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15313', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15314', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15315', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15316', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15317', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15318', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15319', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15320', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15321', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15322', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15323', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15324', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15325', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15326', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15327', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15328', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15329', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15330', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15331', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15332', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15333', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15334', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15335', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15336', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15337', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15338', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15339', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15340', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15341', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15342', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15343', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15344', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15345', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15346', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15347', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15348', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15349', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15350', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15351', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15352', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15353', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15354', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15355', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15356', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15357', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15358', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15359', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15360', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15361', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15362', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15363', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15364', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15365', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15366', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15367', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15368', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15369', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15370', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15371', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15372', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15373', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15374', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15375', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15376', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15377', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15378', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15379', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15380', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15381', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15382', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15383', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15384', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15385', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15386', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15387', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15388', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15389', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15390', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15391', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15392', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15393', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15394', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15395', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15396', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15397', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15398', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15399', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15400', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15401', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15402', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15403', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15404', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15405', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15406', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15407', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15408', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15409', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15410', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15411', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15412', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15413', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15414', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15415', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15416', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15417', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15418', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15419', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15420', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15421', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15422', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15423', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15424', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15425', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15426', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15427', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15428', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15429', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15430', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15431', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15432', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15433', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15434', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15435', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15436', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15437', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15438', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15439', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15440', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15441', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15442', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15443', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15444', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15445', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15446', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15447', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15448', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15449', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15450', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15451', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15452', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15453', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15454', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15455', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15456', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15457', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15458', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15459', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15460', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15461', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15462', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15463', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15464', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15465', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15466', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15467', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15468', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15469', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15470', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15471', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15472', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15473', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15474', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15475', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15476', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15477', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15478', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15479', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15480', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15481', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15482', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15483', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15484', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15485', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15486', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15487', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15488', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15489', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15490', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15491', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15492', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15493', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15494', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15495', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15496', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15497', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15498', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15499', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15500', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15501', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15502', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15503', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15504', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15505', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15506', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15507', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15508', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15509', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15510', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15511', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15512', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15513', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15514', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15515', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15516', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15517', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15518', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15519', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15520', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15521', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15522', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15523', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15524', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15525', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15526', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15527', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15528', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15529', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15530', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15531', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15532', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15533', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15534', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15535', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15536', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15537', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15538', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15539', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15540', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15541', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15542', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15543', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15544', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15545', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15546', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15547', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15548', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15549', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15550', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15551', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15552', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15553', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15554', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15555', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15556', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15557', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15558', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15559', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15560', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15561', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15562', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15563', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15564', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15565', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15566', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15567', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15568', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15569', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15570', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15571', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15572', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15573', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15574', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15575', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15576', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15577', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15578', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15579', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15580', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15581', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15582', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15583', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15584', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15585', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15586', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15587', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15588', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15589', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15590', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15591', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15592', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15593', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15594', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15595', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15596', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15597', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15598', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15599', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15600', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15601', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15602', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15603', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15604', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15605', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15606', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15607', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15608', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15609', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15610', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15611', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15612', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15613', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15614', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15615', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15616', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15617', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15618', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15619', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15620', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15621', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15622', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15623', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15624', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15625', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15626', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15627', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15628', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15629', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15630', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15631', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15632', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15633', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15634', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15635', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15636', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15637', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15638', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15639', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15640', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15641', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15642', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15643', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15644', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15645', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15646', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15647', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15648', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15649', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15650', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15651', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15652', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15653', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15654', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15655', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15656', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15657', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15658', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15659', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15660', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15661', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15662', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15663', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15664', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15665', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15666', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15667', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15668', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15669', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15670', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15671', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15672', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15673', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15674', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15675', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15676', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15677', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15678', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15679', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15680', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15681', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15682', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15683', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15684', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15685', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15686', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15687', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15688', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15689', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15690', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15691', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15692', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15693', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15694', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15695', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15696', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15697', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15698', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15699', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15700', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15701', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15702', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15703', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15704', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15705', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15706', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15707', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15708', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15709', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15710', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15711', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15712', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15713', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15714', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15715', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15716', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15717', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15718', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15719', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15720', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15721', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15722', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15723', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15724', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15725', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15726', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15727', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15728', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15729', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15730', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15731', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15732', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15733', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15734', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15735', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15736', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15737', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15738', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15739', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15740', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15741', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15742', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15743', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15744', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15745', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15746', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15747', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15748', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15749', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15750', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15751', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15752', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15753', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15754', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15755', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15756', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15757', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15758', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15759', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15760', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15761', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15762', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15763', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15764', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15765', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15766', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15767', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15768', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15769', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15770', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15771', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15772', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15773', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15774', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15775', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15776', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15777', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15778', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15779', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15780', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15781', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15782', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15783', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15784', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15785', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15786', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15787', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15788', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15789', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15790', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15791', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15792', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15793', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15794', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15795', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15796', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15797', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15798', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15799', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15800', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15801', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15802', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15803', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('15804', 'S/N', 'SF200-24P', '12', '0', '12', '1994', '4.00', '2017-03-15', '18', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21815', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21816', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21817', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21818', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21819', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21820', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21821', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21822', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21823', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21824', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21825', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21826', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21827', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21828', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21829', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21830', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21831', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21832', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21833', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21834', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21835', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21836', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21837', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21838', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21839', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21840', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21841', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21842', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21843', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21844', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21845', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21846', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21847', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21848', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21849', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21850', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21851', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21852', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21853', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21854', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21855', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21856', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21857', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21858', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21859', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21860', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21861', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21862', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21863', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21864', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21865', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21866', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21867', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21868', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21869', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21870', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21871', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21872', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21873', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21874', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21875', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21876', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21877', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21878', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21879', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21880', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21881', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21882', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21883', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21884', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21885', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21886', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21887', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21888', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21889', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21890', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21891', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21892', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21893', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21894', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21895', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21896', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21897', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21898', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21899', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21900', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21901', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21902', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21903', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21904', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21905', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21906', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21907', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21908', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21909', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21910', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21911', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21912', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21913', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21914', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21915', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21916', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21917', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21918', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21919', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21920', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21921', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21922', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21923', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21924', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21925', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21926', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21927', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21928', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21929', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21930', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21931', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21932', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21933', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21934', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21935', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21936', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21937', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21938', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21939', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21940', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21941', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21942', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21943', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21944', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21945', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21946', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21947', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21948', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21949', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21950', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21951', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21952', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21953', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21954', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21955', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21956', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21957', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21958', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21959', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21960', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21961', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21962', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21963', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21964', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21965', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21966', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21967', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21968', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21969', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21970', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21971', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21972', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21973', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21974', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21975', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21976', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21977', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21978', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21979', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21980', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21981', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21982', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21983', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21984', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21985', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21986', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21987', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21988', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21989', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21990', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21991', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21992', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21993', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21994', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21995', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21996', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21997', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21998', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('21999', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22000', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22001', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22002', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22003', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22004', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22005', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22006', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22007', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22008', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22009', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22010', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22011', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22012', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22013', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22014', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22015', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22016', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22017', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22018', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22019', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22020', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22021', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22022', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22023', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22024', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22025', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22026', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22027', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22028', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22029', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22030', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22031', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22032', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22033', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22034', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22035', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22036', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22037', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22038', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22039', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22040', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22041', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22042', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22043', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22044', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22045', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22046', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22047', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22048', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22049', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22050', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22051', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22052', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22053', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22054', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22055', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22056', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22057', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22058', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22059', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22060', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22061', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22062', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22063', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22064', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22065', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22066', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22067', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22068', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22069', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22070', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22071', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22072', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22073', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22074', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22075', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22076', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22077', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22078', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22079', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22080', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22081', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22082', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22083', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22084', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22085', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22086', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22087', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22088', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22089', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22090', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22091', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22092', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22093', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22094', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22095', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22096', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22097', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22098', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22099', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22100', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22101', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22102', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22103', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22104', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22105', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22106', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22107', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22108', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22109', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22110', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22111', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22112', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22113', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22114', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22115', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22116', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22117', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22118', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22119', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22120', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22121', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22122', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22123', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22124', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22125', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22126', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22127', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22128', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22129', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22130', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22131', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22132', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22133', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22134', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22135', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22136', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22137', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22138', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22139', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22140', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22141', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22142', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22143', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22144', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22145', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22146', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22147', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22148', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22149', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22150', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22151', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22152', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22153', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22154', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22155', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22156', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22157', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22158', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22159', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22160', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22161', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22162', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22163', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22164', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22165', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22166', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22167', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22168', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22169', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22170', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22171', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22172', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22173', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22174', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22175', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22176', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22177', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22178', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22179', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22180', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22181', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22182', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22183', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22184', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22185', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22186', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22187', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22188', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22189', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22190', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22191', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22192', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22193', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22194', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22195', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22196', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22197', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22198', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22199', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22200', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22201', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22202', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22203', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22204', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22205', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22206', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22207', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22208', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22209', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22210', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22211', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22212', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22213', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22214', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22215', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22216', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22217', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22218', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22219', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22220', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22221', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22222', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22223', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22224', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22225', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22226', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22227', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22228', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22229', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22230', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22231', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22232', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22233', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22234', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22235', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22236', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22237', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22238', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22239', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22240', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22241', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22242', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22243', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22244', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22245', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22246', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22247', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22248', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22249', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22250', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22251', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22252', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22253', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22254', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22255', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22256', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22257', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22258', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22259', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22260', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22261', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22262', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22263', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22264', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22265', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22266', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22267', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22268', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22269', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22270', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22271', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22272', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22273', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22274', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22275', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22276', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22277', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22278', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22279', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22280', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22281', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22282', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22283', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22284', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22285', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22286', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22287', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22288', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22289', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22290', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22291', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22292', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22293', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22294', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22295', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22296', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22297', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22298', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22299', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22300', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22301', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22302', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22303', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22304', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22305', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22306', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22307', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22308', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22309', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22310', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22311', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22312', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22313', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22314', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22315', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22316', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22317', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22318', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22319', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22320', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22321', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22322', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22323', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22324', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22325', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22326', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22327', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22328', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22329', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22330', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22331', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22332', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22333', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22334', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22335', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22336', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22337', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22338', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22339', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22340', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22341', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22342', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22343', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22344', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22345', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22346', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22347', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22348', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22349', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22350', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22351', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22352', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22353', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22354', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22355', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22356', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22357', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22358', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22359', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22360', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22361', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22362', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22363', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22364', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22365', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22366', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22367', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22368', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22369', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22370', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22371', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22372', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22373', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22374', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22375', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22376', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22377', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22378', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22379', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22380', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22381', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22382', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22383', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22384', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22385', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22386', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22387', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22388', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22389', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22390', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22391', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22392', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22393', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22394', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22395', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22396', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22397', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22398', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22399', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22400', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22401', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22402', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22403', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22404', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22405', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22406', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22407', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22408', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22409', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22410', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22411', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22412', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22413', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22414', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22415', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22416', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22417', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22418', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22419', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22420', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22421', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22422', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22423', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22424', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22425', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22426', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22427', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22428', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22429', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22430', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22431', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22432', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22433', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22434', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22435', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22436', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22437', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22438', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22439', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22440', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22441', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22442', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22443', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22444', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22445', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22446', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22447', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22448', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22449', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22450', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22451', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22452', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22453', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22454', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22455', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22456', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22457', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22458', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22459', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22460', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22461', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22462', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22463', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22464', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22465', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22466', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22467', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22468', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22469', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22470', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22471', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22472', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22473', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22474', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22475', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22476', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22477', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22478', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22479', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22480', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22481', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22482', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22483', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22484', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22485', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22486', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22487', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22488', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22489', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22490', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22491', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22492', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22493', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22494', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22495', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22496', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22497', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22498', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22499', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22500', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22501', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22502', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22503', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22504', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22505', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22506', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22507', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22508', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22509', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22510', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22511', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22512', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22513', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22514', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22515', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22516', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22517', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22518', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22519', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22520', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22521', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22522', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22523', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22524', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22525', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22526', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22527', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22528', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22529', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22530', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22531', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22532', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22533', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22534', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22535', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22536', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22537', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22538', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22539', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22540', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22541', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22542', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22543', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22544', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22545', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22546', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22547', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22548', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22549', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22550', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22551', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22552', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22553', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22554', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22555', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22556', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22557', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22558', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22559', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22560', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22561', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22562', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22563', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22564', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22565', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22566', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22567', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22568', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22569', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22570', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22571', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22572', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22573', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22574', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22575', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22576', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22577', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22578', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22579', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22580', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22581', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22582', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22583', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22584', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22585', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22586', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22587', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22588', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22589', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22590', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22591', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22592', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22593', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22594', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22595', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22596', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22597', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22598', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22599', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22600', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22601', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22602', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22603', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22604', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22605', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22606', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22607', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22608', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22609', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22610', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22611', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22612', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22613', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22614', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22615', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22616', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22617', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22618', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22619', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22620', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22621', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22622', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22623', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22624', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22625', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22626', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22627', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22628', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22629', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22630', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22631', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22632', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22633', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22634', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22635', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22636', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22637', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22638', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22639', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22640', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22641', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22642', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22643', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22644', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22645', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22646', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22647', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22648', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22649', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22650', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22651', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22652', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22653', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22654', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22655', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22656', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22657', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22658', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22659', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22660', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22661', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22662', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22663', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22664', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22665', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22666', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22667', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22668', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22669', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22670', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22671', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22672', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22673', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22674', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22675', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22676', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22677', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22678', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22679', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22680', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22681', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22682', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22683', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22684', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22685', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22686', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22687', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22688', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22689', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22690', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22691', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22692', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22693', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22694', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22695', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22696', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22697', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22698', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22699', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22700', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22701', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22702', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22703', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22704', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22705', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22706', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22707', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22708', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22709', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22710', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22711', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22712', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22713', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22714', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22715', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22716', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22717', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22718', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22719', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22720', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22721', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22722', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22723', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22724', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22725', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22726', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22727', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22728', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22729', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22730', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22731', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22732', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22733', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22734', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22735', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22736', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22737', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22738', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22739', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22740', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22741', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22742', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22743', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22744', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22745', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22746', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22747', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22748', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22749', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22750', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22751', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22752', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22753', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22754', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22755', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22756', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22757', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22758', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22759', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22760', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22761', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22762', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22763', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22764', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22765', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22766', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22767', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22768', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22769', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22770', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22771', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22772', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22773', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22774', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22775', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22776', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22777', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22778', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22779', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22780', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22781', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22782', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22783', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22784', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22785', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22786', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22787', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22788', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22789', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22790', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22791', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22792', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22793', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22794', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22795', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22796', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22797', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22798', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22799', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22800', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22801', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22802', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22803', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22804', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22805', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22806', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22807', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22808', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22809', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22810', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22811', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22812', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22813', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('22814', 'S/N', 'PRUEBA12', 'después', '0', '12', '1999', '25.00', '2017-04-14', '6', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('122815', 'S/N', 'SG-001', 'des', '0', '122', '1999', '12.00', '2017-01-01', '1', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122816', 'S/N', 'SG-001', 'des', '0', '122', '1999', '12.00', '2017-01-01', '1', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122817', 'asdasdasd', 'SG-001', '1212', '0', '12', '1999', '12.00', '2017-04-12', '12', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122818', 'S/N', 'SG-001', 'sa', '0', '12', '1999', '12.00', '2017-01-01', '1', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122819', 'S/N', 'SG-001', 'sa', '0', '12', '1999', '12.00', '2017-01-01', '1', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122820', 'S/N', 'SG-001', 'sa', '0', '12', '1999', '12.00', '2017-01-01', '1', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122821', 'S/N', 'SG-001', 'sa', '0', '12', '1999', '12.00', '2017-01-01', '1', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122822', 'S/N', 'SG-001', 'sa', '0', '12', '1999', '12.00', '2017-01-01', '1', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122823', 'SN/1218', 'SG-001', 'sa', '0', '12', '1999', '12.00', '2017-01-01', '1', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122824', 'S/N', 'SG-001', 'asd', '0', '12', '2015', '25.00', '2016-01-01', '1', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122825', 'S/N', 'SG-001', 'asd', '0', '12', '2015', '25.00', '2016-01-01', '1', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122826', 'S/N', 'SG-001', 'asd', '0', '12', '2015', '25.00', '2016-01-01', '1', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122827', 'S/N', 'SG-001', 'asd', '0', '12', '2015', '25.00', '2016-01-01', '1', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122828', 'S/N', 'SG-001', 'asd', '0', '12', '2015', '25.00', '2016-01-01', '1', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122829', 'S/N', 'SG-001', 'asd', '0', '12', '2015', '25.00', '2016-01-01', '1', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122830', 'S/N', 'SG-001', 'asd', '0', '12', '2015', '25.00', '2016-01-01', '1', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122831', 'S/N', 'SG-001', 'asd', '0', '12', '2015', '25.00', '2016-01-01', '1', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122832', 'S/N', 'SG-001', 'asd', '0', '12', '2015', '25.00', '2016-01-01', '1', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122833', 'S/N', 'SG-001', 'asd', '0', '12', '2015', '25.00', '2016-01-01', '1', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122834', 'S/N', 'SG-001', 'asd', '0', '12', '2015', '25.00', '2016-01-01', '1', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122835', 'S/N', 'SG-001', 'asd', '0', '12', '2015', '25.00', '2016-01-01', '1', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122836', 'S/N', 'SG-001', 'asd', '0', '12', '2015', '25.00', '2016-01-01', '1', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122837', 'S/N', 'SG-001', 'asd', '0', '12', '2015', '25.00', '2016-01-01', '1', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122838', '123', 'SG-001', 'asd', '0', '12', '2015', '25.00', '2016-01-01', '1', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122839', '12323123', 'codigo-prueba2', '12', '0', '12', '2002', '1.00', '2017-04-05', '17', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122840', 'S/N', 'SG-001', 'ENTREGA SIN DOCUMENTO', '0', '12', '1996', '22.00', '2007-03-09', '19', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122841', 'S/N', 'SG-001', 'ENTREGA SIN DOCUMENTO', '0', '12', '1996', '22.00', '2007-03-09', '19', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122842', 'S/N', 'SG-001', 'ENTREGA SIN DOCUMENTO', '0', '12', '1996', '22.00', '2007-03-09', '19', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122843', 'S/N', 'SG-001', '12', '0', '35', '1999', '12.00', '2017-12-31', '1', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122844', 'S/N', 'SG-001', '12', '0', '35', '1999', '12.00', '2017-12-31', '1', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122845', 'S/N', 'SG-001', '12', '0', '35', '1999', '12.00', '2017-12-31', '1', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122846', 'S/N', 'SG-001', '12', '0', '35', '1999', '12.00', '2017-12-31', '1', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122847', 'S/N', 'SG-001', '12', '0', '35', '1999', '12.00', '2017-12-31', '1', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122848', 'S/N', 'SG-001', '12', '0', '35', '1999', '12.00', '2017-12-31', '1', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122849', 'S/N', 'SG-001', '12', '0', '35', '1999', '12.00', '2017-12-31', '1', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122850', 'S/N', 'SG-001', '12', '0', '35', '1999', '12.00', '2017-12-31', '1', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122851', 'S/N', 'SG-001', '12', '0', '35', '1999', '12.00', '2017-12-31', '1', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122852', 'S/N', 'SG-001', '12', '0', '35', '1999', '12.00', '2017-12-31', '1', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122853', 'S/N', 'SG-001', '12', '0', '35', '1999', '12.00', '2017-12-31', '1', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122854', 'S/N', 'SG-001', '12', '0', '35', '1999', '12.00', '2017-12-31', '1', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122855', 'S/N', 'SG-001', '12', '0', '35', '1999', '12.00', '2017-12-31', '1', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122856', 'S/N', 'SG-001', '12', '0', '35', '1999', '12.00', '2017-12-31', '1', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122857', 'S/N', 'SG-001', '12', '0', '35', '1999', '12.00', '2017-12-31', '1', '1', ' gsalazar');
INSERT INTO `producto` VALUES ('122858', 'qwe', 'SG-001', 'wdsds', '0', '12', '1990', '12.00', '2017-01-01', '1', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('122859', 'S/N', 'SG-001', 'Entrega ', '0', '12', '1999', '12.00', '2016-12-31', '1', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('122860', 'S/N', 'SG-001', 'Entrega ', '0', '12', '1999', '12.00', '2016-12-31', '1', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('122861', 'S/N', 'SG-001', 'Entrega ', '0', '12', '1999', '12.00', '2016-12-31', '1', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('122862', 'S/N', 'SG-001', 'Entrega ', '0', '12', '1999', '12.00', '2016-12-31', '1', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('122863', 'S/N', 'SG-001', 'Entrega ', '0', '12', '1999', '12.00', '2016-12-31', '1', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('122864', 'S/N', 'SG-001', 'entregado por Santiago Reyes', '0', '12', '1999', '12.00', '2017-04-04', '3', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('122865', 'S/N', 'SG-001', 'entregado por Santiago Reyes', '0', '12', '1999', '12.00', '2017-04-04', '3', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('122866', 'S/N', 'SG-001', 'entregado por Santiago Reyes', '0', '12', '1999', '12.00', '2017-04-04', '3', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('122867', 'S/N', 'SG-001', 'entregado por Santiago Reyes', '0', '12', '1999', '12.00', '2017-04-04', '3', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('122868', 'S/N', 'SG-001', 'entregado por Santiago Reyes', '0', '12', '1999', '12.00', '2017-04-04', '3', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('122869', 'S/N', 'SG-001', 'entregado por Santiago Reyes', '0', '12', '1999', '12.00', '2017-04-04', '3', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('122870', 'S/N', 'SG-001', 'entregado por Santiago Reyes', '0', '12', '1999', '12.00', '2017-04-04', '3', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('122871', 'S/N', 'SG-001', 'entregado por Santiago Reyes', '0', '12', '1999', '12.00', '2017-04-04', '3', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('122872', 'S/N', 'SG-001', 'entregado por Santiago Reyes', '0', '12', '1999', '12.00', '2017-04-04', '3', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('122873', 'S/N', 'SG-001', 'entregado por Santiago Reyes', '0', '12', '1999', '12.00', '2017-04-04', '3', '1', ' Gabriel Salazar');
INSERT INTO `producto` VALUES ('122874', '12ered', 'SG-001', '12', '0', '12', '1999', '12.00', '2017-04-05', '17', '1', ' William Romero');
INSERT INTO `producto` VALUES ('122875', 'S/N', 'SG-001', 'ENTREGA SANTIAGO REYES', '0', '12', '1999', '12.00', '2017-04-12', '1', '1', '');
INSERT INTO `producto` VALUES ('122876', 'S/N', 'SG-001', 'ENTREGA SANTIAGO REYES', '0', '12', '1999', '12.00', '2017-04-12', '1', '1', '');
INSERT INTO `producto` VALUES ('122877', 'S/N', 'SG-001', 'ENTREGA SANTIAGO REYES', '0', '12', '1999', '12.00', '2017-04-12', '1', '1', '');
INSERT INTO `producto` VALUES ('122878', 'S/N', 'SG-001', 'ENTREGA SANTIAGO REYES', '0', '12', '1999', '12.00', '2017-04-12', '1', '1', '');
INSERT INTO `producto` VALUES ('122879', 'S/N', 'SG-001', 'ENTREGA SANTIAGO REYES', '0', '12', '1999', '12.00', '2017-04-12', '1', '1', '');
INSERT INTO `producto` VALUES ('122880', 'S/N', 'CODIGOPRUEBA5', 'DESCRIPCION PRUEBA', '0', '12', '1990', '12.00', '2017-04-12', '1', '1', '');
INSERT INTO `producto` VALUES ('122881', 'S/N', 'CODIGOPRUEBA5', 'DESCRIPCION PRUEBA', '0', '12', '1990', '12.00', '2017-04-12', '1', '1', '');
INSERT INTO `producto` VALUES ('122882', 'S/N', 'CODIGOPRUEBA5', 'DESCRIPCION PRUEBA', '0', '12', '1990', '12.00', '2017-04-12', '1', '1', '');
INSERT INTO `producto` VALUES ('122883', 'S/N', 'CODIGOPRUEBA5', 'DESCRIPCION PRUEBA', '0', '12', '1990', '12.00', '2017-04-12', '1', '1', '');
INSERT INTO `producto` VALUES ('122884', 'S/N', 'CODIGOPRUEBA5', 'DESCRIPCION PRUEBA', '0', '12', '1990', '12.00', '2017-04-12', '1', '1', '');
INSERT INTO `producto` VALUES ('122885', 'S/N', 'CODIGOPRUEBA5', 'DESCRIPCION PRUEBA', '0', '12', '1990', '12.00', '2017-04-12', '1', '1', '');
INSERT INTO `producto` VALUES ('122886', 'S/N', 'CODIGOPRUEBA5', 'DESCRIPCION PRUEBA', '0', '12', '1990', '12.00', '2017-04-12', '1', '1', '');
INSERT INTO `producto` VALUES ('122887', 'S/N', 'CODIGOPRUEBA5', 'DESCRIPCION PRUEBA', '0', '12', '1990', '12.00', '2017-04-12', '1', '1', '');
INSERT INTO `producto` VALUES ('122888', 'S/N', 'CODIGOPRUEBA5', 'DESCRIPCION PRUEBA', '0', '12', '1990', '12.00', '2017-04-12', '1', '1', '');
INSERT INTO `producto` VALUES ('122889', 'S/N', 'CODIGOPRUEBA5', 'DESCRIPCION PRUEBA', '0', '12', '1990', '12.00', '2017-04-12', '1', '1', '');
INSERT INTO `producto` VALUES ('122890', 'S/N', 'CODIGOPRUEBA5', 'DESCRIPCION PRUEBA', '0', '12', '1990', '12.00', '2017-04-12', '1', '1', '');
INSERT INTO `producto` VALUES ('122891', 'S/N', 'CODIGOPRUEBA5', 'DESCRIPCION PRUEBA', '0', '12', '1990', '12.00', '2017-04-12', '1', '1', '');
INSERT INTO `producto` VALUES ('122892', 'S/N', 'CODIGOPRUEBA5', 'DESCRIPCION PRUEBA', '0', '12', '1990', '12.00', '2017-04-12', '1', '1', '');
INSERT INTO `producto` VALUES ('122893', 'S/N', 'CODIGOPRUEBA5', 'DESCRIPCION PRUEBA', '0', '12', '1990', '12.00', '2017-04-12', '1', '1', '');
INSERT INTO `producto` VALUES ('122894', 'S/N', 'CODIGOPRUEBA5', 'DESCRIPCION PRUEBA', '0', '12', '1990', '12.00', '2017-04-12', '1', '1', '');
INSERT INTO `producto` VALUES ('122895', 'S/N', 'CODIGOPRUEBA5', 'DESCRIPCION PRUEBA', '0', '12', '1990', '12.00', '2017-04-12', '1', '1', '');
INSERT INTO `producto` VALUES ('122896', 'S/N', 'CODIGOPRUEBA5', 'DESCRIPCION PRUEBA', '0', '12', '1990', '12.00', '2017-04-12', '1', '1', '');
INSERT INTO `producto` VALUES ('122897', 'EST-001', 'PRODUCT-001-PR', 'ENTREGA PRUEBA', '0', '12', '1999', '14.00', '2017-04-12', '1', '1', '');
INSERT INTO `producto` VALUES ('122898', 'S/N', 'PRODUCT-001-PR', 'ENTREGA PRUEBA LOTES', '0', '26', '2017', '17.00', '2017-04-12', '2', '1', '');
INSERT INTO `producto` VALUES ('122899', 'S/N', 'PRODUCT-001-PR', 'ENTREGA PRUEBA LOTES', '0', '26', '2017', '17.00', '2017-04-12', '2', '1', '');
INSERT INTO `producto` VALUES ('122900', 'S/N', 'PRODUCT-001-PR', 'ENTREGA PRUEBA LOTES', '0', '26', '2017', '17.00', '2017-04-12', '2', '1', '');
INSERT INTO `producto` VALUES ('122901', 'S/N', 'PRODUCT-001-PR', 'ENTREGA PRUEBA LOTES', '0', '26', '2017', '17.00', '2017-04-12', '2', '1', '');
INSERT INTO `producto` VALUES ('122902', 'S/N', 'PRODUCT-001-PR', 'ENTREGA PRUEBA LOTES', '0', '26', '2017', '17.00', '2017-04-12', '2', '1', '');
INSERT INTO `producto` VALUES ('122903', 'S/N', 'PRODUCT-001-PR', 'ENTREGA PRUEBA LOTES', '0', '26', '2017', '17.00', '2017-04-12', '2', '1', '');
INSERT INTO `producto` VALUES ('122904', 'S/N', 'PRODUCT-001-PR', 'ENTREGA PRUEBA LOTES', '0', '26', '2017', '17.00', '2017-04-12', '2', '1', '');
INSERT INTO `producto` VALUES ('122905', 'S/N', 'PRODUCT-001-PR', 'ENTREGA PRUEBA LOTES', '0', '26', '2017', '17.00', '2017-04-12', '2', '1', '');
INSERT INTO `producto` VALUES ('122906', 'S/N', 'PRODUCT-001-PR', 'ENTREGA PRUEBA LOTES', '0', '26', '2017', '17.00', '2017-04-12', '2', '1', '');
INSERT INTO `producto` VALUES ('122907', 'S/N', 'PRODUCT-001-PR', 'ENTREGA PRUEBA LOTES', '0', '26', '2017', '17.00', '2017-04-12', '2', '1', '');
INSERT INTO `producto` VALUES ('122908', 'S/N', 'PRODUCT-001-PR', 'ENTREGA PRUEBA LOTES', '0', '26', '2017', '17.00', '2017-04-12', '2', '1', '');
INSERT INTO `producto` VALUES ('122909', 'S/N', 'PRODUCT-001-PR', 'ENTREGA PRUEBA LOTES', '0', '26', '2017', '17.00', '2017-04-12', '2', '1', '');
INSERT INTO `producto` VALUES ('122910', 'S/N', 'PRODUCT-001-PR', 'ENTREGA PRUEBA LOTES', '0', '26', '2017', '17.00', '2017-04-12', '2', '1', '');
INSERT INTO `producto` VALUES ('122911', 'S/N', 'PRODUCT-001-PR', 'ENTREGA PRUEBA LOTES', '0', '26', '2017', '17.00', '2017-04-12', '2', '1', '');
INSERT INTO `producto` VALUES ('122912', 'S/N', 'PRODUCT-001-PR', 'ENTREGA PRUEBA LOTES', '0', '26', '2017', '17.00', '2017-04-12', '2', '1', '');
INSERT INTO `producto` VALUES ('122913', 'S/N', 'PRODUCT-001-PR', 'ENTREGA PRUEBA LOTES', '0', '26', '2017', '17.00', '2017-04-12', '2', '1', '');
INSERT INTO `producto` VALUES ('122914', 'S/N', 'PRODUCT-001-PR', 'ENTREGA PRUEBA LOTES', '0', '26', '2017', '17.00', '2017-04-12', '2', '1', '');
INSERT INTO `producto` VALUES ('122915', 'S/N', 'PRODUCT-001-PR', 'ENTREGA PRUEBA LOTES', '0', '26', '2017', '17.00', '2017-04-12', '2', '1', '');
INSERT INTO `producto` VALUES ('122916', 'S/N', 'PRODUCT-001-PR', 'ENTREGA PRUEBA LOTES', '0', '26', '2017', '17.00', '2017-04-12', '2', '1', '');
INSERT INTO `producto` VALUES ('122917', 'S/N', 'PRODUCT-001-PR', 'ENTREGA PRUEBA LOTES', '0', '26', '2017', '17.00', '2017-04-12', '2', '1', '');
INSERT INTO `producto` VALUES ('122918', 'S/N', 'PRODUCT-001-PR', 'ENTREGA PRUEBA LOTES', '0', '26', '2017', '17.00', '2017-04-12', '2', '1', '');
INSERT INTO `producto` VALUES ('122919', 'S/N', 'PRODUCT-001-PR', 'ENTREGA PRUEBA LOTES', '0', '26', '2017', '17.00', '2017-04-12', '2', '1', '');
INSERT INTO `producto` VALUES ('122920', 'S/N', 'PRODUCT-001-PR', 'ENTREGA PRUEBA LOTES', '0', '26', '2017', '17.00', '2017-04-12', '2', '1', '');
INSERT INTO `producto` VALUES ('122921', 'S/N', 'PRODUCT-001-PR', 'ENTREGA PRUEBA LOTES', '0', '26', '2017', '17.00', '2017-04-12', '2', '1', '');
INSERT INTO `producto` VALUES ('122922', 'S/N', 'PRODUCT-001-PR', 'ENTREGA PRUEBA LOTES', '0', '26', '2017', '17.00', '2017-04-12', '2', '1', '');
INSERT INTO `producto` VALUES ('122923', 'S/N', 'PRODUCT-001-PR', 'ENTREGA PRUEBA LOTES', '0', '26', '2017', '17.00', '2017-04-12', '2', '1', '');
INSERT INTO `producto` VALUES ('122924', 'S/N', 'PRODUCT-001-PR', 'ENTREGA PRUEBA LOTES', '0', '26', '2017', '17.00', '2017-04-12', '2', '1', '');
INSERT INTO `producto` VALUES ('122925', 'S/N', 'PRODUCT-001-PR', 'ENTREGA PRUEBA LOTES', '0', '26', '2017', '17.00', '2017-04-12', '2', '1', '');
INSERT INTO `producto` VALUES ('122926', 'S/N', 'PRODUCT-001-PR', 'ENTREGA PRUEBA LOTES', '0', '26', '2017', '17.00', '2017-04-12', '2', '1', '');
INSERT INTO `producto` VALUES ('122927', 'S/N', 'PRODUCT-001-PR', 'ENTREGA PRUEBA LOTES', '0', '26', '2017', '17.00', '2017-04-12', '2', '1', '');
INSERT INTO `producto` VALUES ('122928', 'S/N', 'PRODUCT-001-PR', 'ENTREGA PRUEBA LOTES', '0', '26', '2017', '17.00', '2017-04-12', '2', '1', '');
INSERT INTO `producto` VALUES ('122929', 'S/N', 'PRODUCT-001-PR', 'ENTREGA PRUEBA LOTES', '0', '26', '2017', '17.00', '2017-04-12', '2', '1', '');
INSERT INTO `producto` VALUES ('122930', 'S/N', 'PRODUCT-001-PR', 'ENTREGA PRUEBA LOTES', '0', '26', '2017', '17.00', '2017-04-12', '2', '1', '');
INSERT INTO `producto` VALUES ('122931', 'S/N', 'PRODUCT-001-PR', 'ENTREGA PRUEBA LOTES', '0', '26', '2017', '17.00', '2017-04-12', '2', '1', '');
INSERT INTO `producto` VALUES ('122932', 'S/N', 'PRODUCT-001-PR', 'ENTREGA PRUEBA LOTES', '0', '26', '2017', '17.00', '2017-04-12', '2', '1', '');

-- ----------------------------
-- Table structure for proveedor
-- ----------------------------
DROP TABLE IF EXISTS `proveedor`;
CREATE TABLE `proveedor` (
  `id_proveedor` int(11) NOT NULL COMMENT 'Clave única de la tabla proveedor',
  `nombre_proveedor` varchar(50) NOT NULL COMMENT 'Nombre del proveedor',
  PRIMARY KEY (`id_proveedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of proveedor
-- ----------------------------
INSERT INTO `proveedor` VALUES ('1', 'OTRO');

-- ----------------------------
-- Table structure for ubicacion
-- ----------------------------
DROP TABLE IF EXISTS `ubicacion`;
CREATE TABLE `ubicacion` (
  `id_ubicacion` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Clave única de la tabla ubicación',
  `nombre_ubicacion` varchar(20) NOT NULL COMMENT 'Nombre de la ubicación',
  PRIMARY KEY (`id_ubicacion`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of ubicacion
-- ----------------------------
INSERT INTO `ubicacion` VALUES ('1', 'CINET');
INSERT INTO `ubicacion` VALUES ('2', 'ARMAR');
INSERT INTO `ubicacion` VALUES ('3', 'T1');
INSERT INTO `ubicacion` VALUES ('4', 'S3');
INSERT INTO `ubicacion` VALUES ('5', 'S2');
INSERT INTO `ubicacion` VALUES ('6', 'CINT');
INSERT INTO `ubicacion` VALUES ('7', 'T4');
INSERT INTO `ubicacion` VALUES ('8', 'ARM');
INSERT INTO `ubicacion` VALUES ('9', 'T2');
INSERT INTO `ubicacion` VALUES ('10', 'Q3');
INSERT INTO `ubicacion` VALUES ('11', 'T5');
INSERT INTO `ubicacion` VALUES ('12', 'Q1');
INSERT INTO `ubicacion` VALUES ('14', 'Q4');
INSERT INTO `ubicacion` VALUES ('15', 'EXT');
INSERT INTO `ubicacion` VALUES ('16', 'T');
INSERT INTO `ubicacion` VALUES ('17', 'S1');
INSERT INTO `ubicacion` VALUES ('18', 'R1');
INSERT INTO `ubicacion` VALUES ('19', 'ARAMA');
INSERT INTO `ubicacion` VALUES ('20', 'Q2');
INSERT INTO `ubicacion` VALUES ('21', 'S4');
INSERT INTO `ubicacion` VALUES ('22', 'LAB');
INSERT INTO `ubicacion` VALUES ('23', 'C10');
INSERT INTO `ubicacion` VALUES ('24', 'CIN01');
INSERT INTO `ubicacion` VALUES ('25', 'CIENT');
INSERT INTO `ubicacion` VALUES ('26', 'T3');
INSERT INTO `ubicacion` VALUES ('27', 'MAQUE');
INSERT INTO `ubicacion` VALUES ('28', 'S5');
INSERT INTO `ubicacion` VALUES ('29', 'MAQ');
INSERT INTO `ubicacion` VALUES ('30', 'CIN');
INSERT INTO `ubicacion` VALUES ('31', 'R2');

-- ----------------------------
-- Table structure for usuario
-- ----------------------------
DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario` (
  `nombre_usuario` varchar(50) NOT NULL COMMENT 'Clave única de la tabla usuario',
  `nombres_usuario` varchar(255) DEFAULT NULL COMMENT 'Nombres del usuario',
  `password_usuario` varchar(50) NOT NULL COMMENT 'Contraseña del usuario',
  `rol_usuario` varchar(10) DEFAULT NULL COMMENT 'Rol del usuario',
  PRIMARY KEY (`nombre_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of usuario
-- ----------------------------
INSERT INTO `usuario` VALUES ('gsalazar', 'Gabriel Salazar', '12345', 'admin');
INSERT INTO `usuario` VALUES ('mpalomo', 'Mario Palomo', '12345', 'user');
INSERT INTO `usuario` VALUES ('sperez', 'Santiago Pérez', '12345', 'user');
INSERT INTO `usuario` VALUES ('sreyes', 'Santiago Reyes', '12345', 'admin');
INSERT INTO `usuario` VALUES ('wromero', 'William Romero', '12345', 'user');

-- ----------------------------
-- View structure for count_cliente
-- ----------------------------
DROP VIEW IF EXISTS `count_cliente`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `count_cliente` AS select count(`cliente`.`idPersona`) AS `COUNT(cliente.idPersona)` from `cliente` ;

-- ----------------------------
-- View structure for select_categoria
-- ----------------------------
DROP VIEW IF EXISTS `select_categoria`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `select_categoria` AS select distinct `categoria`.`id_categoria` AS `codigo_categoria`,`categoria`.`nombre_categoria` AS `nombre_categoria` from `categoria` ;

-- ----------------------------
-- View structure for select_chart
-- ----------------------------
DROP VIEW IF EXISTS `select_chart`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `select_chart` AS select `modelo`.`nombre_modelo` AS `producto`,count(`producto`.`id_producto`) AS `total` from (`producto` join `modelo` on((`producto`.`id_modelo` = `modelo`.`codigo_modelo`))) group by `modelo`.`nombre_modelo` ;

-- ----------------------------
-- View structure for select_cliente
-- ----------------------------
DROP VIEW IF EXISTS `select_cliente`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `select_cliente` AS select `cliente`.`identificacionCliente` AS `identificacionCliente`,`persona`.`identificacion_persona` AS `identificacion_persona`,`persona`.`nombres_persona` AS `nombres_persona`,`persona`.`apellidos_persona` AS `apellidos_persona`,`genero`.`id_genero` AS `id_genero`,`genero`.`nombre_genero` AS `nombre_genero`,`estadocivil`.`id_estado_civil` AS `id_estado_civil`,`estadocivil`.`nombre_estado_civil` AS `nombre_estado_civil`,`persona`.`telefono_domicilio_persona` AS `telefono_domicilio_persona`,`persona`.`telefono_celular_persona` AS `telefono_celular_persona`,`persona`.`correo_persona` AS `correo_persona`,`persona`.`fecha_nacimiento_persona` AS `fecha_nacimiento_persona`,`persona`.`pais_nacimiento_persona` AS `pais_nacimiento_persona`,`persona`.`ciudad_nacimiento_persona` AS `ciudad_nacimiento_persona`,`persona`.`direccion_persona` AS `direccion_persona` from (((`cliente` join `persona` on((`cliente`.`idPersona` = `persona`.`identificacion_persona`))) join `genero` on((`persona`.`genero_persona` = `genero`.`id_genero`))) join `estadocivil` on((`persona`.`estado_civil_persona` = `estadocivil`.`id_estado_civil`))) ;

-- ----------------------------
-- View structure for select_contrato
-- ----------------------------
DROP VIEW IF EXISTS `select_contrato`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `select_contrato` AS select `contrato`.`id_contrato` AS `id_contrato`,`persona`.`identificacion_persona` AS `identificacion_persona`,`persona`.`nombres_persona` AS `nombres_persona`,`persona`.`apellidos_persona` AS `apellidos_persona`,`contrato`.`fecha_inicio_contrato` AS `fecha_inicio_contrato`,`contrato`.`fecha_fin_contrato` AS `fecha_fin_contrato`,`contrato`.`descripcion_contrato` AS `descripcion_contrato`,`cliente`.`identificacionCliente` AS `identificacionCliente` from ((`persona` join `cliente` on((`cliente`.`idPersona` = `persona`.`identificacion_persona`))) join `contrato` on((`contrato`.`id_cliente` = `cliente`.`identificacionCliente`))) ;

-- ----------------------------
-- View structure for select_marca
-- ----------------------------
DROP VIEW IF EXISTS `select_marca`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `select_marca` AS select distinct `marca`.`id_marca` AS `codigo_marca`,`marca`.`nombre_marca` AS `nombre_marca` from `marca` ;

-- ----------------------------
-- View structure for select_modelo_cbx
-- ----------------------------
DROP VIEW IF EXISTS `select_modelo_cbx`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `select_modelo_cbx` AS select `modelo`.`codigo_modelo` AS `id`,`modelo`.`nombre_modelo` AS `nombre` from `modelo` ;

-- ----------------------------
-- View structure for v_acta
-- ----------------------------
DROP VIEW IF EXISTS `v_acta`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_acta` AS select `acta`.`id_acta` AS `acta`,`acta`.`tipo_acta` AS `tipo`,date_format(`acta`.`fecha_acta`,'%d-%m-%Y') AS `fecha`,`acta`.`hora_acta` AS `hora`,`acta`.`descripcion_acta` AS `descripcion`,`acta`.`id_contrato` AS `contrato`,`usuario`.`nombres_usuario` AS `usuario`,`persona`.`identificacion_persona` AS `cedula`,`persona`.`nombres_persona` AS `nombre`,`persona`.`apellidos_persona` AS `apellido`,(select count(0) from `detalleacta` where (`detalleacta`.`id_acta` = `acta`.`id_acta`) limit 1) AS `cantidad` from ((((`acta` join `contrato` on((`acta`.`id_contrato` = `contrato`.`id_contrato`))) join `cliente` on((`contrato`.`id_cliente` = `cliente`.`identificacionCliente`))) join `persona` on((`cliente`.`idPersona` = `persona`.`identificacion_persona`))) join `usuario` on((`acta`.`id_usuario` = `usuario`.`nombre_usuario`))) ;

-- ----------------------------
-- View structure for v_actadetalle
-- ----------------------------
DROP VIEW IF EXISTS `v_actadetalle`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_actadetalle` AS select `detalleacta`.`id_acta` AS `acta`,`producto`.`serie_producto` AS `serie`,`modelo`.`codigo_modelo` AS `codigo`,`modelo`.`nombre_modelo` AS `modelo`,`categoria`.`nombre_categoria` AS `categoria`,`acta`.`id_contrato` AS `contrato` from ((((`detalleacta` join `producto` on((`detalleacta`.`id_producto` = `producto`.`id_producto`))) join `modelo` on((`producto`.`id_modelo` = `modelo`.`codigo_modelo`))) join `categoria` on((`modelo`.`id_categoria` = `categoria`.`id_categoria`))) join `acta` on((`detalleacta`.`id_acta` = `acta`.`id_acta`))) ;

-- ----------------------------
-- View structure for v_almacenchart
-- ----------------------------
DROP VIEW IF EXISTS `v_almacenchart`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_almacenchart` AS select `ubicacion`.`id_ubicacion` AS `id`,`ubicacion`.`nombre_ubicacion` AS `name`,(select count(0) from `producto` where (`producto`.`id_ubicacion_producto` = `ubicacion`.`id_ubicacion`)) AS `y` from `ubicacion` order by `y` desc limit 10 ;

-- ----------------------------
-- View structure for v_asdasd
-- ----------------------------
DROP VIEW IF EXISTS `v_asdasd`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_asdasd` AS select `ubicacion`.`nombre_ubicacion` AS `ubicacion`,`modelo`.`nombre_modelo` AS `nombre`,`modelo`.`codigo_modelo` AS `codigo`,`categoria`.`nombre_categoria` AS `categoria`,`marca`.`nombre_marca` AS `marca`,count(0) AS `cantidad` from ((((`ubicacion` join `producto` on((`producto`.`id_ubicacion_producto` = `ubicacion`.`id_ubicacion`))) join `modelo` on((`producto`.`id_modelo` = `modelo`.`codigo_modelo`))) join `categoria` on((`modelo`.`id_categoria` = `categoria`.`id_categoria`))) join `marca` on((`modelo`.`id_marca` = `marca`.`id_marca`))) group by `modelo`.`codigo_modelo` ;

-- ----------------------------
-- View structure for v_categoria
-- ----------------------------
DROP VIEW IF EXISTS `v_categoria`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_categoria` AS select `categoria`.`id_categoria` AS `id`,`categoria`.`nombre_categoria` AS `label`,(select count(`modelo`.`codigo_modelo`) from `modelo` where (`modelo`.`id_categoria` = `categoria`.`id_categoria`)) AS `data` from `categoria` order by (select count(`modelo`.`codigo_modelo`) from `modelo` where (`modelo`.`id_categoria` = `categoria`.`id_categoria`)) desc ;

-- ----------------------------
-- View structure for v_categoriachart
-- ----------------------------
DROP VIEW IF EXISTS `v_categoriachart`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_categoriachart` AS select `categoria`.`id_categoria` AS `id`,`categoria`.`nombre_categoria` AS `name`,(select count(`modelo`.`codigo_modelo`) from `modelo` where (`modelo`.`id_categoria` = `categoria`.`id_categoria`)) AS `y` from `categoria` order by (select count(`modelo`.`codigo_modelo`) from `modelo` where (`modelo`.`id_categoria` = `categoria`.`id_categoria`)) desc limit 10 ;

-- ----------------------------
-- View structure for v_cliente
-- ----------------------------
DROP VIEW IF EXISTS `v_cliente`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_cliente` AS select `persona`.`identificacion_persona` AS `cedula`,`persona`.`nombres_persona` AS `nombre`,`persona`.`apellidos_persona` AS `apellido`,`genero`.`nombre_genero` AS `genero`,`estadocivil`.`nombre_estado_civil` AS `estado`,`persona`.`telefono_domicilio_persona` AS `domicilio`,`persona`.`telefono_celular_persona` AS `celular`,`persona`.`correo_persona` AS `correo`,`persona`.`pais_nacimiento_persona` AS `pais`,(select count(`contrato`.`id_contrato`) from `contrato` where (`contrato`.`id_cliente` = `cliente`.`identificacionCliente`)) AS `cantidad`,`persona`.`ciudad_nacimiento_persona` AS `ciudad`,date_format(`persona`.`fecha_nacimiento_persona`,'%Y-%m-%d') AS `fecha`,timestampdiff(YEAR,`persona`.`fecha_nacimiento_persona`,curdate()) AS `edad`,`persona`.`direccion_persona` AS `direccion` from (((`persona` join `genero` on((`persona`.`genero_persona` = `genero`.`id_genero`))) join `cliente` on((`cliente`.`idPersona` = `persona`.`identificacion_persona`))) join `estadocivil` on((`persona`.`estado_civil_persona` = `estadocivil`.`id_estado_civil`))) ;

-- ----------------------------
-- View structure for v_contrato
-- ----------------------------
DROP VIEW IF EXISTS `v_contrato`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_contrato` AS select `contrato`.`id_contrato` AS `numero`,date_format(`contrato`.`fecha_inicio_contrato`,'%Y-%m-%d') AS `inicio`,date_format(`contrato`.`fecha_fin_contrato`,'%Y-%m-%d') AS `final`,`contrato`.`descripcion_contrato` AS `descripcion`,`persona`.`identificacion_persona` AS `cedula`,concat(`persona`.`nombres_persona`,' ',`persona`.`apellidos_persona`) AS `cliente`,(to_days(`contrato`.`fecha_fin_contrato`) - to_days(curdate())) AS `vigencia` from ((`contrato` join `cliente` on((`contrato`.`id_cliente` = `cliente`.`identificacionCliente`))) join `persona` on((`cliente`.`idPersona` = `persona`.`identificacion_persona`))) ;

-- ----------------------------
-- View structure for v_datos_producto
-- ----------------------------
DROP VIEW IF EXISTS `v_datos_producto`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_datos_producto` AS select `modelo`.`codigo_modelo` AS `codigo`,`modelo`.`nombre_modelo` AS `nombre`,`marca`.`nombre_marca` AS `marca`,`categoria`.`nombre_categoria` AS `categoria` from ((`modelo` join `marca` on((`modelo`.`id_marca` = `marca`.`id_marca`))) join `categoria` on((`modelo`.`id_categoria` = `categoria`.`id_categoria`))) ;

-- ----------------------------
-- View structure for v_estadocivil
-- ----------------------------
DROP VIEW IF EXISTS `v_estadocivil`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_estadocivil` AS select `estadocivil`.`id_estado_civil` AS `codigo`,`estadocivil`.`nombre_estado_civil` AS `nombre` from `estadocivil` ;

-- ----------------------------
-- View structure for v_evento
-- ----------------------------
DROP VIEW IF EXISTS `v_evento`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_evento` AS select `evento`.`tipo_evento` AS `tipo`,date_format(`evento`.`hora_evento`,'%Y-%m-%d %H:%i:%s') AS `hora`,`evento`.`nombre_tabla` AS `tabla`,`evento`.`valor_anterior` AS `anterior`,`evento`.`valor_nuevo` AS `nuevo`,`evento`.`ip_usuario` AS `ip`,`evento`.`usuario` AS `usuario` from `evento` order by `evento`.`hora_evento` desc ;

-- ----------------------------
-- View structure for v_genero
-- ----------------------------
DROP VIEW IF EXISTS `v_genero`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_genero` AS select `genero`.`id_genero` AS `codigo`,`genero`.`nombre_genero` AS `nombre` from `genero` ;

-- ----------------------------
-- View structure for v_lugar
-- ----------------------------
DROP VIEW IF EXISTS `v_lugar`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_lugar` AS select `modelo`.`codigo_modelo` AS `codigo`,`modelo`.`nombre_modelo` AS `nombre`,`categoria`.`nombre_categoria` AS `categoria`,`marca`.`nombre_marca` AS `marca`,`ubicacion`.`nombre_ubicacion` AS `ubicacion`,count(`modelo`.`codigo_modelo`) AS `cantidad` from ((((`modelo` join `categoria` on((`modelo`.`id_categoria` = `categoria`.`id_categoria`))) join `marca` on((`modelo`.`id_marca` = `marca`.`id_marca`))) join `producto` on((`producto`.`id_modelo` = `modelo`.`codigo_modelo`))) join `ubicacion` on((`producto`.`id_ubicacion_producto` = `ubicacion`.`id_ubicacion`))) group by `modelo`.`codigo_modelo` ;

-- ----------------------------
-- View structure for v_marca
-- ----------------------------
DROP VIEW IF EXISTS `v_marca`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_marca` AS select `marca`.`id_marca` AS `id`,`marca`.`nombre_marca` AS `label` from `marca` ;

-- ----------------------------
-- View structure for v_modelo
-- ----------------------------
DROP VIEW IF EXISTS `v_modelo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_modelo` AS select `modelo`.`codigo_modelo` AS `codigo`,`modelo`.`nombre_modelo` AS `nombre`,`categoria`.`nombre_categoria` AS `categoria`,`marca`.`nombre_marca` AS `marca`,`c_producto`(`modelo`.`codigo_modelo`) AS `cantidad` from ((`modelo` left join `marca` on((`modelo`.`id_marca` = `marca`.`id_marca`))) left join `categoria` on((`modelo`.`id_categoria` = `categoria`.`id_categoria`))) order by `modelo`.`nombre_modelo` ;

-- ----------------------------
-- View structure for v_modelo_ubicacion
-- ----------------------------
DROP VIEW IF EXISTS `v_modelo_ubicacion`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_modelo_ubicacion` AS select `ubicacion`.`nombre_ubicacion` AS `ubicacion`,`modelo`.`nombre_modelo` AS `nombre`,`modelo`.`codigo_modelo` AS `codigo`,`categoria`.`nombre_categoria` AS `categoria`,`marca`.`nombre_marca` AS `marca`,count(0) AS `cantidad` from ((((`ubicacion` join `producto` on((`producto`.`id_ubicacion_producto` = `ubicacion`.`id_ubicacion`))) join `modelo` on((`producto`.`id_modelo` = `modelo`.`codigo_modelo`))) join `categoria` on((`modelo`.`id_categoria` = `categoria`.`id_categoria`))) join `marca` on((`modelo`.`id_marca` = `marca`.`id_marca`))) group by `modelo`.`codigo_modelo` ;

-- ----------------------------
-- View structure for v_producto
-- ----------------------------
DROP VIEW IF EXISTS `v_producto`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_producto` AS select `producto`.`serie_producto` AS `serie`,`modelo`.`codigo_modelo` AS `codigo`,`modelo`.`nombre_modelo` AS `nombre`,`producto`.`observacion_producto` AS `descripcion`,`marca`.`nombre_marca` AS `marca`,`producto`.`meses_garantia_producto` AS `meses`,`producto`.`anio_fabricacion` AS `anio`,`producto`.`peso_neto_producto` AS `peso`,date_format(`producto`.`fecha_ingreso_producto`,'%Y-%m-%d') AS `fecha`,`categoria`.`nombre_categoria` AS `categoria`,`ubicacion`.`nombre_ubicacion` AS `ubicacion` from ((((`producto` join `modelo` on((`producto`.`id_modelo` = `modelo`.`codigo_modelo`))) join `marca` on((`modelo`.`id_marca` = `marca`.`id_marca`))) join `categoria` on((`modelo`.`id_categoria` = `categoria`.`id_categoria`))) join `ubicacion` on((`producto`.`id_ubicacion_producto` = `ubicacion`.`id_ubicacion`))) ;

-- ----------------------------
-- View structure for v_proveedor
-- ----------------------------
DROP VIEW IF EXISTS `v_proveedor`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_proveedor` AS select `proveedor`.`id_proveedor` AS `codigo`,`proveedor`.`nombre_proveedor` AS `proveedor` from `proveedor` ;

-- ----------------------------
-- View structure for v_ubicacion
-- ----------------------------
DROP VIEW IF EXISTS `v_ubicacion`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_ubicacion` AS select `ubicacion`.`id_ubicacion` AS `codigo`,`ubicacion`.`nombre_ubicacion` AS `label`,(select count(`producto`.`id_producto`) from (`ubicacion` join `producto` on((`producto`.`id_ubicacion_producto` = `ubicacion`.`id_ubicacion`))) where (`producto`.`id_ubicacion_producto` = `codigo`) group by `ubicacion`.`id_ubicacion`) AS `data` from `ubicacion` ;

-- ----------------------------
-- View structure for v_ultimosagregados
-- ----------------------------
DROP VIEW IF EXISTS `v_ultimosagregados`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_ultimosagregados` AS select `v_producto`.`serie` AS `serie`,`v_producto`.`codigo` AS `codigo`,`v_producto`.`nombre` AS `nombre`,`v_producto`.`descripcion` AS `descripcion`,`v_producto`.`marca` AS `marca`,`v_producto`.`meses` AS `meses`,`v_producto`.`anio` AS `anio`,`v_producto`.`peso` AS `peso`,`v_producto`.`fecha` AS `fecha`,`v_producto`.`categoria` AS `categoria`,`v_producto`.`ubicacion` AS `ubicacion` from `v_producto` order by `v_producto`.`fecha` desc limit 10 ;

-- ----------------------------
-- View structure for v_usuario
-- ----------------------------
DROP VIEW IF EXISTS `v_usuario`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_usuario` AS select `usuario`.`nombre_usuario` AS `usuario`,`usuario`.`nombres_usuario` AS `nombre` from `usuario` ;

-- ----------------------------
-- Procedure structure for select_clienteContrato
-- ----------------------------
DROP PROCEDURE IF EXISTS `select_clienteContrato`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `select_clienteContrato`(IN `acta` varchar(50))
BEGIN
	SELECT
persona.identificacion_persona,
CONCAT(persona.nombres_persona,' ',apellidos_persona),
CONCAT(persona.telefono_domicilio_persona,' ',persona.telefono_celular_persona),
persona.direccion_persona
FROM
acta
INNER JOIN detallecontrato ON detallecontrato.id_acta = acta.id_acta
INNER JOIN contrato ON detallecontrato.id_contrato = contrato.id_contrato
INNER JOIN cliente ON contrato.id_cliente = cliente.identificacionCliente
INNER JOIN persona ON cliente.idPersona = persona.identificacion_persona
WHERE acta.id_acta=acta LIMIT 1;


END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for select_detalle
-- ----------------------------
DROP PROCEDURE IF EXISTS `select_detalle`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `select_detalle`(IN `contrato` varchar(50))
BEGIN
	SELECT
detallecontrato.id_detalleContrato,
detallecontrato.id_contrato,
producto.id_producto,
modelo.nombre_modelo,
marca.nombre_marca,
estadocontrato.id_estado,
estadocontrato.`nombre-estado`,
detallecontrato.observacion_detalle,
acta.id_acta,
tipo_acta
FROM
producto
INNER JOIN modelo ON producto.id_modelo = modelo.codigo_modelo
INNER JOIN marca ON modelo.id_marca = marca.id_marca
INNER JOIN detallecontrato ON detallecontrato.id_producto = producto.id_producto
INNER JOIN estadocontrato ON detallecontrato.id_estado_detalle = estadocontrato.id_estado
INNER JOIN acta ON detallecontrato.id_acta = acta.id_acta
WHERE detallecontrato.id_contrato=contrato;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for select_detalleActa
-- ----------------------------
DROP PROCEDURE IF EXISTS `select_detalleActa`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `select_detalleActa`(IN `acta` varchar(50))
BEGIN
	SELECT
producto.id_producto,
modelo.nombre_modelo,
categoria.nombre_categoria,
marca.nombre_marca
FROM
detallecontrato
INNER JOIN acta ON detallecontrato.id_acta = acta.id_acta
INNER JOIN producto ON detallecontrato.id_producto = producto.id_producto
INNER JOIN modelo ON producto.id_modelo = modelo.codigo_modelo
INNER JOIN categoria ON modelo.id_categoria = categoria.id_categoria
INNER JOIN marca ON modelo.id_marca = marca.id_marca
WHERE acta.id_acta=acta;


END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for select_productos
-- ----------------------------
DROP PROCEDURE IF EXISTS `select_productos`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `select_productos`(IN `contrato` varchar(50))
BEGIN
	SELECT
producto.id_producto,
modelo.nombre_modelo,
categoria.nombre_categoria,
marca.nombre_marca
FROM
detallecontrato
INNER JOIN producto ON detallecontrato.id_producto = producto.id_producto
INNER JOIN modelo ON producto.id_modelo = modelo.codigo_modelo
INNER JOIN marca ON modelo.id_marca = marca.id_marca
INNER JOIN categoria ON modelo.id_categoria = categoria.id_categoria
WHERE id_contrato=contrato;



END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for sp_articulo
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_articulo`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_articulo`(serie VARCHAR(50), codigo VARCHAR(50), observacion VARCHAR(250), meses tinyint, anio year, peso decimal(2), fecha date, ubicacion VARCHAR(50), proveedor VARCHAR(50), usuario VARCHAR(70))
BEGIN

IF NOT EXISTS (SELECT id_producto FROM producto WHERE producto.serie_producto= serie AND producto.id_modelo=codigo) OR serie='S/N'  THEN
	INSERT INTO `producto` (
	`serie_producto`,
	`id_modelo`,
	`observacion_producto`,
	`meses_garantia_producto`,
	`anio_fabricacion`,
	`peso_neto_producto`,
	`fecha_ingreso_producto`,
	`id_ubicacion_producto`,
	`id_proveedor`,
	usuario
)
VALUES
	(
		serie,
		codigo,
		observacion ,
		meses,
		anio,
		peso,
		fecha,
		(SELECT id_ubicacion FROM ubicacion WHERE nombre_ubicacion=ubicacion LIMIT 1),
		(SELECT id_proveedor FROM proveedor WHERE nombre_proveedor=proveedor LIMIT 1),
	usuario
	);
END IF;

END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for acta_idCliente
-- ----------------------------
DROP FUNCTION IF EXISTS `acta_idCliente`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `acta_idCliente`(`acta` varchar(50)) RETURNS varchar(20) CHARSET latin1
BEGIN
SELECT
persona.identificacion_persona INTO @s
FROM
acta
INNER JOIN detallecontrato ON detallecontrato.id_acta = acta.id_acta
INNER JOIN contrato ON detallecontrato.id_contrato = contrato.id_contrato
INNER JOIN cliente ON contrato.id_cliente = cliente.identificacionCliente
INNER JOIN persona ON cliente.idPersona = persona.identificacion_persona
WHERE acta.id_acta=acta LIMIT 1;


	RETURN @s;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for acta_idContrato
-- ----------------------------
DROP FUNCTION IF EXISTS `acta_idContrato`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `acta_idContrato`(`acta` varchar(50)) RETURNS varchar(50) CHARSET latin1
BEGIN
	SELECT DISTINCT
contrato.id_contrato INTO @s
FROM
acta
INNER JOIN detallecontrato ON detallecontrato.id_acta = acta.id_acta
INNER JOIN contrato ON detallecontrato.id_contrato = contrato.id_contrato
WHERE acta.id_acta=acta LIMIT 1;


	RETURN @s;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for acta_nombreCliente
-- ----------------------------
DROP FUNCTION IF EXISTS `acta_nombreCliente`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `acta_nombreCliente`(`acta` varchar(50)) RETURNS varchar(20) CHARSET latin1
BEGIN
	SELECT DISTINCT
persona.nombres_persona INTO @s
FROM
acta
INNER JOIN empleado ON acta.id_empleado = empleado.identificacion_empleado
INNER JOIN persona ON empleado.id_persona = persona.identificacion_persona
WHERE id_acta=acta;

	RETURN @s;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for actualizar_empleado
-- ----------------------------
DROP FUNCTION IF EXISTS `actualizar_empleado`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `actualizar_empleado`(`cedula` varchar(20),`nombre` varchar(40),`apellido` varchar(40),`genero` tinyint,`estado` tinyint,`domicilio` varchar(20),`celular` varchar(20),`correo` varchar(100),`fecha` date,`pais`  varchar(30),`ciudad` varchar(30),`direccion` varchar(100), cargo int) RETURNS varchar(100) CHARSET latin1
BEGIN
DECLARE mensaje VARCHAR(100);
	
UPDATE `persona`
SET `nombres_persona` = nombre,
 `apellidos_persona` = apellido,
 `genero_persona` = genero,
 `estado_civil_persona` = estado,
 `telefono_domicilio_persona` = domicilio,
 `telefono_celular_persona` = celular,
 `correo_persona` = correo,
 `fecha_nacimiento_persona` = fecha,
 `pais_nacimiento_persona` = pais,
 `ciudad_nacimiento_persona` = ciudad,
 `direccion_persona` = direccion
WHERE
	(
		`identificacion_persona` = cedula
	);
UPDATE empleado SET id_cargo=cargo WHERE (id_persona=cedula);

SET mensaje='El empleado ha sido actualizado';


	RETURN mensaje;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for crud_producto
-- ----------------------------
DROP FUNCTION IF EXISTS `crud_producto`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `crud_producto`(`id` varchar(50),`modelo` varchar(100),`categoria` varchar(50),`marca` varchar(50),`observacion` varchar(250)) RETURNS varchar(100) CHARSET latin1
BEGIN
	DECLARE mensaje VARCHAR(100);
	DECLARE _marca INT;
	DECLARE _categoria INT;
	DECLARE _modelo VARCHAR(100); 
	
		IF NOT EXISTS (SELECT id_categoria FROM categoria WHERE nombre_categoria=categoria) THEN
			INSERT INTO categoria (nombre_categoria) VALUES (categoria);
		END IF;

		IF NOT EXISTS (SELECT id_marca FROM marca WHERE nombre_marca=marca) THEN
			INSERT INTO marca (nombre_marca) VALUES (marca);
		END IF;

		SELECT id_marca INTO _marca FROM marca WHERE nombre_marca=marca;
		SELECT id_categoria INTO _categoria FROM categoria WHERE nombre_categoria=categoria;
		
		IF NOT EXISTS (SELECT id_modelo FROM modelo WHERE nombre_modelo=modelo) THEN
			INSERT INTO `modelo` (
									`nombre_modelo`,
									`id_categoria`,
									`id_marca`
														)
									VALUES
								(modelo, _categoria, _marca);
								END IF;
		
		SELECT id_modelo INTO _modelo FROM modelo WHERE nombre_modelo=modelo;

		
		IF EXISTS (SELECT id_producto FROM producto WHERE id_producto=id) THEN
			SET mensaje= 'El número de serie ya existe';
		ELSE
				INSERT INTO `producto` (
										`id_producto`,
										`id_modelo`,
										`observacion_producto`
															)
							VALUES
									(id, _modelo, observacion);
		SET mensaje= 'El producto ha sido registrado';
												END IF;


	RETURN mensaje;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for c_producto
-- ----------------------------
DROP FUNCTION IF EXISTS `c_producto`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `c_producto`(`modelo` varchar(50)) RETURNS int(5)
BEGIN
SELECT
COUNT(producto.id_modelo) INTO @a
FROM
producto
INNER JOIN modelo ON producto.id_modelo = modelo.codigo_modelo
WHERE modelo.codigo_modelo=modelo;


	RETURN @a;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for guardar_articulo
-- ----------------------------
DROP FUNCTION IF EXISTS `guardar_articulo`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `guardar_articulo`(serie VARCHAR(50), codigo VARCHAR(50), observacion VARCHAR(250), meses tinyint, anio year, peso decimal(2), fecha date, ubicacion VARCHAR(50), proveedor VARCHAR(50), usuario VARCHAR(100)) RETURNS varchar(100) CHARSET utf8
BEGIN
	DECLARE mensaje VARCHAR(100);

INSERT INTO `producto` (
	`serie_producto`,
	`id_modelo`,
	`observacion_producto`,
	`meses_garantia_producto`,
	`anio_fabricacion`,
	`peso_neto_producto`,
	`fecha_ingreso_producto`,
	`id_ubicacion_producto`,
	`id_proveedor`,
	usuario
)
VALUES
	(
		serie,
		codigo,
		observacion ,
		meses,
		anio,
		peso,
		fecha,
		(SELECT id_ubicacion FROM ubicacion WHERE nombre_ubicacion=ubicacion LIMIT 1),
		(SELECT id_proveedor FROM proveedor WHERE nombre_proveedor=proveedor LIMIT 1),
		usuario
	);

	RETURN '';
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for guardar_detalleContrato
-- ----------------------------
DROP FUNCTION IF EXISTS `guardar_detalleContrato`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `guardar_detalleContrato`(`contrato` varchar(50),`producto` varchar(100)) RETURNS varchar(100) CHARSET latin1
BEGIN
DECLARE mensaje VARCHAR(100);
	IF (contrato='' OR producto='') THEN
		SET mensaje='Ingrese todos los datos';
	ELSE
	INSERT INTO `detallecontrato` (
	`id_contrato`,
	`id_producto`
)
VALUES
	(contrato,producto );

		
END IF;


	RETURN '';
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for guardar_empleado
-- ----------------------------
DROP FUNCTION IF EXISTS `guardar_empleado`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `guardar_empleado`(`cedula` varchar(20),`nombre` varchar(40),`apellido` varchar(40),`genero` varchar(40),`estado` varchar(40),`domicilio` varchar(20),`celular` varchar(20),`correo` varchar(100),`fecha` date,`pais`  varchar(30),`ciudad` varchar(30),`direccion` varchar(100)) RETURNS varchar(100) CHARSET utf8
BEGIN
DECLARE mensaje VARCHAR(100);
	IF EXISTS (SELECT identificacion_empleado FROM empleado WHERE empleado.id_persona=cedula ) THEN
SET mensaje="El empleado ya existe";

ELSE

IF EXISTS(SELECT identificacion_persona FROM persona WHERE identificacion_persona=cedula) THEN
	INSERT INTO empleado(empleado.id_persona) VALUES(cedula);
SET mensaje="El empleado ha sido guardado";
ELSE

INSERT INTO persona (
	identificacion_persona,
	nombres_persona,
	apellidos_persona,
	genero_persona,
	estado_civil_persona,
	telefono_domicilio_persona,
	telefono_celular_persona,
	correo_persona,
	fecha_nacimiento_persona,
	pais_nacimiento_persona,
	ciudad_nacimiento_persona,
	direccion_persona
)
VALUES(cedula,nombre,apellido,
		(SELECT id_genero FROM genero WHERE genero.nombre_genero=genero),
		(SELECT id_estado_civil FROM estadocivil WHERE estadocivil.nombre_estado_civil=estado)		
,domicilio,
		celular,correo,fecha,
		pais,ciudad,direccion);
	INSERT INTO empleado(empleado.id_persona) VALUES(cedula);
SET mensaje="El cliente ha sido guardado";


END IF;

END IF;

	RETURN mensaje;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for guardar_producto
-- ----------------------------
DROP FUNCTION IF EXISTS `guardar_producto`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `guardar_producto`(`codigo` varchar(50),`nombre` varchar(50),`categoria` varchar(50),`marca` varchar(50)) RETURNS varchar(50) CHARSET utf8
BEGIN
DECLARE mensaje VARCHAR(50);
		IF EXISTS (SELECT modelo.codigo_modelo FROM modelo WHERE modelo.codigo_modelo=codigo) THEN
			SET mensaje='El código ya existe';
		ELSE
			IF EXISTS(SELECT nombre_modelo FROM modelo WHERE modelo.nombre_modelo=nombre) THEN
				SET mensaje='El nombre ya existe';
			ELSE
				INSERT INTO `modelo` (
					`codigo_modelo`,
					`nombre_modelo`,
					`id_categoria`,
					`id_marca`
				)
				VALUES (codigo,
								nombre, 
							(SELECT id_categoria FROM categoria WHERE nombre_categoria=categoria LIMIT 1), 
							(SELECT id_marca FROM marca WHERE nombre_marca=marca));
	SET mensaje='El producto ha sido registrado';
			END IF;
			
					


			
		END IF;

	RETURN mensaje;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for IP
-- ----------------------------
DROP FUNCTION IF EXISTS `IP`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `IP`() RETURNS varchar(100) CHARSET latin1
BEGIN
SELECT	SUBSTRING_INDEX(USER(), '@', -1) INTO @A;

	RETURN @A;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for sp_acta
-- ----------------------------
DROP FUNCTION IF EXISTS `sp_acta`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `sp_acta`(`codigo` varchar(20),`tipo` varchar(20),`fecha` date,`hora` time,`contrato` varchar(20), descripcion varchar(50), usuario varchar(50)) RETURNS varchar(100) CHARSET utf8
BEGIN
DECLARE mensaje VARCHAR(100);
	IF (codigo='' OR tipo='' OR fecha='' OR hora ='' OR contrato='' ) THEN
		SET mensaje='Ingrese todos los datos';
	ELSE
		IF EXISTS(SELECT id_acta FROM acta WHERE id_acta=codigo) THEN
			SET mensaje='El código del acta ya se encuentra registrado en la base de datos';
		ELSE
				IF EXISTS(SELECT id_acta FROM acta WHERE id_acta=codigo AND tipo_acta=tipo) THEN
					SET mensaje='Acta ya generada';
				ELSE
					IF NOT EXISTS(SELECT id_contrato FROM contrato WHERE id_contrato=contrato) THEN
						SET mensaje='El contrato no existe';
					ELSE
						
							INSERT INTO acta (id_acta,tipo_acta,fecha_acta,hora_acta,id_contrato, acta.descripcion_acta, acta.id_usuario)
							VALUES(codigo,tipo,fecha,hora,contrato,descripcion,usuario);
							SET mensaje='El acta ha sido generada';
					
				END IF;
			END IF;
		END IF;
	END IF;


	RETURN mensaje;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for sp_cliente
-- ----------------------------
DROP FUNCTION IF EXISTS `sp_cliente`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `sp_cliente`(`cedula` varchar(20),`nombre` varchar(40),`apellido` varchar(40),`genero` varchar(40),`estado` varchar(40),`domicilio` varchar(20),`celular` varchar(20),`correo` varchar(100),`fecha` date,`pais`  varchar(30),`ciudad` varchar(30),`direccion` varchar(100)) RETURNS varchar(100) CHARSET utf8
BEGIN
DECLARE mensaje VARCHAR(100);
	IF EXISTS (SELECT identificacionCliente FROM cliente WHERE idPersona=cedula ) THEN
SET mensaje="El cliente ya existe";

ELSE

IF EXISTS(SELECT identificacion_persona FROM persona WHERE identificacion_persona=cedula) THEN
	INSERT INTO cliente(cliente.idPersona) VALUES(cedula);
SET mensaje="El cliente ha sido guardado";
ELSE

IF EXISTS(SELECT correo_persona FROM persona WHERE correo_persona=correo) THEN
SET mensaje="El correo ya existe";
ELSE

INSERT INTO persona (
	identificacion_persona,
	nombres_persona,
	apellidos_persona,
	genero_persona,
	estado_civil_persona,
	telefono_domicilio_persona,
	telefono_celular_persona,
	correo_persona,
	fecha_nacimiento_persona,
	pais_nacimiento_persona,
	ciudad_nacimiento_persona,
	direccion_persona
)
VALUES(cedula,nombre,apellido,
		(SELECT id_genero FROM genero WHERE genero.nombre_genero=genero),
		(SELECT id_estado_civil FROM estadocivil WHERE estadocivil.nombre_estado_civil=estado)		
,domicilio,
		celular,correo,fecha,
		pais,ciudad,direccion);
	INSERT INTO cliente(cliente.idPersona) VALUES(cedula);
SET mensaje="El cliente ha sido guardado";

END IF;
END IF;

END IF;

	RETURN mensaje;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for sp_contrato
-- ----------------------------
DROP FUNCTION IF EXISTS `sp_contrato`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `sp_contrato`(`id` varchar(50),`inicio` date,`final` date,`descripcion` varchar(250),`cliente` varchar(50)) RETURNS varchar(100) CHARSET utf8
BEGIN
DECLARE mensaje VARCHAR(100);
	IF(id='' OR inicio='' OR final='' OR descripcion='' OR cliente='') THEN
		SET mensaje = 'Ingrese todos los campos';
	
	ELSE
			IF EXISTS (SELECT id_contrato FROM contrato WHERE id_contrato=id) THEN
				SET mensaje = 'Ya existe un contrato con el id ingresado';
			ELSE
				IF EXISTS (SELECT cliente.identificacionCliente FROM cliente WHERE cliente.idPersona=cliente) THEN
				INSERT INTO `contrato` (
					`id_contrato`,
					`fecha_inicio_contrato`,
					`fecha_fin_contrato`,
					`descripcion_contrato`,
					`id_cliente`
					)
				VALUES(	id,inicio,final,descripcion,(SELECT cliente.identificacionCliente FROM cliente WHERE cliente.idPersona=cliente));					

					SET mensaje='El contrato ha sido registrado';
				ELSE
					SET mensaje= 'El cliente no exite';
				END IF;
			END if;
	

END IF;



	RETURN mensaje;
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `clienteInsert`;
DELIMITER ;;
CREATE TRIGGER `clienteInsert` AFTER INSERT ON `cliente` FOR EACH ROW INSERT INTO `evento` (`tipo_evento`,`hora_evento`,`nombre_tabla`,`valor_anterior`,`valor_nuevo`,`ip_usuario`,usuario)
VALUES('INSERT',NOW(),'cliente','',new.identificacionCliente,IP(),new.usuario)
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `modeloInsert`;
DELIMITER ;;
CREATE TRIGGER `modeloInsert` AFTER INSERT ON `modelo` FOR EACH ROW INSERT INTO `evento` (
	`tipo_evento`,
	`hora_evento`,
	`nombre_tabla`,
	`valor_anterior`,
	`valor_nuevo`,
	`ip_usuario`
)
VALUES
	(
		'INSERT',
		NOW(),
		'modelo',
		'',
		new.codigo_modelo,
		IP()
	)
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `triggerNuevoCargo`;
DELIMITER ;;
CREATE TRIGGER `triggerNuevoCargo` AFTER INSERT ON `persona` FOR EACH ROW BEGIN
	INSERT INTO `evento` (`tipo_evento`,`hora_evento`,`valor_anterior`,`valor_nuevo`,	`ip_usuario`)
		VALUES('INSERT',NOW(),'',new.identificacion_persona,IP()
	); 



END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `triggerActPersona`;
DELIMITER ;;
CREATE TRIGGER `triggerActPersona` AFTER UPDATE ON `persona` FOR EACH ROW BEGIN
	IF(old.identificacion_persona <> new.identificacion_persona) THEN
	INSERT INTO `evento` (`tipo_evento`,`hora_evento`,`valor_anterior`,`valor_nuevo`,	`ip_usuario`)
		VALUES('UPDATE',NOW(),old.identificacion_persona,new.identificacion_persona,IP()); 

END IF;

	INSERT INTO `evento` (`tipo_evento`,`hora_evento`,`valor_anterior`,`valor_nuevo`,	`ip_usuario`)
		VALUES('UPDATE',NOW(),old.nombres_persona,new.nombres_persona,IP()
	); 
	INSERT INTO `evento` (`tipo_evento`,`hora_evento`,`valor_anterior`,`valor_nuevo`,	`ip_usuario`)
		VALUES('UPDATE',NOW(),old.apellidos_persona,new.apellidos_persona,IP()
	); 

	INSERT INTO `evento` (`tipo_evento`,`hora_evento`,`valor_anterior`,`valor_nuevo`,	`ip_usuario`)
		VALUES('UPDATE',NOW(),old.genero_persona,new.genero_persona,IP()
	); 

END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `productoInsertt`;
DELIMITER ;;
CREATE TRIGGER `productoInsertt` AFTER INSERT ON `producto` FOR EACH ROW INSERT INTO `evento` (`tipo_evento`,`hora_evento`,`nombre_tabla`,`valor_anterior`,`valor_nuevo`,`ip_usuario`,usuario)
VALUES('INSERT',NOW(),'producto','',new.serie_producto,IP(),new.usuario)
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `productoInsert`;
DELIMITER ;;
CREATE TRIGGER `productoInsert` AFTER INSERT ON `producto` FOR EACH ROW INSERT INTO `evento` (`tipo_evento`,`hora_evento`,`nombre_tabla`,`valor_anterior`,`valor_nuevo`,`ip_usuario`,usuario)
VALUES('INSERT',NOW(),'producto','',new.serie_producto,IP(),new.usuario)
;;
DELIMITER ;
