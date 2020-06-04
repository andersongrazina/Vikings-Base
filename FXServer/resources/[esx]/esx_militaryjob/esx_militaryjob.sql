USE `essentialmode`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_militar', 'Militar', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_militar', 'Militar', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_militar', 'Militar', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('militar','Militar')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('militar',0,'recruit','Recruta',20,'{}','{}'),
	('militar',1,'soldado','Soldado',20,'{}','{}'),
	('militar',2,'cabo','Cabo',20,'{}','{}'),
	('militar',3,'sargento','Sargento',20,'{}','{}'),
	('militar',4,'tenente','Tenente',20,'{}','{}'),
	('militar',5,'capitao','Capitão',40,'{}','{}'),
	('militar',6,'medico','Médico',40,'{}','{}'),
	('militar',7,'major','Major',60,'{}','{}'),
	('militar',8,'tencoronel','Ten. Coronel',85,'{}','{}'),
	('militar',9,'coronel','Coronel',85,'{}','{}'),
	('militar',10,'boss','General',100,'{}','{}')
;
