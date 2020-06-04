USE `essentialmode`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_cardealer','Concessionária',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_cardealer','Concessionária',1)
;

INSERT INTO `jobs` (name, label) VALUES
	('cardealer','Concessionária')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('cardealer',0,'recruit','Estagiário',10,'{}','{}'),
	('cardealer',1,'novice','Vendedor',25,'{}','{}'),
	('cardealer',2,'experienced','Gerente',40,'{}','{}'),
	('cardealer',3,'boss','Patrão',0,'{}','{}')
;

CREATE TABLE `cardealer_vehicles` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`vehicle` varchar(255) NOT NULL,
	`price` int(11) NOT NULL,

	PRIMARY KEY (`id`)
);

CREATE TABLE `vehicle_sold` (
	`client` VARCHAR(50) NOT NULL,
	`model` VARCHAR(50) NOT NULL,
	`plate` VARCHAR(50) NOT NULL,
	`soldby` VARCHAR(50) NOT NULL,
	`date` VARCHAR(50) NOT NULL,

	PRIMARY KEY (`plate`)
);

CREATE TABLE `owned_vehicles` (
	`owner` varchar(22) NOT NULL,
	`plate` varchar(12) NOT NULL,
	`vehicle` longtext,
	`type` VARCHAR(20) NOT NULL DEFAULT 'car',
	`job` VARCHAR(20) NOT NULL,
	`stored` TINYINT(1) NOT NULL DEFAULT '0',

	PRIMARY KEY (`plate`)
);

CREATE TABLE `rented_vehicles` (
	`vehicle` varchar(60) NOT NULL,
	`plate` varchar(12) NOT NULL,
	`player_name` varchar(255) NOT NULL,
	`base_price` int(11) NOT NULL,
	`rent_price` int(11) NOT NULL,
	`owner` varchar(22) NOT NULL,

	PRIMARY KEY (`plate`)
);

CREATE TABLE `vehicle_categories` (
	`name` varchar(60) NOT NULL,
	`label` varchar(60) NOT NULL,

	PRIMARY KEY (`name`)
);

INSERT INTO `vehicle_categories` (name, label) VALUES
	('compacts','Compactos'),
	('coupes','Coupes'),
	('sedans','Sedans'),
	('sports','Esportivos'),
	('sportsclassics','Clássicos'),
	('super','Supers'),
	('muscle','Muscle'),
	('offroad','Caminhonetes'),
	('suvs','SUVs'),
	('vans','Vans'),
	('motorcycles','Motos')
;

CREATE TABLE `vehicles` (
	`name` varchar(60) NOT NULL,
	`model` varchar(60) NOT NULL,
	`price` int(11) NOT NULL,
	`category` varchar(60) DEFAULT NULL,

	PRIMARY KEY (`model`)
);
