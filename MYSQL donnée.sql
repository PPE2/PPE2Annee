﻿
CREATE DATABASE IF NOT EXISTS MarieTeam DEFAULT CHARACTER SET latin1 COLLATE latin1_general_ci;

USE `MarieTeam`;


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
		
INSERT INTO `liaison` (`idliaison`, `distmiles`, `portdepart`, `portarrivee`, `idsecteur`) VALUES
	('15', '8.3', 'Quiberon', 'le Palais', 'SELECT idsecteur FROM secteur WHERE libellesecteur = "Belle-Ile-en-Mer"'),
	('24', '9', 'Le Palais', 'Quiberon', 'SELECT idsecteur FROM secteur WHERE libellesecteur = "Belle-Ile-en-Mer"'),
	('16', '8', 'Quiberon', 'Sauzon', 'SELECT idsecteur FROM secteur WHERE libellesecteur = "Belle-Ile-en-Mer"'),
	('17', '7.9', 'Sauzon', 'Quiberon', 'SELECT idsecteur FROM secteur WHERE libellesecteur = "Belle-Ile-en-Mer"'),
	('19', '23.7', 'Vannes', 'Le Palais', 'SELECT idsecteur FROM secteur WHERE libellesecteur = "Belle-Ile-en-Mer"'),
	('11', '25.1', 'Le Palais', 'Vannes', 'SELECT idsecteur FROM secteur WHERE libellesecteur = "Belle-Ile-en-Mer"'),
	('25', '8.8', 'Quiberon', 'Port St Gildas', 'SELECT idsecteur FROM secteur WHERE libellesecteur = "Houat"'),
	('30', '8.8', 'Port St Gildas', 'Quiberon', 'SELECT idsecteur FROM secteur WHERE libellesecteur = "Houat"'),
	('21', '7.7', 'Lorient', 'Port-Tudy', 'SELECT idsecteur FROM secteur WHERE libellesecteur = "Ile de Groix"'),
	('22', '7.4', 'Port-Tudy', 'Lorient', 'SELECT idsecteur FROM secteur WHERE libellesecteur = "Ile de Groix"');
	

CREATE TABLE IF NOT EXISTS `bateau`(		
	`nombateau` varchar(100) NOT NULL,
	PRIMARY KEY(nombateau));
    
INSERT INTO `bateau` (`nombateau`) VALUES
	('Luce isle'),
	('Al xi'),
	('Kor Ant'),
	('Ar Solen');

CREATE TABLE IF NOT EXISTS `bateautransport`(
    `nombateau` varchar(100) NOT NULL,
    `longueurbateau` DECIMAL NOT NULL,
    `largeurbateau` DECIMAL NOT NULL,
    `vitessebateau` INTEGER NOT NULL,
    FOREIGN KEY(nombateau) REFERENCES bateau(nombateau),
    PRIMARY KEY(nombateau));
	
INSERT INTO `bateautransport` (`nombateau`, `longueurbateau`, `largeurbateau`, `vitessebateau`) VALUES
	('Luce isle', '37.20', '8.60', '26'),
	('Al xi', '25', '7', '16'),
	('Kor Ant', '30', '8', '20'),
	('Ar Solen', '35', '9', '18');
	
CREATE TABLE IF NOT EXISTS `bateaufret`(
    `nombateau` varchar(100) NOT NULL,
	`poidsmax` INTEGER NOT NULL,
    FOREIGN KEY(nombateau) REFERENCES bateau(nombateau),
    PRIMARY KEY(nombateau));
	

CREATE TABLE IF NOT EXISTS `traversee`(
    `idtraversee` INTEGER AUTO_INCREMENT, 
    `heuretraversee` TIME NOT NULL,
	`datetraversee` DATE NOT NULL,
	`idliaison` INTEGER NOT NULL,
	`nombateau` varchar(100) NOT NULL,
	FOREIGN KEY(idliaison) REFERENCES liaison(idliaison),
	FOREIGN KEY(nombateau) REFERENCES bateau(nombateau),
    PRIMARY KEY(idtraversee));

