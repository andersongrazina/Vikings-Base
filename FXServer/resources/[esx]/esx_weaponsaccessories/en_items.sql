USE `essentialmode`;

INSERT INTO `items` (name, label, `limit`, rare, can_remove) VALUES
  ('silent','Silenciador',-1, 0, 1),
  ('flashlight','Lanterna',-1, 0, 1),
  ('grip','Empunhadora',-1, 0, 1),
  ('extended_magazine','Carregador Extendido',-1, 0, 1),
  ('scope','Mira',-1, 0, 1),
  ('compansator','Compensador',-1, 0, 1)
;

INSERT INTO `shops` (store, item, price) VALUES
	('ExtraItemsShop', 'silent', 6500),
	('ExtraItemsShop', 'flashlight', 6500),
	('ExtraItemsShop', 'grip', 6500),
	('ExtraItemsShop', 'scope', 6500),
	('ExtraItemsShop', 'compansator', 6500)
;
