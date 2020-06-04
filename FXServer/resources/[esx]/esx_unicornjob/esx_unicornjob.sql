SET @job_name = 'unicorn';
SET @society_name = 'society_unicorn';
SET @job_Name_Caps = 'Unicorn';



INSERT INTO `addon_account` (name, label, shared) VALUES
  (@society_name, @job_Name_Caps, 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
  (@society_name, @job_Name_Caps, 1),
  ('society_unicorn_fridge', 'Unicorn (frigo)', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
    (@society_name, @job_Name_Caps, 1)
;

INSERT INTO `jobs` (name, label, whitelisted) VALUES
  (@job_name, @job_Name_Caps, 1)
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  (@job_name, 0, 'barman', 'Barman', 300, '{}', '{}'),
  (@job_name, 1, 'dancer', 'Dançarino', 300, '{}', '{}'),
  (@job_name, 2, 'viceboss', 'Gerente', 500, '{}', '{}'),
  (@job_name, 3, 'boss', 'Dono', 600, '{}', '{}')
;

INSERT INTO `items` (`name`, `label`, `limit`) VALUES  
    ('jager', 'Jägermeister', 5),
    ('vodka', 'Vodka', 5),
    ('rhum', 'Rhum', 5),
    ('whisky', 'Whisky', 5),
    ('tequila', 'Tequila', 5),
    ('martini', 'Martini', 5),
    ('soda', 'Soda', 5),
    ('jusfruit', 'Jus de frutas', 5),
    ('icetea', 'Chá Gelado', 5),
    ('energy', 'Bebida Energética', 5),
    ('drpepper', 'Jack Daniels', 5),
    ('limonade', 'Limonada', 5),
    ('bolcacahuetes', 'Tigela de amendoim', 5),
    ('bolnoixcajou', 'Tigela de Cajú', 5),
    ('bolpistache', 'Tigela de Pistache', 5),
    ('bolchips', 'Tigela de salgadinho', 5),
    ('saucisson', 'Saucisson', 5),
    ('grapperaisin', 'Vinho', 5),
    ('jagerbomb', 'Jägerbomb', 5),
    ('golem', 'Golem', 5),
    ('whiskycoca', 'Whisky-coca', 5),
    ('vodkaenergy', 'Vodka-enérgica', 5),
    ('vodkafruit', 'Vodka-jus de frutas', 5),
    ('rhumfruit', 'Rum-jus de frutas', 5),
    ('teqpaf', "Teq'paf", 5),
    ('rhumcoca', 'Rum-coca', 5),
    ('mojito', 'Mojito', 5),
    ('ice', 'Glaçon', 5),
    ('mixapero', 'Mix Apéritif', 3),
    ('metreshooter', 'Mètre de shooter', 3),
    ('jagercerbere', 'Jäger Cerbère', 3),
    ('menthe', 'Feuille de menthe', 10)
;
