CREATE TABLE IF NOT EXISTS `secteur` (
        `idsecteur` INTEGER AUTO_INCREMENT, 
        `libellesecteur` varchar(100) NOT NULL,
        PRIMARY KEY(idsecteur));
 
INSERT INTO `secteur` (`idsecteur`, `libellesecteur`) VALUES
	('', 'Aix'),
	('', 'Batz'),
	('', 'Belle-Ile-en-Mer'),
	('', 'Bréhat'),
	('', 'Houat'),
	('', 'Ile de Groix'),
	('', 'Molène'),
	('', 'Ouessant'),
	('', 'Sein'),
	('', 'Yeu');

CREATE TABLE IF NOT EXISTS `liaison`(
    `idliaison` INTEGER NOT NULL, 
    `distmiles` INTEGER NOT NULL,
	`portdepart` varchar(100) NOT NULL,
	`portarrivee` varchar(100) NOT NULL,
	`idsecteur` INTEGER NOT NULL,
	FOREIGN KEY(idsecteur) REFERENCES secteur(idsecteur),
    PRIMARY KEY(idliaison));
		
INSERT INTO `liaison` (`idliaison`, `distmiles`, `portdepart`, `portarriver`, `idsecteur`) VALUES
	('15', '8.3', 'Quiberon', 'le Palais', SELECT idsecteur FROM secteur WHERE libellesecteur = 'Belle-Ile-en-Mer'),
	('24', '9', 'Le Palais', 'Quiberon', SELECT idsecteur FROM secteur WHERE libellesecteur = 'Belle-Ile-en-Mer'),
	('16', '8', 'Quiberon', 'Sauzon', SELECT idsecteur FROM secteur WHERE libellesecteur = 'Belle-Ile-en-Mer'),
	('17', '7.9', 'Sauzon', 'Quiberon', SELECT idsecteur FROM secteur WHERE libellesecteur = 'Belle-Ile-en-Mer'),
	('19', '23.7', 'Vannes', 'Le Palais', SELECT idsecteur FROM secteur WHERE libellesecteur = 'Belle-Ile-en-Mer'),
	('11', '25.1', 'Le Palais', 'Vannes', SELECT idsecteur FROM secteur WHERE libellesecteur = 'Belle-Ile-en-Mer'),
	('25', '8.8', 'Quiberon', 'Port St Gildas', SELECT idsecteur FROM secteur WHERE libellesecteur = 'Houat'),
	('30', '8.8', 'Port St Gildas', 'Quiberon', SELECT idsecteur FROM secteur WHERE libellesecteur = 'Houat'),
	('21', '7.7', 'Lorient', 'Port-Tudy', SELECT idsecteur FROM secteur WHERE libellesecteur = 'Ile de Groix'),
	('22', '7.4', 'Port-Tudy', 'Lorient', SELECT idsecteur FROM secteur WHERE libellesecteur = 'Ile de Groix');
	

CREATE TABLE IF NOT EXISTS `bateau`(		
	`nombateau` varchar(100) NOT NULL,
	`longueurbateau` INTEGER NOT NULL,
	`largeurbateau` INTEGER NOT NULL,
	PRIMARY KEY(nombateau));

CREATE TABLE IF NOT EXISTS `bateautransport`(
	`vitessebateau` INTEGER NOT NULL) INHERITS (bateau);
	
INSERT INTO `bateautransport` (`nombateau`, `longueurbateau`, `largeurbateau`, `vitessebateau`) VALUES
	('Luce isle', '37.20', '8.60', '26'),
	('Al\' xi', '25', '7', '16'),
	('Kor\' Ant', '30', '8', '20'),
	('Ar Solen', '35', '9', '18');
	
CREATE TABLE IF NOT EXISTS `bateaufret`(
		`poidsmax` INTEGER NOT NULL) INHERITS (bateau);

