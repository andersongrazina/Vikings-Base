INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
('brinks', 'Brinks', 0);

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('brinks', 0, 'interim', 'Transportador de Valores', 1200, '{}', '{}');

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
('sacbillets', 'Saco de Dinheiro', 100, 0, 1);