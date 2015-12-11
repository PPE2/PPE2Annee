CREATE TABLE IF NOT EXISTS nbpassagers(
    `nombateau` varchar(100) NOT NULL,
    `codecategorie` varchar(100) NOT NULL,
    `nbplaces` integer NOT NULL,
    PRIMARY KEY(nombateau, codecategorie),
    FOREIGN KEY(nombateau) REFERENCES bateau(nombateau),
    FOREIGN KEY(codecategorie) REFERENCES categorie(codecategorie));
	
CREATE TABLE IF NOT EXISTS reservation(
    `idtraversee` varchar(100) NOT NULL,
    `codecategorie` varchar(100) NOT NULL,
    `nbplaces` integer NOT NULL,
    PRIMARY KEY(idtraversee, codecategorie),
    FOREIGN KEY(idtraversee) REFERENCES traversee(idtraversee),
    FOREIGN KEY(codecategorie) REFERENCES categorie(codecategorie));
	
CREATE TABLE IF NOT EXISTS reservationclient(
    `idreservation` INTEGER AUTO_INCREMENT,
    `nbplacesclient` integer NOT NULL,
	`idtraversee` varchar(100) NOT NULL,
	`codecategorie` varchar(100) NOT NULL,
	`nom` varchar(100) NOT NULL,
	`adresse` varchar(100) NOT NULL,
	`cp` varchar(100) NOT NULL,
	`ville` varchar(100) NOT NULL,
    PRIMARY KEY(idreservation),
    FOREIGN KEY(idtraversee) REFERENCES traversee(idtraversee));	
	

ALTER TABLE typee
ADD CONSTRAINT codecategorie FOREIGN KEY (codecategorie) REFERENCES categorie(codecategorie);