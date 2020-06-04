USE `essentialmode`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_realestateagent','Agente imobiliário',1)
;

INSERT INTO `jobs` (name, label) VALUES
	('realestateagent','Agente imobiliário')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('realestateagent',0,'location','Estagiário',10,'{}','{}'),
	('realestateagent',1,'vendeur','Vendedor',25,'{}','{}'),
	('realestateagent',2,'gestion','Gerente',40,'{}','{}'),
	('realestateagent',3,'boss','Patrão',0,'{}','{}')
;
