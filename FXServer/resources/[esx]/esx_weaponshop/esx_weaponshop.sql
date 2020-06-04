USE `essentialmode`;

CREATE TABLE `weashops` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`zone` varchar(255) NOT NULL,
	`item` varchar(255) NOT NULL,
	`price` int(11) NOT NULL,

	PRIMARY KEY (`id`)
);

INSERT INTO `licenses` (`type`, `label`) VALUES
	('weapon', "Permissão para porte de armas")
;

INSERT INTO `weashops` (`zone`, `item`, `price`) VALUES
	('GunShop','WEAPON_BAT', 850),
	('GunShop','WEAPON_GOLFCLUB', 850),
	('GunShop','WEAPON_HATCHET', 850),
	('GunShop','WEAPON_KNIFE', 1000),
	('GunShop','WEAPON_FLASHLIGHT', 650),
	('GunShop','WEAPON_KNUCKLE', 500),
	('GunShop','WEAPON_PISTOL', 12500),
	('GunShop','WEAPON_MICROSMG', 15000),
	('GunShop','WEAPON_SMG', 22500),
	('GunShop','WEAPON_SHOTGUN', 22000),
	
;
