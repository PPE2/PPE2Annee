<?php

$sql = mysql_query("CREATE TABLE IF NOT EXISTS secteur(
        idsecteur INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, 
        libellesecteur varchar(100) NOT NULL,
        PRIMARY KEY(idsecteur))");
		
$sql = mysql_query("CREATE TABLE IF NOT EXISTS liaison(
        idliaison INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, 
        distmiles INTEGER UNSIGNED NOT NULL,
		portdepart varchar(100) NOT NULL,
		portarrivee varchar(100) NOT NULL,
		idsecteur INTEGER UNSIGNED NOT NULL,
		FOREIGN KEY(idsecteur) REFERENCES secteur(idsecteur),
        PRIMARY KEY(idliaison))");		
		
$sql = mysql_query("CREATE TABLE IF NOT EXISTS bateau(		
		nombateau varchar(100) NOT NULL,
		longueurbateau INTEGER UNSIGNED NOT NULL,
		largeurbateau INTEGER UNSIGNED NOT NULL,
		PRIMARY KEY(nombateau))");	
		
$sql = mysql_query("CREATE TABLE IF NOT EXISTS bateautransport(
		vitessebateau INTEGER UNSIGNED NOT NULL) INHERITS (bateau)");
		
$sql = mysql_query("CREATE TABLE IF NOT EXISTS bateautransport(
		poidsmax INTEGER UNSIGNED NOT NULL) INHERITS (bateau)";
		
$sql = mysql_query("CREATE TABLE IF NOT EXISTS traversee(
        idtraversee INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, 
        heuretraversee DATE NOT NULL,
		datetraversee DATE NOT NULL,
		portarrivee varchar(100) NOT NULL,
		idliaison INTEGER UNSIGNED NOT NULL,
		nombateau varchar(100) NOT NULL,
		FOREIGN KEY(idliaison) REFERENCES liaison(idliaison),
		FOREIGN KEY(nombateau) REFERENCES bateau(nombateau),
        PRIMARY KEY(idtraversee))");	

$sql = mysql_query("CREATE TABLE IF NOT EXISTS categorie(
		codecategorie varchar(100) NOT NULL,
		libellecategorie varchar(100) NOT NULL,
		PRIMARY KEY(codecategorie))");
		
$sql = mysql_query("CREATE TABLE IF NOT EXISTS type(
		codetype varchar(100) NOT NULL,
		libelletype varchar(100) NOT NULL,
		PRIMARY KEY(codetype))");
		
$sql = mysql_query("CREATE TABLE IF NOT EXISTS periode(
		idperiode INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, 
		datedebut date NOT NULL,
		datefin date NOT NULL,
		PRIMARY KEY(codetype))");
		
$sql = mysql_query("CREATE TABLE IF NOT EXISTS tarif(
		idperiode INTEGER UNSIGNED NOT NULL, 
		idliaison INTEGER UNSIGNED NOT NULL, 
		codetype varchar(100) NOT NULL,
		prix INTEGER UNSIGNED NOT NULL, 
		FOREIGN KEY(idperiode) REFERENCES periode(idperiode),
		FOREIGN KEY(idliaison) REFERENCES liaison(idliaison),
		FOREIGN KEY(codetype) REFERENCES type(codetype),
		PRIMARY KEY(idperiode),
		PRIMARY KEY(idliaison),
		PRIMARY KEY(codetype))");