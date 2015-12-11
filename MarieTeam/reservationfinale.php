<?php session_start(); header( 'content-type: text/html; charset=utf-8' );?>
<!DOCTYPE html>
<html lang="fr">

<head>

    <meta charset="utf-8">
	<link id="styledebase" rel="stylesheet" href="style.css" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Marie Team</title>
	
	<script type="text/javascript">
		//Fonctions AJAX
			function getXMLHttpRequest() {
				var xhr = null;
				if (window.XMLHttpRequest || window.ActiveXObject) {
					if (window.ActiveXObject) {
						try {
							xhr = new ActiveXObject("Msxml2.XMLHTTP");
						} catch(e) {
							xhr = new ActiveXObject("Microsoft.XMLHTTP");
						}
					} else {
						xhr = new XMLHttpRequest(); 
					}
				} else {
					alert("Votre navigateur ne supporte pas l'objet XMLHTTPRequest...");
					return null;
				}
				return xhr;
			}


			function choixSecteur(id) {
				var xhr = getXMLHttpRequest();
				xhr.onreadystatechange = function() {
					if (xhr.readyState == 4 && (xhr.status == 200 || xhr.status == 0)) {
						document.getElementById('main_content').innerHTML = xhr.responseText; // Données textuelles récupérées
					}
				};
				xhr.open("POST", "secteur.php", true);
				xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
				xhr.send("id=" + id);
			}
			
			function choixDate(idDate) {
				var xhr = getXMLHttpRequest();
				xhr.onreadystatechange = function() {
					if (xhr.readyState == 4 && (xhr.status == 200 || xhr.status == 0)) {
						document.getElementById('main_content').innerHTML = xhr.responseText; // Données textuelles récupérées
					}
				};
				xhr.open("POST", "secteur.php", true);
				xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
				xhr.send("idDate=" + idDate);
			}
			
			function tab(idLiaison, date) {
				var xhr = getXMLHttpRequest();
				xhr.onreadystatechange = function() {
					if (xhr.readyState == 4 && (xhr.status == 200 || xhr.status == 0)) {
						document.getElementById('main_content').innerHTML = xhr.responseText; // Données textuelles récupérées
					}
				};
				xhr.open("POST", "secteur.php", true);
				xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
				xhr.send("idLiaison=" + idLiaison + "&date=" + date);
			}
			
			function reserver(idLiaison, idTraversee, date, heure) {
				var xhr = getXMLHttpRequest();
				xhr.onreadystatechange = function() {
					if (xhr.readyState == 4 && (xhr.status == 200 || xhr.status == 0)) {
						document.getElementById('main_content').innerHTML = xhr.responseText; // Données textuelles récupérées
					}
				};
				xhr.open("POST", "reservation.php", true);
				xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
				xhr.send("idLiaison=" + idLiaison + "&date=" + date + "&idTraversee=" + idTraversee + "&heure=" + heure);
			}
			
			
			// Fonctions non ajax
			
		</script>
</head>