CREATE TABLE IF NOT EXISTS `traversee`(
    `idtraversee` INTEGER AUTO_INCREMENT, 
    `heuretraversee` DATE NOT NULL,
	`datetraversee` DATE NOT NULL,
	`idliaison` INTEGER NOT NULL,
	`nombateau` varchar(100) NOT NULL,
	FOREIGN KEY(idliaison) REFERENCES liaison(idliaison),
	FOREIGN KEY(nombateau) REFERENCES bateau(nombateau),
    PRIMARY KEY(idtraversee));

INSERT INTO `traversee`(`idtraversee`, `heuretraversee`, `datetraversee`, `idliaison`, `nombateau`) VALUES
	('', '05h00', '2015-11-13', '15', 'Luce isle'),
	('', '06h00', '2015-11-13', '24', 'Kor'' Ant'),
	('', '07h00', '2015-11-13', '16', 'Al'' xi'),
	('', '08h00', '2015-11-13', '17', 'Kor'' Ant'),
	('', '09h00', '2015-11-13', '19', 'Luce isle'),
	('', '10h00', '2015-11-13', '11', 'Kor'' Ant'),
	('', '11h00', '2015-11-13', '25', 'Ar Solen'),
	('', '12h00', '2015-11-13', '30', 'Al'' xi'),
	('', '13h00', '2015-11-13', '21', 'Kor'' Ant'),
	('', '14h00', '2015-11-13', '22', 'Luce isle'),
	('', '15h00', '2015-11-13', '15', 'Ar Solen'),
	('', '16h00', '2015-11-13', '15', 'Kor'' Ant'),
	('', '17h00', '2015-11-13', '15', 'Al'' xi'),
	('', '18h00', '2015-11-13', '15', 'Ar Solen'),
	('', '19h00', '2015-11-13', '15', 'Luce isle');
	
	
CREATE TABLE IF NOT EXISTS `categorie`(
	`codecategorie` varchar(100) NOT NULL,
	`libellecategorie` varchar(100) NOT NULL,
	PRIMARY KEY(codecategorie));

INSERT INTO `categorie` (`codecategorie`, `libellecategorie`) VALUES
	('A', 'Passager'),
	('B', 'Véhicule inférieur à 5 mètres'),
	('C', 'Véhicule supérieur à 5 mètres');

CREATE TABLE IF NOT EXISTS `typee`(
	`codetype` varchar(100) NOT NULL,
	`libelletype` varchar(100) NOT NULL,
	PRIMARY KEY(codetype));

INSERT INTO `typee` (`codetype`, `libelletype`) VALUES
	('A1', 'Adulte'),
	('A2', 'Junior de 8 à 18 ans'),
	('A3', 'Enfant de 0 à 7 ans'),
	('B1', 'Voiture inférieur à 4 mètres'),
	('B2', 'Voiure inférieur à 5 mètres'),
	('C1', 'Fourgon'),
	('C2', 'Camping Car'),
	('C3', 'Camion');
	
CREATE TABLE IF NOT EXISTS `periode`(
	`idperiode` INTEGER AUTO_INCREMENT, 
	`datedebut` date NOT NULL,
	`datefin` date NOT NULL,
	PRIMARY KEY(idperiode));

INSERT INTO `periode` (`idperiode`, `datedebut`, `datefin`) VALUES
	('', '2014-09-01', '2015-06-15'),
	('', '2015-06-16', '2015-09-15'),
	('', '2015-09-16', '2016-05-31');

CREATE TABLE IF NOT EXISTS `tarif`(
	`idperiode` INTEGER NOT NULL, 
	`idliaison` INTEGER NOT NULL, 
	`codetype` varchar(100) NOT NULL,
	`prix` INTEGER NOT NULL, 
	FOREIGN KEY(idperiode) REFERENCES periode(idperiode),
	FOREIGN KEY(idliaison) REFERENCES liaison(idliaison),
	FOREIGN KEY(codetype) REFERENCES typee(codetype),
	UNIQUE(idperiode),
	UNIQUE(idliaison),
	UNIQUE(codetype));
	
INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`) VALUES
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '15', 'A1', '18'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '15', 'A1', '20'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '15', 'A1', '19'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '15', 'A2', '11.1'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '15', 'A2', '13.10'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '15', 'A2', '12.10'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '15', 'A3', '5.60'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '15', 'A3', '7'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '15', 'A3', '6.40'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '15', 'B1', '86'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '15', 'B1', '95'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '15', 'B1', '91'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '15', 'B2', '129'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '15', 'B2', '142'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '15', 'B2', '136'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '15', 'C1', '189'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '15', 'C1', '208'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '15', 'C1', '199'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '15', 'C2', '205'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '15', 'C2', '226'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '15', 'C2', '216'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '15', 'C3', '268'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '15', 'C3', '295'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '15', 'C3', '282'),

	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '16', 'A1', '18'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '16', 'A1', '20'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '16', 'A1', '19'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '16', 'A2', '11.1'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '16', 'A2', '13.10'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '16', 'A2', '12.10'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '16', 'A3', '5.60'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '16', 'A3', '7'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '16', 'A3', '6.40'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '16', 'B1', '86'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '16', 'B1', '95'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '16', 'B1', '91'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '16', 'B2', '129'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '16', 'B2', '142'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '16', 'B2', '136'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '16', 'C1', '189'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '16', 'C1', '208'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '16', 'C1', '199'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '16', 'C2', '205'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '16', 'C2', '226'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '16', 'C2', '216'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '16', 'C3', '268'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '16', 'C3', '295'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '16', 'C3', '282'),

	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '17', 'A1', '18'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '17', 'A1', '20'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '17', 'A1', '19'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '17', 'A2', '11.1'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '17', 'A2', '13.10'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '17', 'A2', '12.10'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '17', 'A3', '5.60'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '17', 'A3', '7'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '17', 'A3', '6.40'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '17', 'B1', '86'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '17', 'B1', '95'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '17', 'B1', '91'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '17', 'B2', '129'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '17', 'B2', '142'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '17', 'B2', '136'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '17', 'C1', '189'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '17', 'C1', '208'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '17', 'C1', '199'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '17', 'C2', '205'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '17', 'C2', '226'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '17', 'C2', '216'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '17', 'C3', '268'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '17', 'C3', '295'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '17', 'C3', '282'),

	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '19', 'A1', '18'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '19', 'A1', '20'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '19', 'A1', '19'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '19', 'A2', '11.1'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '19', 'A2', '13.10'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '19', 'A2', '12.10'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '19', 'A3', '5.60'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '19', 'A3', '7'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '19', 'A3', '6.40'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '19', 'B1', '86'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '19', 'B1', '95'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '19', 'B1', '91'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '19', 'B2', '129'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '19', 'B2', '142'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '19', 'B2', '136'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '19', 'C1', '189'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '19', 'C1', '208'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '19', 'C1', '199'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '19', 'C2', '205'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '19', 'C2', '226'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '19', 'C2', '216'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '19', 'C3', '268'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '19', 'C3', '295'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '19', 'C3', '282'),

	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '21', 'A1', '18'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '21', 'A1', '20'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '21', 'A1', '19'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '21', 'A2', '11.1'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '21', 'A2', '13.10'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '21', 'A2', '12.10'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '21', 'A3', '5.60'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '21', 'A3', '7'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '21', 'A3', '6.40'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '21', 'B1', '86'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '21', 'B1', '95'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '21', 'B1', '91'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '21', 'B2', '129'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '21', 'B2', '142'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '21', 'B2', '136'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '21', 'C1', '189'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '21', 'C1', '208'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '21', 'C1', '199'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '21', 'C2', '205'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '21', 'C2', '226'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '21', 'C2', '216'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '21', 'C3', '268'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '21', 'C3', '295'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '21', 'C3', '282'),

	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '22', 'A1', '18'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '22', 'A1', '20'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '22', 'A1', '19'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '22', 'A2', '11.1'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '22', 'A2', '13.10'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '22', 'A2', '12.10'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '22', 'A3', '5.60'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '22', 'A3', '7'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '22', 'A3', '6.40'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '22', 'B1', '86'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '22', 'B1', '95'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '22', 'B1', '91'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '22', 'B2', '129'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '22', 'B2', '142'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '22', 'B2', '136'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '22', 'C1', '189'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '22', 'C1', '208'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '22', 'C1', '199'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '22', 'C2', '205'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '22', 'C2', '226'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '22', 'C2', '216'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '22', 'C3', '268'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '22', 'C3', '295'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '22', 'C3', '282'),

	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '24', 'A1', '18'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '24', 'A1', '20'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '24', 'A1', '19'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '24', 'A2', '11.1'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '24', 'A2', '13.10'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '24', 'A2', '12.10'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '24', 'A3', '5.60'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '24', 'A3', '7'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '24', 'A3', '6.40'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '24', 'B1', '86'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '24', 'B1', '95'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '24', 'B1', '91'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '24', 'B2', '129'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '24', 'B2', '142'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '24', 'B2', '136'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '24', 'C1', '189'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '24', 'C1', '208'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '24', 'C1', '199'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '24', 'C2', '205'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '24', 'C2', '226'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '24', 'C2', '216'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '24', 'C3', '268'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '24', 'C3', '295'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '24', 'C3', '282'),

	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '11', 'A1', '18'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '11', 'A1', '20'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '11', 'A1', '19'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '11', 'A2', '11.1'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '11', 'A2', '13.10'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '11', 'A2', '12.10'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '11', 'A3', '5.60'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '11', 'A3', '7'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '11', 'A3', '6.40'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '11', 'B1', '86'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '11', 'B1', '95'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '11', 'B1', '91'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '11', 'B2', '129'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '11', 'B2', '142'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '11', 'B2', '136'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '11', 'C1', '189'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '11', 'C1', '208'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '11', 'C1', '199'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '11', 'C2', '205'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '11', 'C2', '226'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '11', 'C2', '216'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '11', 'C3', '268'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '11', 'C3', '295'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '11', 'C3', '282'),

	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '30', 'A1', '18'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '30', 'A1', '20'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '30', 'A1', '19'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '30', 'A2', '11.1'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '30', 'A2', '13.10'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '30', 'A2', '12.10'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '30', 'A3', '5.60'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '30', 'A3', '7'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '30', 'A3', '6.40'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '30', 'B1', '86'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '30', 'B1', '95'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '30', 'B1', '91'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '30', 'B2', '129'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '30', 'B2', '142'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '30', 'B2', '136'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '30', 'C1', '189'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '30', 'C1', '208'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '30', 'C1', '199'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '30', 'C2', '205'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '30', 'C2', '226'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '30', 'C2', '216'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '30', 'C3', '268'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '30', 'C3', '295'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '30', 'C3', '282'),

	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '25', 'A1', '18'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '25', 'A1', '20'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '25', 'A1', '19'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '25', 'A2', '11.1'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '25', 'A2', '13.10'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '25', 'A2', '12.10'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '25', 'A3', '5.60'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '25', 'A3', '7'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '25', 'A3', '6.40'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '25', 'B1', '86'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '25', 'B1', '95'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '25', 'B1', '91'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '25', 'B2', '129'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '25', 'B2', '142'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '25', 'B2', '136'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '25', 'C1', '189'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '25', 'C1', '208'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '25', 'C1', '199'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '25', 'C2', '205'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '25', 'C2', '226'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '25', 'C2', '216'),
	
	(SELECT idperiode FROM periode WHERE datedebut = '2014-09-01' , '25', 'C3', '268'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-06-16' , '25', 'C3', '295'),
	(SELECT idperiode FROM periode WHERE datedebut = '2015-09-16' , '25', 'C3', '282'),
	




