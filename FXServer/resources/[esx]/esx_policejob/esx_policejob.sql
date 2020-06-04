USE `essentialmode`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_police', 'PM Venus', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_police', 'PM Venus', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_police', 'PM Venus', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('police','PMV')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('police',0,'recruit','Recruta',20,'{}','{}'),
	('police',1,'soldado','Soldado',20,'{}','{}'),
	('police',2,'officer','Cabo',40,'{}','{}'),
	('police',3,'sergeant','Sargento',60,'{}','{}'),
	('police',4,'intendent', 'Tenente',85,'{}','{}'),
	('police',5,'lieutenant','Capitão',85,'{}','{}'),
	('police',6,'major','Major',85,'{}','{}'),
	('police',7,'tencoronel','Ten. Coronel',85,'{}','{}'),
	('police',8,'chef','Coronel',85,'{}','{}'),
	('police',9,'boss','Comandante',100,'{}','{}')
;

CREATE TABLE `fine_types` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`label` varchar(255) DEFAULT NULL,
	`amount` int(11) DEFAULT NULL,
	`category` int(11) DEFAULT NULL,

	PRIMARY KEY (`id`)
);

INSERT INTO `fine_types` (label, amount, category) VALUES
	('Uso Indevido da Buzina', 30, 0),
	('Cruzar a linha continua ilegalmente', 40, 0),
	('Dirigindo do lado errado da estrada', 250, 0),
	('Condução ilegal fora da pista', 170, 0),
	('Recusando uma ordem da lei', 30, 0),
	('Veículo parado ilegalmente', 150, 0),
	('Estacionamento Ilegal', 70, 0),
	('Falta de rendimento para direita', 70, 0),
	('Falta de cumprimento de informação do veículo', 90, 0),
	('Não parar em um sinal de parada', 105, 0),
	('Não parar em uma luz vermelho', 130, 0),
	('Ultrapassagem ilegal', 100, 0),
	('Dirigindo um veículo ilegal', 100, 0),
	('Dirigindo sem carteira', 1500, 0),
	('Bater e fugir', 800, 0),
	('Ultrapassando a velocidade de < 5 mph', 90, 0),
	('Ultrapassando a velocidade 5-15 mph', 120, 0),
	('Ultrapassando a velocidade 15-30 mph', 180, 0),
	('Ultrapassando a velocidade > 30 mph', 300, 0),
	('Impedir o fluxo de tráfego', 110, 1),
	('Intoxicação pública', 90, 1),
	('Conduta desordeira', 90, 1),
	('Obstrução de justiça', 130, 1),
	('Insulto contra civis', 75, 1),
	('Disrespeitando a Lei', 110, 1),
	('Ameaça verbal contra um civil', 90, 1),
	('Ameça verbal contra a lei', 150, 1),
	('Fornecer informações falsas', 250, 1),
	('Tentativa de corrupção', 1500, 1),
	('Manuseando uma arma nos limites da cidade', 120, 2),
	('Manuseando uma arma legal nos limites da cidade', 300, 2),
	('Sem licença para arma de fogo', 600, 2),
	('Posse de arma ilegal', 700, 2),
	('Posse de ferramentas de roubo', 300, 2),
	('Intenção de vender/distribuir substância ilegal', 1500, 2),
	('Fabricação de uma substância ilegal', 1500, 2),
	('Posse de uma substância ilegal ', 650, 2),
	('Sequestro de um civil', 1500, 2),
	('Sequestro de alguem da lei', 2000, 2),
	('Roubo', 650, 2),
	('Assalto a loja a mão armada', 650, 2),
	('Assalto a banco a mão armada', 1500, 2),
	('Assalto a um civil', 2000, 3),
	('Assalto a alguem da lei', 2500, 3),
	('Tentativa de assassinato a um civil', 3000, 3),
	('Tentativa de assassinato a alguem da lei', 5000, 3),
	('Assassinato a um civil', 10000, 3),
	('Assassinato a alguem da lei', 30000, 3),
	('Homicídio involuntário', 1800, 3),
	('Fraude', 2000, 2)
;
