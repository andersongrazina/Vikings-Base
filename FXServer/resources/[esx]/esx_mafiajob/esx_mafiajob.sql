USE `essentialmode`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_mafia', 'Mafia Italiana', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_mafia', 'Mafia Italiana', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_mafia', 'Mafia Italiana', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('mafia','Mafia Italiana')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('mafia',0,'recruit','Soldado',20,'{}','{}'),
	('mafia',1,'sociado','Padrinho',20,'{}','{}'),
	('mafia',2,'gerente','Braço Direito',20,'{}','{}'),
	('mafia',3,'chef','Sub-Chefe',85,'{}','{}'),
	('mafia',4,'boss','Chefe',100,'{}','{}')
;
