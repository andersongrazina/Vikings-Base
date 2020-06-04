USE `essentialmode`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_ballas', 'Ballas', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_ballas', 'Ballas', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_ballas', 'Ballas', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('ballas','Ballas')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('ballas',0,'recruit','Aviãozinho',20,'{}','{}'),
	('ballas',1,'soldado','Capanga',20,'{}','{}'),
	('ballas',2,'officer','Braço Direito',40,'{}','{}'),
	('ballas',3,'boss','Líder',100,'{}','{}')
;
