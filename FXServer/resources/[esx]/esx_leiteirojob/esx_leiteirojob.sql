USE `essentialmode`;

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
('leiteiro', 'Leiteiro', 0);

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('leiteiro', 0, 'employed', 'Autônomo', 400, '{}', '{}');

INSERT INTO `items` (name, label) VALUES
  ('bucket','Balde'),
  ('milkpet','Garrafa de Leite'),
  ('milkbucket', 'Balde de Leite')
;