INSERT INTO `traversee`(`idtraversee`, `heuretraversee`, `datetraversee`, `idliaison`, `nombateau`) VALUES
	('', '05:00', '2015-11-13', '15', 'Luce isle'),
	('', '06:00', '2015-11-13', '24', 'Kor Ant'),
	('', '07:00', '2015-11-13', '16', 'Al xi'),
	('', '08:00', '2015-11-13', '17', 'Kor Ant'),
	('', '09:00', '2015-11-13', '19', 'Luce isle'),
	('', '10:00', '2015-11-13', '11', 'Kor Ant'),
	('', '11:00', '2015-11-13', '25', 'Ar Solen'),
	('', '12:00', '2015-11-13', '30', 'Al xi'),
	('', '13:00', '2015-11-13', '21', 'Kor Ant'),
	('', '14:00', '2015-11-13', '22', 'Luce isle'),
	('', '15:00', '2015-11-13', '15', 'Ar Solen'),
	('', '16:00', '2015-11-13', '15', 'Kor Ant'),
	('', '17:00', '2015-11-13', '15', 'Al xi'),
	('', '18:00', '2015-11-13', '15', 'Ar Solen'),
	('', '19:00', '2015-11-13', '15', 'Luce isle');
	
	
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
	`prix` DECIMAL NOT NULL, 
	FOREIGN KEY(idperiode) REFERENCES periode(idperiode),
	FOREIGN KEY(idliaison) REFERENCES liaison(idliaison),
	FOREIGN KEY(codetype) REFERENCES typee(codetype),
    PRIMARY KEY(idperiode, idliaison, codetype));
	
INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '15', 'A1', '18' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '15', 'A1', '20' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '15', 'A1', '19' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '15', 'A2', '11.1' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '15', 'A2', '13.10' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '15', 'A2', '12.10' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '15', 'A3', '5.60' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '15', 'A3', '7' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '15', 'A3', '6.40' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '15', 'B1', '86' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '15', 'B1', '95' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '15', 'B1', '91' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '15', 'B2', '129' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '15', 'B2', '142' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '15', 'B2', '136' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '15', 'C1', '189' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '15', 'C1', '208' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '15', 'C1', '199' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '15', 'C2', '205' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '15', 'C2', '226' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '15', 'C2', '216' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '15', 'C3', '268' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '15', 'C3', '295' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '15', 'C3', '282' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)

	(SELECT idperiode , '16', 'A1', '18' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '16', 'A1', '20' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '16', 'A1', '19' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '16', 'A2', '11.1' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '16', 'A2', '13.10' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '16', 'A2', '12.10' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '16', 'A3', '5.60' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '16', 'A3', '7' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '16', 'A3', '6.40' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '16', 'B1', '86' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '16', 'B1', '95' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '16', 'B1', '91' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '16', 'B2', '129' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '16', 'B2', '142' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '16', 'B2', '136' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '16', 'C1', '189' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '16', 'C1', '208' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '16', 'C1', '199' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '16', 'C2', '205' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '16', 'C2', '226' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '16', 'C2', '216' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '16', 'C3', '268' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '16', 'C3', '295' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '16', 'C3', '282' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)

	(SELECT idperiode , '17', 'A1', '18' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '17', 'A1', '20' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '17', 'A1', '19' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '17', 'A2', '11.1' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '17', 'A2', '13.10' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '17', 'A2', '12.10' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '17', 'A3', '5.60' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '17', 'A3', '7' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '17', 'A3', '6.40' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '17', 'B1', '86' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '17', 'B1', '95' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '17', 'B1', '91' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '17', 'B2', '129' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '17', 'B2', '142' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '17', 'B2', '136' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '17', 'C1', '189' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '17', 'C1', '208' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '17', 'C1', '199' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '17', 'C2', '205' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '17', 'C2', '226' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '17', 'C2', '216' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '17', 'C3', '268' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '17', 'C3', '295' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '17', 'C3', '282' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)

	(SELECT idperiode , '19', 'A1', '18' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '19', 'A1', '20' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '19', 'A1', '19' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '19', 'A2', '11.1' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '19', 'A2', '13.10' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '19', 'A2', '12.10' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '19', 'A3', '5.60' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '19', 'A3', '7' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '19', 'A3', '6.40' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '19', 'B1', '86' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '19', 'B1', '95' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '19', 'B1', '91' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '19', 'B2', '129' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '19', 'B2', '142' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '19', 'B2', '136' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '19', 'C1', '189' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '19', 'C1', '208' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '19', 'C1', '199' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '19', 'C2', '205' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '19', 'C2', '226' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '19', 'C2', '216' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '19', 'C3', '268' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '19', 'C3', '295' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '19', 'C3', '282' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)

	(SELECT idperiode , '21', 'A1', '18' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '21', 'A1', '20' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '21', 'A1', '19' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '21', 'A2', '11.1' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '21', 'A2', '13.10' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '21', 'A2', '12.10' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '21', 'A3', '5.60' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '21', 'A3', '7' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '21', 'A3', '6.40' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '21', 'B1', '86' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '21', 'B1', '95' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '21', 'B1', '91' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '21', 'B2', '129' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '21', 'B2', '142' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '21', 'B2', '136' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '21', 'C1', '189' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '21', 'C1', '208' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '21', 'C1', '199' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '21', 'C2', '205' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '21', 'C2', '226' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '21', 'C2', '216' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '21', 'C3', '268' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '21', 'C3', '295' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '21', 'C3', '282' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)

	(SELECT idperiode , '22', 'A1', '18' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '22', 'A1', '20' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '22', 'A1', '19' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '22', 'A2', '11.1' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '22', 'A2', '13.10' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '22', 'A2', '12.10' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '22', 'A3', '5.60' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '22', 'A3', '7' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '22', 'A3', '6.40' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '22', 'B1', '86' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '22', 'B1', '95' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '22', 'B1', '91' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '22', 'B2', '129' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '22', 'B2', '142' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '22', 'B2', '136' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '22', 'C1', '189' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '22', 'C1', '208' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '22', 'C1', '199' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '22', 'C2', '205' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '22', 'C2', '226' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '22', 'C2', '216' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '22', 'C3', '268' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '22', 'C3', '295' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '22', 'C3', '282' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)

	(SELECT idperiode , '24', 'A1', '18' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '24', 'A1', '20' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '24', 'A1', '19' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '24', 'A2', '11.1' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '24', 'A2', '13.10' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '24', 'A2', '12.10' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '24', 'A3', '5.60' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '24', 'A3', '7' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '24', 'A3', '6.40' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '24', 'B1', '86' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '24', 'B1', '95' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '24', 'B1', '91' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '24', 'B2', '129' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '24', 'B2', '142' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '24', 'B2', '136' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '24', 'C1', '189' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '24', 'C1', '208' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '24', 'C1', '199' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '24', 'C2', '205' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '24', 'C2', '226' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '24', 'C2', '216' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '24', 'C3', '268' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '24', 'C3', '295' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '24', 'C3', '282' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)

	(SELECT idperiode , '11', 'A1', '18' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '11', 'A1', '20' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '11', 'A1', '19' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '11', 'A2', '11.1' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '11', 'A2', '13.10' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '11', 'A2', '12.10' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '11', 'A3', '5.60' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '11', 'A3', '7' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '11', 'A3', '6.40' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '11', 'B1', '86' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '11', 'B1', '95' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '11', 'B1', '91' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '11', 'B2', '129' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '11', 'B2', '142' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '11', 'B2', '136' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '11', 'C1', '189' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '11', 'C1', '208' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '11', 'C1', '199' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '11', 'C2', '205' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '11', 'C2', '226' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '11', 'C2', '216' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '11', 'C3', '268' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '11', 'C3', '295' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '11', 'C3', '282' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)

	(SELECT idperiode , '30', 'A1', '18' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '30', 'A1', '20' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '30', 'A1', '19' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '30', 'A2', '11.1' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '30', 'A2', '13.10' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '30', 'A2', '12.10' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '30', 'A3', '5.60' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '30', 'A3', '7' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '30', 'A3', '6.40' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '30', 'B1', '86' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '30', 'B1', '95' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '30', 'B1', '91' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '30', 'B2', '129' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '30', 'B2', '142' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '30', 'B2', '136' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '30', 'C1', '189' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '30', 'C1', '208' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '30', 'C1', '199' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '30', 'C2', '205' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '30', 'C2', '226' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '30', 'C2', '216' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '30', 'C3', '268' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '30', 'C3', '295' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '30', 'C3', '282' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)

	(SELECT idperiode , '25', 'A1', '18' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '25', 'A1', '20' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '25', 'A1', '19' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '25', 'A2', '11.1' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '25', 'A2', '13.10' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '25', 'A2', '12.10' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '25', 'A3', '5.60' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '25', 'A3', '7' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '25', 'A3', '6.40' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '25', 'B1', '86' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '25', 'B1', '95' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '25', 'B1', '91' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '25', 'B2', '129' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '25', 'B2', '142' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '25', 'B2', '136' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '25', 'C1', '189' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '25', 'C1', '208' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '25', 'C1', '199' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '25', 'C2', '205' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '25', 'C2', '226' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '25', 'C2', '216' FROM periode WHERE datedebut = "2015-09-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	
	(SELECT idperiode , '25', 'C3', '268' FROM periode WHERE datedebut = "2014-09-01");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '25', 'C3', '295' FROM periode WHERE datedebut = "2015-06-16");
	INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`)
	(SELECT idperiode , '25', 'C3', '282' FROM periode WHERE datedebut = "2015-09-16");