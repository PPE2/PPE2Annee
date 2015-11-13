CREATE TABLE IF NOT EXISTS secteur(
        idsecteur SERIAL, 
        libellesecteur varchar(100) NOT NULL,
        PRIMARY KEY(idsecteur));
 


CREATE TABLE IF NOT EXISTS liaison(
    idliaison SERIAL, 
    distmiles INTEGER NOT NULL,
	portdepart varchar(100) NOT NULL,
	portarrivee varchar(100) NOT NULL,
	idsecteur INTEGER NOT NULL,
	FOREIGN KEY(idsecteur) REFERENCES secteur(idsecteur),
    PRIMARY KEY(idliaison));
		


CREATE TABLE IF NOT EXISTS bateau(		
	nombateau varchar(100) NOT NULL,
	longueurbateau INTEGER NOT NULL,
	largeurbateau INTEGER NOT NULL,
	PRIMARY KEY(nombateau));
	


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



CREATE TABLE IF NOT EXISTS typee(
	codetype varchar(100) NOT NULL,
	libelletype varchar(100) NOT NULL,
	PRIMARY KEY(codetype));

	
CREATE TABLE IF NOT EXISTS periode(
	idperiode SERIAL, 
	datedebut date NOT NULL,
	datefin date NOT NULL,
	PRIMARY KEY(idperiode));


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