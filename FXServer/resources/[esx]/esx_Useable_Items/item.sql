INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
('umbrellablue', 'Guarda-Chuva Azul', 1, 0, 1),
('umbrellagrey', 'Guarda-Chuva Cinza', 1, 0, 1),
('handbag', 'Bolsa (Toalha)', 1, 0, 1),
('handbagtacticgrey', 'Bolsa Cinza', 1, 0, 1),
('handbagholiday', 'mala de viagem de tecido', 1, 0, 1),
('handbagholidayhard', 'mala de viagem resistente', 1, 0, 1)
;

INSERT INTO `shops` (`store`, `item`, `price`) VALUES 
('ExtraItemsShop', 'umbrellablue', 25), 
('ExtraItemsShop', 'umbrellagrey', 25), 
;