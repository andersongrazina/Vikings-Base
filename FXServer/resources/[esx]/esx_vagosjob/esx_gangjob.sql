USE `essentialmode`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_vagos', 'Los Vagos', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_vagos', 'Los Vagos', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_vagos', 'Los Vagos', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('vagos','Los Vagos')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('vagos',0,'recruit','Aviãozinho',20,'{}','{}'),
	('vagos',1,'soldado','Capanga',20,'{}','{}'),
	('vagos',2,'officer','Braço Direito',40,'{}','{}'),
	('vagos',3,'boss','Líder',100,'{}','{}')
;
