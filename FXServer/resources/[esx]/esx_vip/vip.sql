USE `essentialmode`;

CREATE TABLE `vips` (
	`identifier` varchar(60) NOT NULL,
	`dinheirovip` int(11) DEFAULT NULL,

	PRIMARY KEY (`identifier`)
);

ALTER TABLE `users`
	ADD COLUMN `vip` INT(11) NOT NULL DEFAULT '0';


