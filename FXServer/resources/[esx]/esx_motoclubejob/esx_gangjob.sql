USE `essentialmode`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_motoclube', 'The Lost M.C', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_motoclube', 'The Lost M.C', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_motoclube', 'The Lost M.C', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('motoclube','The Lost M.C')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('motoclube',0,'recruit','Aviãozinho',20,'{}','{}'),
	('motoclube',1,'soldado','Capanga',20,'{}','{}'),
	('motoclube',2,'officer','Braço Direito',40,'{}','{}'),
	('motoclube',3,'boss','Líder',100,'{}','{}')
;
