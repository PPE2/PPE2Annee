-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Client :  localhost
-- Généré le :  Lun 07 Décembre 2015 à 15:43
-- Version du serveur :  5.6.20-log
-- Version de PHP :  5.4.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

CREATE DATABASE MarieTeam DEFAULT CHARACTER SET latin1 COLLATE latin1_general_ci;
USE `MarieTeam`;
--
-- Base de données :  `marieteam`
--
CREATE DATABASE MarieTeam
USE MarieTeam
-- --------------------------------------------------------

--
-- Structure de la table `bateau`
--

CREATE TABLE IF NOT EXISTS `bateau` (
  `nombateau` varchar(100) NOT NULL,
  `longueurbateau` int(10) unsigned NOT NULL,
  `largeurbateau` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `bateau`
--

INSERT INTO `bateau` (`nombateau`, `longueurbateau`, `largeurbateau`) VALUES
('Luce isle', 0, 0),
('Al xi', 0, 0),
('Kor Ant', 0, 0),
('Ar Solen', 0, 0);

-- --------------------------------------------------------

--
-- Structure de la table `bateaufret`
--

CREATE TABLE IF NOT EXISTS `bateaufret` (
  `nombateau` varchar(100) NOT NULL,
  `poidsmax` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `bateautransport`
--

CREATE TABLE IF NOT EXISTS `bateautransport` (
  `nombateau` varchar(100) NOT NULL,
  `longueurbateau` decimal(10,0) NOT NULL,
  `largeurbateau` decimal(10,0) NOT NULL,
  `vitessebateau` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `bateautransport`
--

INSERT INTO `bateautransport` (`nombateau`, `longueurbateau`, `largeurbateau`, `vitessebateau`) VALUES
('Luce isle', '37', '9', 26),
('Al xi', '25', '7', 16),
('Kor Ant', '30', '8', 20),
('Ar Solen', '35', '9', 18);

-- --------------------------------------------------------

--
-- Structure de la table `categorie`
--

CREATE TABLE IF NOT EXISTS `categorie` (
  `codecategorie` varchar(100) NOT NULL,
  `libellecategorie` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `categorie`
--

INSERT INTO `categorie` (`codecategorie`, `libellecategorie`) VALUES
('A', 'Passager'),
('B', 'Véhicule inférieur à 5 mètres'),
('C', 'Véhicule supérieur à 5 mètres');

-- --------------------------------------------------------

--
-- Structure de la table `liaison`
--

CREATE TABLE IF NOT EXISTS `liaison` (
`idliaison` int(10) unsigned NOT NULL,
  `distmiles` int(10) unsigned NOT NULL,
  `portdepart` varchar(100) NOT NULL,
  `portarrivee` varchar(100) NOT NULL,
  `idsecteur` int(10) unsigned NOT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=31 ;

--
-- Contenu de la table `liaison`
--

INSERT INTO `liaison` (`idliaison`, `distmiles`, `portdepart`, `portarrivee`, `idsecteur`) VALUES
(15, 8, 'Quiberon', 'le Palais', 1),
(24, 9, 'Le Palais', 'Quiberon', 2),
(16, 8, 'Quiberon', 'Sauzon', 3),
(17, 8, 'Sauzon', 'Quiberon', 4),
(19, 24, 'Vannes', 'Le Palais', 5),
(11, 25, 'Le Palais', 'Vannes', 6),
(25, 9, 'Quiberon', 'Port St Gildas', 7),
(30, 9, 'Port St Gildas', 'Quiberon', 1),
(21, 8, 'Lorient', 'Port-Tudy', 2),
(22, 7, 'Port-Tudy', 'Lorient', 3);

-- --------------------------------------------------------

--
-- Structure de la table `nbpassagers`
--

CREATE TABLE IF NOT EXISTS `nbpassagers` (
  `nombateau` varchar(100) NOT NULL,
  `codecategorie` varchar(100) NOT NULL,
  `nbplaces` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `nbpassagers`
--

INSERT INTO `nbpassagers` (`nombateau`, `codecategorie`, `nbplaces`) VALUES
('Luce isle', 'A', 100),
('Luce isle', 'B', 125),
('Luce isle', 'C', 236),
('Al xi', 'A', 256),
('Al xi', 'B', 301),
('Al xi', 'C', 58);

-- --------------------------------------------------------

--
-- Structure de la table `periode`
--

CREATE TABLE IF NOT EXISTS `periode` (
`idperiode` int(11) NOT NULL,
  `datedebut` date NOT NULL,
  `datefin` date NOT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Contenu de la table `periode`
--

INSERT INTO `periode` (`idperiode`, `datedebut`, `datefin`) VALUES
(1, '2014-09-01', '2015-06-15'),
(2, '2015-06-16', '2015-09-15'),
(3, '2015-09-16', '2016-05-31');

-- --------------------------------------------------------

--
-- Structure de la table `reservation`
--

CREATE TABLE IF NOT EXISTS `reservation` (
  `idtraversee` varchar(100) NOT NULL,
  `codecategorie` varchar(100) NOT NULL,
  `nbplaces` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `reservation`
--

INSERT INTO `reservation` (`idtraversee`, `codecategorie`, `nbplaces`) VALUES
('13', 'A', 12),
('12', 'B', 15),
('12', 'C', 10),
('12', 'A', 12),
('11', 'C', 10),
('11', 'B', 15),
('11', 'A', 12),
('10', 'C', 10),
('10', 'B', 15),
('10', 'A', 12),
('9', 'C', 10),
('9', 'B', 15),
('9', 'A', 12),
('8', 'C', 10),
('8', 'B', 15),
('8', 'A', 12),
('7', 'C', 10),
('7', 'B', 15),
('7', 'A', 12),
('6', 'C', 10),
('6', 'B', 15),
('6', 'A', 12),
('5', 'C', 10),
('5', 'B', 0),
('5', 'A', 12),
('4', 'C', 10),
('4', 'B', 15),
('4', 'A', 12),
('3', 'C', 10),
('3', 'B', 15),
('3', 'A', 12),
('2', 'C', 10),
('2', 'B', 15),
('2', 'A', 12),
('1', 'C', 10),
('1', 'B', 15),
('1', 'A', 82),
('13', 'B', 15),
('13', 'C', 10),
('14', 'A', 12),
('14', 'B', 15),
('14', 'C', 10),
('15', 'A', 100),
('15', 'B', 8),
('15', 'C', 5);

-- --------------------------------------------------------

--
-- Structure de la table `reservationclient`
--

CREATE TABLE IF NOT EXISTS `reservationclient` (
`idreservation` int(11) NOT NULL,
  `nbplacesclient` int(11) NOT NULL,
  `idtraversee` varchar(100) NOT NULL,
  `codecategorie` varchar(100) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `adresse` varchar(100) NOT NULL,
  `cp` varchar(100) NOT NULL,
  `ville` varchar(100) NOT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=43 ;

--
-- Contenu de la table `reservationclient`
--

INSERT INTO `reservationclient` (`idreservation`, `nbplacesclient`, `idtraversee`, `codecategorie`, `nom`, `adresse`, `cp`, `ville`) VALUES
(1, 10, '15', 'A', 'Blondiaux', 'rue de wailly', '59200', 'Tourcoing'),
(2, 10, '15', 'B', 'Blondiaux', 'rue de wailly', '59200', 'Tourcoing'),
(3, 0, '15', 'C', 'Blondiaux', 'rue de wailly', '59200', 'Tourcoing'),
(4, 11, '15', 'A', 'Blondiaux', 'Dorian', '59200', 'Tourcoing'),
(5, 0, '15', 'B', 'Blondiaux', 'Dorian', '59200', 'Tourcoing'),
(6, 1, '15', 'C', 'Blondiaux', 'Dorian', '59200', 'Tourcoing'),
(7, 49, '11', 'A', 'Blimou', 'Lolz', '59632', 'LAAANDA'),
(8, 11, '11', 'B', 'Blimou', 'Lolz', '59632', 'LAAANDA'),
(9, 13, '11', 'C', 'Blimou', 'Lolz', '59632', 'LAAANDA'),
(10, 40, '15', 'A', 'Blondiaux', 'rue wailly', '58963', 'tcg'),
(11, 0, '15', 'B', 'Blondiaux', 'rue wailly', '58963', 'tcg'),
(12, 5, '15', 'C', 'Blondiaux', 'rue wailly', '58963', 'tcg'),
(13, 30, '15', 'A', 'Nasus', 'Lol', '125896', 'Lolilol'),
(14, 0, '15', 'B', 'Nasus', 'Lol', '125896', 'Lolilol'),
(15, 0, '15', 'C', 'Nasus', 'Lol', '125896', 'Lolilol'),
(21, 0, '15', 'C', 'Jeanckid', 'roubé', '102352', 'ruemoulin'),
(20, 0, '15', 'B', 'Jeanckid', 'roubé', '102352', 'ruemoulin'),
(19, 12, '15', 'A', 'Jeanckid', 'roubé', '102352', 'ruemoulin'),
(22, 13, '15', 'A', 'Jeanckid', 'rebx', '152368', 'jecpa'),
(23, 0, '15', 'B', 'Jeanckid', 'rebx', '152368', 'jecpa'),
(24, 0, '15', 'C', 'Jeanckid', 'rebx', '152368', 'jecpa'),
(25, 13, '15', 'A', 'aze', 'zerzer', '12563', 'etert'),
(26, 1, '15', 'B', 'aze', 'zerzer', '12563', 'etert'),
(27, 0, '15', 'C', 'aze', 'zerzer', '12563', 'etert'),
(28, 0, '', 'A', '', '', '', ''),
(29, 0, '', 'B', '', '', '', ''),
(30, 0, '', 'C', '', '', '', ''),
(31, 0, '', 'A', '', '', '', ''),
(32, 0, '', 'B', '', '', '', ''),
(33, 0, '', 'C', '', '', '', ''),
(34, 0, '', 'A', '', '', '', ''),
(35, 0, '', 'B', '', '', '', ''),
(36, 0, '', 'C', '', '', '', ''),
(37, 4, '15', 'A', 'Jean', 'erzer', '125362', 'cgfgh'),
(38, 0, '15', 'B', 'Jean', 'erzer', '125362', 'cgfgh'),
(39, 0, '15', 'C', 'Jean', 'erzer', '125362', 'cgfgh'),
(40, 0, '15', 'A', 'dfsg', 'grtgrt', '59000', 'zrfdver'),
(41, 7, '15', 'B', 'dfsg', 'grtgrt', '59000', 'zrfdver'),
(42, 0, '15', 'C', 'dfsg', 'grtgrt', '59000', 'zrfdver');

-- --------------------------------------------------------

--
-- Structure de la table `secteur`
--

CREATE TABLE IF NOT EXISTS `secteur` (
`idsecteur` int(10) unsigned NOT NULL,
  `libellesecteur` varchar(100) NOT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Contenu de la table `secteur`
--

INSERT INTO `secteur` (`idsecteur`, `libellesecteur`) VALUES
(1, 'Aix'),
(2, 'Batz'),
(3, 'Belle-Ile-en-Mer'),
(4, 'Bréhat'),
(5, 'Houat'),
(6, 'Ile de Groix'),
(7, 'Molène'),
(8, 'Ouessant'),
(9, 'Sein'),
(10, 'Yeu');

-- --------------------------------------------------------

--
-- Structure de la table `tarif`
--

CREATE TABLE IF NOT EXISTS `tarif` (
  `idperiode` int(11) NOT NULL,
  `idliaison` int(11) NOT NULL,
  `codetype` varchar(100) NOT NULL,
  `prix` decimal(10,0) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `tarif`
--

INSERT INTO `tarif` (`idperiode`, `idliaison`, `codetype`, `prix`) VALUES
(1, 15, 'A1', '18'),
(2, 15, 'A1', '20'),
(3, 15, 'A1', '19'),
(1, 15, 'A2', '11'),
(2, 15, 'A2', '13'),
(3, 15, 'A2', '12'),
(1, 15, 'A3', '6'),
(2, 15, 'A3', '7'),
(3, 15, 'A3', '6'),
(1, 15, 'B1', '86'),
(2, 15, 'B1', '95'),
(3, 15, 'B1', '91'),
(1, 15, 'B2', '129'),
(2, 15, 'B2', '142'),
(3, 15, 'B2', '136'),
(1, 15, 'C1', '189'),
(2, 15, 'C1', '208'),
(3, 15, 'C1', '199'),
(1, 15, 'C2', '205'),
(2, 15, 'C2', '226'),
(3, 15, 'C2', '216'),
(1, 15, 'C3', '268'),
(2, 15, 'C3', '295'),
(3, 15, 'C3', '282'),
(1, 16, 'A1', '18'),
(2, 16, 'A1', '20'),
(3, 16, 'A1', '19'),
(1, 16, 'A2', '11'),
(2, 16, 'A2', '13'),
(3, 16, 'A2', '12'),
(1, 16, 'A3', '6'),
(2, 16, 'A3', '7'),
(3, 16, 'A3', '6'),
(1, 16, 'B1', '86'),
(2, 16, 'B1', '95'),
(3, 16, 'B1', '91'),
(1, 16, 'B2', '129'),
(2, 16, 'B2', '142'),
(3, 16, 'B2', '136'),
(1, 16, 'C1', '189'),
(2, 16, 'C1', '208'),
(3, 16, 'C1', '199'),
(1, 16, 'C2', '205'),
(2, 16, 'C2', '226'),
(3, 16, 'C2', '216'),
(1, 16, 'C3', '268'),
(2, 16, 'C3', '295'),
(3, 16, 'C3', '282'),
(1, 17, 'A1', '18'),
(2, 17, 'A1', '20'),
(3, 17, 'A1', '19'),
(1, 17, 'A2', '11'),
(2, 17, 'A2', '13'),
(3, 17, 'A2', '12'),
(1, 17, 'A3', '6'),
(2, 17, 'A3', '7'),
(3, 17, 'A3', '6'),
(1, 17, 'B1', '86'),
(2, 17, 'B1', '95'),
(3, 17, 'B1', '91'),
(1, 17, 'B2', '129'),
(2, 17, 'B2', '142'),
(3, 17, 'B2', '136'),
(1, 17, 'C1', '189'),
(2, 17, 'C1', '208'),
(3, 17, 'C1', '199'),
(1, 17, 'C2', '205'),
(2, 17, 'C2', '226'),
(3, 17, 'C2', '216'),
(1, 17, 'C3', '268'),
(2, 17, 'C3', '295'),
(3, 17, 'C3', '282'),
(1, 19, 'A1', '18'),
(2, 19, 'A1', '20'),
(3, 19, 'A1', '19'),
(1, 19, 'A2', '11'),
(2, 19, 'A2', '13'),
(3, 19, 'A2', '12'),
(1, 19, 'A3', '6'),
(2, 19, 'A3', '7'),
(3, 19, 'A3', '6'),
(1, 19, 'B1', '86'),
(2, 19, 'B1', '95'),
(3, 19, 'B1', '91'),
(1, 19, 'B2', '129'),
(2, 19, 'B2', '142'),
(3, 19, 'B2', '136'),
(1, 19, 'C1', '189'),
(2, 19, 'C1', '208'),
(3, 19, 'C1', '199'),
(1, 19, 'C2', '205'),
(2, 19, 'C2', '226'),
(3, 19, 'C2', '216'),
(1, 19, 'C3', '268'),
(2, 19, 'C3', '295'),
(3, 19, 'C3', '282'),
(1, 21, 'A1', '18'),
(2, 21, 'A1', '20'),
(3, 21, 'A1', '19'),
(1, 21, 'A2', '11'),
(2, 21, 'A2', '13'),
(3, 21, 'A2', '12'),
(1, 21, 'A3', '6'),
(2, 21, 'A3', '7'),
(3, 21, 'A3', '6'),
(1, 21, 'B1', '86'),
(2, 21, 'B1', '95'),
(3, 21, 'B1', '91'),
(1, 21, 'B2', '129'),
(2, 21, 'B2', '142'),
(3, 21, 'B2', '136'),
(1, 21, 'C1', '189'),
(2, 21, 'C1', '208'),
(3, 21, 'C1', '199'),
(1, 21, 'C2', '205'),
(2, 21, 'C2', '226'),
(3, 21, 'C2', '216'),
(1, 21, 'C3', '268'),
(2, 21, 'C3', '295'),
(3, 21, 'C3', '282'),
(1, 22, 'A1', '18'),
(2, 22, 'A1', '20'),
(3, 22, 'A1', '19'),
(1, 22, 'A2', '11'),
(2, 22, 'A2', '13'),
(3, 22, 'A2', '12'),
(1, 22, 'A3', '6'),
(2, 22, 'A3', '7'),
(3, 22, 'A3', '6'),
(1, 22, 'B1', '86'),
(2, 22, 'B1', '95'),
(3, 22, 'B1', '91'),
(1, 22, 'B2', '129'),
(2, 22, 'B2', '142'),
(3, 22, 'B2', '136'),
(1, 22, 'C1', '189'),
(2, 22, 'C1', '208'),
(3, 22, 'C1', '199'),
(1, 22, 'C2', '205'),
(2, 22, 'C2', '226'),
(3, 22, 'C2', '216'),
(1, 22, 'C3', '268'),
(2, 22, 'C3', '295'),
(3, 22, 'C3', '282'),
(1, 24, 'A1', '18'),
(2, 24, 'A1', '20'),
(3, 24, 'A1', '19'),
(1, 24, 'A2', '11'),
(2, 24, 'A2', '13'),
(3, 24, 'A2', '12'),
(1, 24, 'A3', '6'),
(2, 24, 'A3', '7'),
(3, 24, 'A3', '6'),
(1, 24, 'B1', '86'),
(2, 24, 'B1', '95'),
(3, 24, 'B1', '91'),
(1, 24, 'B2', '129'),
(2, 24, 'B2', '142'),
(3, 24, 'B2', '136'),
(1, 24, 'C1', '189'),
(2, 24, 'C1', '208'),
(3, 24, 'C1', '199'),
(1, 24, 'C2', '205'),
(2, 24, 'C2', '226'),
(3, 24, 'C2', '216'),
(1, 24, 'C3', '268'),
(2, 24, 'C3', '295'),
(3, 24, 'C3', '282'),
(1, 11, 'A1', '18'),
(2, 11, 'A1', '20'),
(3, 11, 'A1', '19'),
(1, 11, 'A2', '11'),
(2, 11, 'A2', '13'),
(3, 11, 'A2', '12'),
(1, 11, 'A3', '6'),
(2, 11, 'A3', '7'),
(3, 11, 'A3', '6'),
(1, 11, 'B1', '86'),
(2, 11, 'B1', '95'),
(3, 11, 'B1', '91'),
(1, 11, 'B2', '129'),
(2, 11, 'B2', '142'),
(3, 11, 'B2', '136'),
(1, 11, 'C1', '189'),
(2, 11, 'C1', '208'),
(3, 11, 'C1', '199'),
(1, 11, 'C2', '205'),
(2, 11, 'C2', '226'),
(3, 11, 'C2', '216'),
(1, 11, 'C3', '268'),
(2, 11, 'C3', '295'),
(3, 11, 'C3', '282'),
(1, 30, 'A1', '18'),
(2, 30, 'A1', '20'),
(3, 30, 'A1', '19'),
(1, 30, 'A2', '11'),
(2, 30, 'A2', '13'),
(3, 30, 'A2', '12'),
(1, 30, 'A3', '6'),
(2, 30, 'A3', '7'),
(3, 30, 'A3', '6'),
(1, 30, 'B1', '86'),
(2, 30, 'B1', '95'),
(3, 30, 'B1', '91'),
(1, 30, 'B2', '129'),
(2, 30, 'B2', '142'),
(3, 30, 'B2', '136'),
(1, 30, 'C1', '189'),
(2, 30, 'C1', '208'),
(3, 30, 'C1', '199'),
(1, 30, 'C2', '205'),
(2, 30, 'C2', '226'),
(3, 30, 'C2', '216'),
(1, 30, 'C3', '268'),
(2, 30, 'C3', '295'),
(3, 30, 'C3', '282'),
(1, 25, 'A1', '18'),
(2, 25, 'A1', '20'),
(3, 25, 'A1', '19'),
(1, 25, 'A2', '11'),
(2, 25, 'A2', '13'),
(3, 25, 'A2', '12'),
(1, 25, 'A3', '6'),
(2, 25, 'A3', '7'),
(3, 25, 'A3', '6'),
(1, 25, 'B1', '86'),
(2, 25, 'B1', '95'),
(3, 25, 'B1', '91'),
(1, 25, 'B2', '129'),
(2, 25, 'B2', '142'),
(3, 25, 'B2', '136'),
(1, 25, 'C1', '189'),
(2, 25, 'C1', '208'),
(3, 25, 'C1', '199'),
(1, 25, 'C2', '205'),
(2, 25, 'C2', '226'),
(3, 25, 'C2', '216'),
(1, 25, 'C3', '268'),
(2, 25, 'C3', '295'),
(3, 25, 'C3', '282');

-- --------------------------------------------------------

--
-- Structure de la table `traversee`
--

CREATE TABLE IF NOT EXISTS `traversee` (
`idtraversee` int(11) NOT NULL,
  `heuretraversee` time NOT NULL,
  `datetraversee` date NOT NULL,
  `idliaison` int(11) NOT NULL,
  `nombateau` varchar(100) NOT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Contenu de la table `traversee`
--

INSERT INTO `traversee` (`idtraversee`, `heuretraversee`, `datetraversee`, `idliaison`, `nombateau`) VALUES
(1, '05:00:00', '2015-11-18', 15, 'Luce isle'),
(2, '06:00:00', '2015-11-15', 24, 'Kor Ant'),
(3, '07:00:00', '2015-11-04', 16, 'Al xi'),
(4, '08:00:00', '2015-11-02', 17, 'Kor Ant'),
(5, '09:00:00', '2015-11-30', 19, 'Luce isle'),
(6, '10:00:00', '2015-11-28', 11, 'Kor Ant'),
(7, '11:00:00', '2015-11-26', 25, 'Ar Solen'),
(8, '12:00:00', '2015-11-15', 30, 'Al xi'),
(9, '13:00:00', '2015-11-09', 21, 'Kor Ant'),
(10, '14:00:00', '2015-11-03', 22, 'Luce isle'),
(11, '15:00:00', '2015-11-01', 15, 'Ar Solen'),
(12, '16:00:00', '2015-11-14', 15, 'Kor Ant'),
(13, '17:00:00', '2015-11-22', 15, 'Al xi'),
(14, '18:00:00', '2015-11-30', 15, 'Ar Solen'),
(15, '19:00:00', '2015-11-01', 15, 'Luce isle');

-- --------------------------------------------------------

--
-- Structure de la table `typee`
--

CREATE TABLE IF NOT EXISTS `typee` (
  `codetype` varchar(100) NOT NULL,
  `libelletype` varchar(100) NOT NULL,
  `codecategorie` varchar(30) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `typee`
--

INSERT INTO `typee` (`codetype`, `libelletype`, `codecategorie`) VALUES
('A1', 'Adulte', 'A'),
('A2', 'Junior de 8 à 18 ans', 'A'),
('A3', 'Enfant de 0 à 7 ans', 'A'),
('B1', 'Voiture inférieur à 4 mètres', 'B'),
('B2', 'Voiure inférieur à 5 mètres', 'B'),
('C1', 'Fourgon', 'C'),
('C2', 'Camping Car', 'C'),
('C3', 'Camion', 'C');

--
-- Index pour les tables exportées
--

--
-- Index pour la table `bateau`
--
ALTER TABLE `bateau`
 ADD PRIMARY KEY (`nombateau`);

--
-- Index pour la table `bateaufret`
--
ALTER TABLE `bateaufret`
 ADD PRIMARY KEY (`nombateau`);

--
-- Index pour la table `bateautransport`
--
ALTER TABLE `bateautransport`
 ADD PRIMARY KEY (`nombateau`);

--
-- Index pour la table `categorie`
--
ALTER TABLE `categorie`
 ADD PRIMARY KEY (`codecategorie`);

--
-- Index pour la table `liaison`
--
ALTER TABLE `liaison`
 ADD PRIMARY KEY (`idliaison`), ADD KEY `idsecteur` (`idsecteur`);

--
-- Index pour la table `nbpassagers`
--
ALTER TABLE `nbpassagers`
 ADD PRIMARY KEY (`nombateau`,`codecategorie`), ADD KEY `codecategorie` (`codecategorie`);

--
-- Index pour la table `periode`
--
ALTER TABLE `periode`
 ADD PRIMARY KEY (`idperiode`);

--
-- Index pour la table `reservation`
--
ALTER TABLE `reservation`
 ADD PRIMARY KEY (`idtraversee`,`codecategorie`), ADD KEY `codecategorie` (`codecategorie`);

--
-- Index pour la table `reservationclient`
--
ALTER TABLE `reservationclient`
 ADD PRIMARY KEY (`idreservation`), ADD KEY `idtraversee` (`idtraversee`);

--
-- Index pour la table `secteur`
--
ALTER TABLE `secteur`
 ADD PRIMARY KEY (`idsecteur`);

--
-- Index pour la table `tarif`
--
ALTER TABLE `tarif`
 ADD PRIMARY KEY (`idperiode`,`idliaison`,`codetype`), ADD KEY `idliaison` (`idliaison`), ADD KEY `codetype` (`codetype`);

--
-- Index pour la table `traversee`
--
ALTER TABLE `traversee`
 ADD PRIMARY KEY (`idtraversee`), ADD KEY `idliaison` (`idliaison`), ADD KEY `nombateau` (`nombateau`);

--
-- Index pour la table `typee`
--
ALTER TABLE `typee`
 ADD PRIMARY KEY (`codetype`), ADD KEY `codecategorie` (`codecategorie`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `liaison`
--
ALTER TABLE `liaison`
MODIFY `idliaison` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=31;
--
-- AUTO_INCREMENT pour la table `periode`
--
ALTER TABLE `periode`
MODIFY `idperiode` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT pour la table `reservationclient`
--
ALTER TABLE `reservationclient`
MODIFY `idreservation` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=43;
--
-- AUTO_INCREMENT pour la table `secteur`
--
ALTER TABLE `secteur`
MODIFY `idsecteur` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT pour la table `traversee`
--
ALTER TABLE `traversee`
MODIFY `idtraversee` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=16;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
