USE `essentialmode`;

CREATE TABLE `chave_carros` (
	`owner` varchar(22) NOT NULL,
	`plate` varchar(12) NOT NULL,

	PRIMARY KEY (`plate`)
);

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES 
('chave', 'Chave do Carro', 5, 0, 1);