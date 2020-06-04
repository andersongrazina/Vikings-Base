USE `essentialmode`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_groove', 'Groove S.F', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_groove', 'Groove S.F', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_groove', 'Groove S.F', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('groove','Groove S.F')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('groove',0,'recruit','Aviãozinho',20,'{}','{}'),
	('groove',1,'soldado','Capanga',20,'{}','{}'),
	('groove',2,'officer','Braço Direito',40,'{}','{}'),
	('groove',3,'boss','Líder',100,'{}','{}')
;
