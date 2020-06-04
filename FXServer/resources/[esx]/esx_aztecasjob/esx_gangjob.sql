USE `essentialmode`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_aztecas', 'Los Aztecas', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_aztecas', 'Los Aztecas', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_aztecas', 'Los Aztecas', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('aztecas','Los Aztecas')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('aztecas',0,'recruit','Aviãozinho',20,'{}','{}'),
	('aztecas',1,'soldado','Capanga',20,'{}','{}'),
	('aztecas',2,'officer','Braço Direito',40,'{}','{}'),
	('aztecas',3,'boss','Líder',100,'{}','{}')
;
