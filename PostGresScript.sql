CREATE TABLE IF NOT EXISTS secteur(
        idsecteur SERIAL, 
        libellesecteur varchar(100) NOT NULL,
        PRIMARY KEY(idsecteur));
 
INSERT INTO secteur (idsecteur, libellesecteur) VALUES
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
    idliaison INTEGER NOT NULL, 
    distmiles INTEGER NOT NULL,
	portdepart varchar(100) NOT NULL,
	portarrivee varchar(100) NOT NULL,
	idsecteur INTEGER NOT NULL,
	FOREIGN KEY(idsecteur) REFERENCES secteur(idsecteur),
    PRIMARY KEY(idliaison));
		
INSERT INTO liaison (idliaison, distmiles, portdepart, portarriver, idsecteur) VALUES
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
	

CREATE TABLE IF NOT EXISTS bateau(		
	nombateau varchar(100) NOT NULL,
	longueurbateau INTEGER NOT NULL,
	largeurbateau INTEGER NOT NULL,
	PRIMARY KEY(nombateau));

CREATE TABLE IF NOT EXISTS bateautransport(
	vitessebateau INTEGER NOT NULL) INHERITS (bateau);
	
INSERT INTO bateautransport (nombateau, longueurbateau, largeurbateau vitessebateau) VALUES
	('Luce isle', '37.20', '8.60', '26'),
	('Al\' xi', '25', '7', '16');

CREATE TABLE IF NOT EXISTS bateaufret(
		poidsmax INTEGER NOT NULL) INHERITS (bateau);

CREATE TABLE IF NOT EXISTS traversee(
    idtraversee SERIAL, 
    heuretraversee DATE NOT NULL,
	datetraversee DATE NOT NULL,
	idliaison INTEGER NOT NULL,
	nombateau varchar(100) NOT NULL,
	FOREIGN KEY(idliaison) REFERENCES liaison(idliaison),
	FOREIGN KEY(nombateau) REFERENCES bateau(nombateau),
    PRIMARY KEY(idtraversee));

INSERT INTO traversee(idtraversee, heuretraversee, datetraversee, idliaison, nombateau)
	('', '05h00', '', , ,)
	('', '06h00', '', , ,)
	('', '07h00', '', , ,)
	('', '08h00', '', , ,)
	('', '09h00', '', , ,)
	('', '10h00', '', , ,)
	('', '11h00', '', , ,)
	('', '12h00', '', , ,)
	('', '13h00', '', , ,)
	('', '14h00', '', , ,)
	('', '', '', , ,)
	('', '', '', , ,)
	('', '', '', , ,)
	('', '', '', , ,)
	('', '', '', , ,)
	
	
CREATE TABLE IF NOT EXISTS categorie(
	codecategorie varchar(100) NOT NULL,
	libellecategorie varchar(100) NOT NULL,
	PRIMARY KEY(codecategorie));

INSERT INTO categorie (codecategorie, libellecategorie) VALUES
	('A', 'Passager'),
	('B', 'Véhicule inférieur à 5 mètres'),
	('C', 'Véhicule supérieur à 5 mètres');

CREATE TABLE IF NOT EXISTS typee(
	codetype varchar(100) NOT NULL,
	libelletype varchar(100) NOT NULL,
	PRIMARY KEY(codetype));

INSERT INTO typee (codetype, libelletype) VALUES
	('A1', 'Adulte'),
	('A2', 'Junior de 8 à 18 ans'),
	('A3', 'Enfant de 0 à 7 ans'),
	('B1', 'Voiture inférieur à 4 mètres'),
	('B2', 'Voiure inférieur à 5 mètres'),
	('C1', 'Fourgon'),
	('C2', 'Camping Car'),
	('C3', 'Camion');
	
CREATE TABLE IF NOT EXISTS periode(
	idperiode SERIAL, 
	datedebut date NOT NULL,
	datefin date NOT NULL,
	PRIMARY KEY(idperiode));

INSERT INTO periode (idperiode, datedebut, datefin) VALUES
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