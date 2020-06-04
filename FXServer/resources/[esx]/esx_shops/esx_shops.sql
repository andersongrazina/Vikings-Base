USE `essentialmode`;

CREATE TABLE `shops` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`store` varchar(100) NOT NULL,
	`item` varchar(100) NOT NULL,
	`price` int(11) NOT NULL,

	PRIMARY KEY (`id`)
);

INSERT INTO `items` (`name`, `label`, `limit`) VALUES  
    ('phone', 'Celular', 1)
;

INSERT INTO `shops` (`store`, `item`, `price`) VALUES
	('TwentyFourSeven', 'bread', 3),
	('TwentyFourSeven', 'burger', 5),
	('TwentyFourSeven', 'water', 2),
	('TwentyFourSeven', 'cola', 6),
	('TwentyFourSeven', 'leitep', 3),
	('TwentyFourSeven', 'leiteg', 8),
	('TwentyFourSeven', 'cerveja', 12),
	('TwentyFourSeven', 'phone', 550),
	('RobsLiquor', 'bread', 4),
	('RobsLiquor', 'burger', 8),
	('RobsLiquor', 'water', 3),
	('RobsLiquor', 'cola', 8),
	('RobsLiquor', 'leitep', 4),
	('RobsLiquor', 'leiteg', 9),
	('RobsLiquor', 'cerveja', 15),
	('RobsLiquor', 'phone', 650),
	('LTDgasoline', 'bread', 8),
	('LTDgasoline', 'burger', 12),
	('LTDgasoline', 'water', 5),
	('LTDgasoline', 'cola', 10),
	('LTDgasoline', 'leitep', 5),
	('LTDgasoline', 'leiteg', 10),
	('LTDgasoline', 'cerveja', 20),
	('LTDgasoline', 'phone', 750)
;