<body>
	<header>
		<h1> Compagnie Marie Team </h1>
	</header>
	
		<aside id="lst_secteurs" >

				
				    <?php
					//Récuperer la liste des secteurs pour afficher le bandeau gauche du site
						$conn = mysqli_connect("localhost", "root", "root", "marieteam");
						mysqli_query($conn,"SET NAMES UTF8"); 
                        $req="SELECT * FROM secteur";
                        $sql= mysqli_query($conn, $req);      
                        // Recuperer le contenu de la table
                        while ($row = mysqli_fetch_array($sql)) {
                            echo '<li> <a onclick="choixSecteur(\''.$row['idsecteur'].'\')" class="secteur" id="'.$row['idsecteur'].'" >'.$row['libellesecteur'].'</a></li><br />';
                        }
                        mysqli_close($conn);
                    ?>
        </aside>
		
		<section id="main_content" >
			<?php
				//Connection bdd
				$conn = mysqli_connect('localhost', 'root', 'root', 'marieteam');
				mysqli_query($conn,"SET NAMES UTF8"); 
				
				# reconstitution des tableaux
				$libelle=$_POST['libelle'];
				$tarif=$_POST['tarif'];
				$code=$_POST['code'];
				$codeCategorie=$_POST['codeCategorie'];
				
				$tabLibelleType=explode(";",$libelle);
				$tabTarifs=explode(";",$tarif);
				$tabCodeType=explode(";",$code);
				$tabCodeCategorie=explode(";",$codeCategorie);
				
				/*print_r($tabLibelleType);
				echo '<br /><br />';
				print_r($tabTarifs);
				echo '<br /><br />';*/
				
				// On récupère les valeurs des champs de la reservation dans un tab.
				$reponses=array();
				$i=-1;
				foreach( $_POST as $key => $value ) {
					$i++;
					if($key!="submit" && strpos($key,"form") === false){
						$reponses[$i]=$value;
						if ($value="" || isset($value)==false){
							$reponses[$i]=' ';
						}
					}
				}
				//print_r($reponses);
				//Triage des champs dans des tableaux distincts
				$client=array();
				for($i=0;$i<4;$i++){
					$client[]=$reponses[$i];
				}
				/*print_r($client);
				echo '<br /><br />';
				echo '<br /><br />';*/
				
				
				$quantites=array();
				for($i=4;$i<(count($reponses)-9);$i++){
					$quantites[]=$reponses[$i];
				}
				//print_r($quantites);
				
				//Recuperations des infos reservation traversee
				$idLiaison=$_POST['idLiaison'];
				$idTraversee=$_POST['idTraversee'];
				$date=$_POST['date'];
				$heure=$_POST['heure'];
				
				/*echo '<br /><br />';
				echo '<br /><br />';
				echo $idLiaison.' '.$idTraversee.' '.$date.' '.$heure;
				echo '<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />';*/
				
				//Affichage & Traitement
				//Affichage type Quiberon-Le Palais.
				$req="SELECT portdepart, portarrivee  FROM liaison WHERE $idLiaison=liaison.idliaison";
				$sql = $conn->query($req);										
				while ($row = mysqli_fetch_array($sql)) {
					echo $row['portdepart'].'-'.$row['portarrivee'].".<br />";
				} 		
				// Traversee N°...
				echo "Traversée N°$idTraversee le $date à $heure <br /><br />";
				
				//Regroupenet des types en categorie pour calculer le nb de places reservees par categorie
				$tabQuantitesCategorie=array();
				$i=-1;
				//Recuperation des code categorie
				$tabCategoriePlaces=array();
				$req="SELECT codecategorie FROM categorie";
				$sql = $conn->query($req);
				while ($row = mysqli_fetch_array($sql)) {
					$i+=1;
					$tabCategoriePlaces[]=$row['codecategorie'];
					$tabQuantitesCategorie[$i]=0;
					//Si les codecategirues sont identiques on ajoute dans une case par categorie
					for($j=0;$j<count($quantites);$j++){
						if($tabCategoriePlaces[$i]==$tabCodeCategorie[$j]){
							$tabQuantitesCategorie[$i]+=$quantites[$j];
						}
					}
				} 
				//echo '<br /><br />';
				//print_r($tabQuantitesCategorie);
				
				// OUAI J AI REUSSI A REGROUPER LES CODES CATEGORIES NE PAS CHERCHER A COMPRENDRE CE BORDEL JUSTE AU DESSUS MAIS CA REGROUPE NIQUEL XDDDD
				
				$reqOKornot=true;
				
					//D'abord on recup le nombre de places reservees par catégorie
					$nbplacetemp=array();
					
					for($i=0;$i<count($tabCategoriePlaces);$i++){
						$req="SELECT nbplaces FROM reservation WHERE idtraversee=$idTraversee AND codecategorie='$tabCategoriePlaces[$i]'";
						$sql = $conn->query($req);
						while ($row = mysqli_fetch_array($sql)) {
							$nbplacetemp[]=$row['nbplaces'];
						} 
					}	
					//On verifie qu'il reste assez de places, on recup d'abord le nom du bateau
					$req="SELECT nombateau FROM traversee WHERE idtraversee=$idTraversee";
					$sql = $conn->query($req);
					while ($row = mysqli_fetch_array($sql)) {
						$bateau=$row['nombateau'];
					} 
					
					//Puis on recup les places du bateau 
					$req="SELECT nbplaces FROM nbpassagers WHERE nombateau='$bateau'";
					$sql = $conn->query($req);
					$nbplacebateau=array();
					while ($row = mysqli_fetch_array($sql)) {
						$nbplacebateau[]=$row['nbplaces'];
					} 
					
					//print_r($nbplacetemp);
					//print_r($nbplacebateau);
					
					// On check si il reste assez de places
					for($i=0;$i<count($tabQuantitesCategorie);$i++){
						if(($nbplacebateau[$i]-$tabQuantitesCategorie[$i]-$nbplacetemp[$i])<0){
							$reqOKornot=false;
						}
					
					}
				
				
				
				
				
				//Insertion de la reservation et update de la table globale des reservations SI la reservation est possible
				if($reqOKornot){
					for($i=0;$i<count($tabQuantitesCategorie);$i++){
						$req="INSERT INTO reservationclient(nbplacesclient, idtraversee, codecategorie, nom, adresse, cp, ville) VALUES('$tabQuantitesCategorie[$i]', '$idTraversee', '$tabCategoriePlaces[$i]', '$client[0]', '$client[1]', '$client[2]', '$client[3]' ) ";
						$sql = $conn->query($req);
						if ($sql){}
						else{
							$reqOKornot=false;
						}
						
						//Update
						$req="UPDATE reservation SET nbplaces= $nbplacetemp[$i] + $tabQuantitesCategorie[$i] WHERE idtraversee=$idTraversee AND codecategorie='$tabCategoriePlaces[$i]'  ";
						$sql = $conn->query($req);
						if ($sql){}
						else{
							$reqOKornot=false;
						}
					}
				
				
					//Si les requetes ont fonctionnées on affiche le message normal
					echo 'Réservation enregistrée sous le n° XXXXXXX <br /><br />';
					echo "$client[0] $client[1] $client[2] $client[3]<br />";
					for($i=0;$i<count($tabLibelleType);$i++){
						if($quantites[$i]>0){
							echo $tabLibelleType[$i].': '.$quantites[$i].'<br />';
						}
					}	
					//Calcul du montant à regler et affichage
					$montant=0;
					for($i=0;$i<count($tabTarifs);$i++){
						$montant+=$tabTarifs[$i]*$quantites[$i];
					}	
					
					echo '<br /> Montant total à régler: '.$montant.' euros.';
					// (Peut être rajouter sur chaque insertion dependant de la catégorie un numero commun pour le XXXXXXX)
				}
				//Sinon on indique qu'il n'y a pas le nombre de places demandés dispo"
				else{
					echo 'Le nombre de places que vous avez demandé depasse les places restantes sur le bateau, veuillez réserver à une date ulterieure.';
				}
				mysqli_close($conn);
			?>
		</section>
</body>
<footer>

</footer>
</html>
