CREATE TABLE IF NOT EXISTS secteur(
        idsecteur SERIAL, 
        libellesecteur varchar(100) NOT NULL,
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

CREATE TABLE IF NOT EXISTS liaison(
    idliaison SERIAL, 
    distmiles INTEGER NOT NULL,
	portdepart varchar(100) NOT NULL,
	portarrivee varchar(100) NOT NULL,
	idsecteur INTEGER NOT NULL,
	FOREIGN KEY(idsecteur) REFERENCES secteur(idsecteur),
    PRIMARY KEY(idliaison));
		
INSERT INTO `liaison` (`idliaison`, ``, ``,) VALUES
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

CREATE TABLE IF NOT EXISTS bateau(		
	nombateau varchar(100) NOT NULL,
	longueurbateau INTEGER NOT NULL,
	largeurbateau INTEGER NOT NULL,
	PRIMARY KEY(nombateau));
	
INSERT INTO `bateau` (`nombateau`, `longueurbateau`, `largeurbateau`) VALUES
	('Luce isle', '37,20', '8,60'),
	('Al\' xi', '25', '7');

CREATE TABLE IF NOT EXISTS bateautransport(
	vitessebateau INTEGER NOT NULL) INHERITS (bateau);

CREATE TABLE IF NOT EXISTS bateaufret(
		poidsmax INTEGER NOT NULL) INHERITS (bateau);

CREATE TABLE IF NOT EXISTS traversee(
    idtraversee SERIAL, 
    heuretraversee DATE NOT NULL,
	datetraversee DATE NOT NULL,
	portarrivee varchar(100) NOT NULL,
	idliaison INTEGER NOT NULL,
	nombateau varchar(100) NOT NULL,
	FOREIGN KEY(idliaison) REFERENCES liaison(idliaison),
	FOREIGN KEY(nombateau) REFERENCES bateau(nombateau),
    PRIMARY KEY(idtraversee));

CREATE TABLE IF NOT EXISTS categorie(
	codecategorie varchar(100) NOT NULL,
	libellecategorie varchar(100) NOT NULL,
	PRIMARY KEY(codecategorie));

INSERT INTO `categorie` (`codecategorie`, `libellecategorie`) VALUES
	('A', 'Passager'),
	('B', 'Véhicule inférieur à 2 mètres'),
	('C', 'Véhicule supérieur à 5 mètres');

CREATE TABLE IF NOT EXISTS typee(
	codetype varchar(100) NOT NULL,
	libelletype varchar(100) NOT NULL,
	PRIMARY KEY(codetype));

INSERT INTO `typee` (`codetype`, `libelletype`) VALUES
	('A1', 'Adulte'),
	('A2', 'Junior 8 à 18 ans'),
	('A3', 'Enfant 0 à 7 ans')
	('B1', 'Voiture inférieur à 4 mètres'),
	('B2', 'Voiture inférieur à 5 mètres'),
	('C1', 'Fourgon'),
	('C2', 'Camping Car'),
	('C3', 'Camion');
	
CREATE TABLE IF NOT EXISTS periode(
	idperiode SERIAL, 
	datedebut date NOT NULL,
	datefin date NOT NULL,
	PRIMARY KEY(idperiode));

INSERT INTO `typee` (`idperiode`, `datedebut`, `datefin`) VALUES
	('', '2014-09-01', '2015-06-15'),
	('', '2015-06-16', '2015-09-15'),
	('', '2015-09-16', '2016-05-31');

CREATE TABLE IF NOT EXISTS tarif(
	idperiode INTEGER NOT NULL, 
	idliaison INTEGER NOT NULL, 
	codetype varchar(100) NOT NULL,
	prix INTEGER NOT NULL, 
	FOREIGN KEY(idperiode) REFERENCES periode(idperiode),
	FOREIGN KEY(idliaison) REFERENCES liaison(idliaison),
	FOREIGN KEY(codetype) REFERENCES typee(codetype),
	UNIQUE(idperiode),
	UNIQUE(idliaison),
	UNIQUE(codetype));