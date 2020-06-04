USE `essentialmode`;

CREATE TABLE `truck_categories` (
	`name` varchar(60) NOT NULL,
	`label` varchar(60) NOT NULL,

	PRIMARY KEY (`name`)
);

INSERT INTO `truck_categories` (name, label) VALUES
	('haul','Caminhões')
;

CREATE TABLE `trucks` (
	`name` varchar(60) NOT NULL,
	`model` varchar(60) NOT NULL,
	`price` int(11) NOT NULL,
	`category` varchar(60) DEFAULT NULL,
	PRIMARY KEY (`model`)
);

INSERT INTO `trucks` (name, model, price, category) VALUES
	('Scania R730', 'hauler', 220000, 'haul'),
	('Actros', 'actros', 255000, 'haul'),
	('Volvo FH', 'volvofh', 275000, 'haul'),
	('Phantom Custom', 'phantom3', 300000, 'haul'),
	('Constellation', 'vkconst', 310000, 'haul')
;
