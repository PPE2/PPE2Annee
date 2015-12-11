<?php
    session_start();
	header( 'content-type: text/html; charset=utf-8' );
	//Connexion bdd
	$conn = mysqli_connect('localhost', 'root', 'root', 'marieteam');
	$selected="";
	mysqli_query($conn,"SET NAMES UTF8"); 
	
	
	if (isset($_POST['id'])){
		$id=$_POST['id'];
		$_SESSION['id']=$id;
	}
	else{
		$id=$_SESSION['id'];
	}
	
	if (isset($_POST['idDate'])){
			$idDate=$_POST['idDate'];
	}
	
	if (isset($_POST['idLiaison'])){
			$idLiaison=$_POST['idLiaison'];
	}
	if (isset($_POST['date'])){
			$date=$_POST['date'];
	}	
		
	echo "<br />";
	echo "Sélectionner la liaison et la date souhaitée: <br />";
	
	// Requete recuperant les liaisons concernées par le secteur 
	echo '<SELECT name="lst_secteur" id="lst_secteur" onChange="choixDate(document.getElementById(\'lst_secteur\').value)" >';
	echo '<OPTION value="0"> Choisissez la liaison ';
    $req="SELECT idliaison, portdepart, portarrivee  FROM liaison WHERE $id=liaison.idsecteur";
    $sql = $conn->query($req);    
	
    // Recuperer le contenu de la table
    while ($row = mysqli_fetch_array($sql)) {
		
		// LE ISSET NE SE PRODUIT PAS AU PREMIER CHARGEMENT DE LA PAGE LES SECPA
		if(isset($idDate)){
			
			//Permet de garder la liaison selectionné a la prochaine fonction ajax
			if($row['idliaison']==$idDate){
				$selected=' selected="selected" ';
			}
		}
			//Liste des liaisons
			echo "<OPTION".' value="'.$row['idliaison'].'" '.$selected.'>'.$row['portdepart'].'-'.$row['portarrivee']."<br />";
		$selected="";
    }
    echo '</SELECT>';
     
	if(isset($idDate)){
		// Liste des dates de la liaison
		echo '<SELECT name="lst_dates_liaison" id="lst_dates_liaison">';
		$req="SELECT datetraversee  FROM traversee WHERE traversee.idliaison=$idDate";
		$sql = $conn->query($req);    
		// Recuperer le contenu de la table
		while ($row = mysqli_fetch_array($sql)) {
			echo "<OPTION".' value="'.$row['datetraversee'].'" >'.$row['datetraversee']."<br />";
		}                                                
		 echo '</SELECT>';                                           
	}
	//Bouton
	//lst_secteur c'est les liaisons
	echo '<input type="submit" name="btn_enregistrer" value="Enregistrer" onClick="tab(document.getElementById(\'lst_secteur\').value, document.getElementById(\'lst_dates_liaison\').value)">';
	
	//Tableau Traversees
	
	if(isset($idLiaison) && isset($date)){
		echo "<br /><br /><br /><br /><br /><br />";	
		//Affichage type Quiberon-Le Palais.
		$req="SELECT portdepart, portarrivee  FROM liaison WHERE $idLiaison=liaison.idliaison";
		$sql = $conn->query($req);										
		while ($row = mysqli_fetch_array($sql)) {
			echo $row['portdepart'].'-'.$row['portarrivee'].".<br />";
		} 		
		//Affichage type Traversees pour le xx/xx/xxxx ...
		echo "Traversées pour le $date. Sélectionner la traversée souhaitée <br /><br />";
		
		echo '<table>';
		echo '<tr><th colspan="3">Traversée</th><th colspan="3">Places disponibles pour la catégorie</th><th></th></tr>';
		echo '<tr><th>N°</th><th>Heure</th><th>Bateau</th><th>A Passager</th><th>B Véhicule Inf 2m</th><th>C Véhicule Sup 2m</th><th></th></tr>';
		
		//Requete du tableau: infos traversees
		$req="SELECT traversee.idtraversee, traversee.heuretraversee, traversee.nombateau, traversee.datetraversee from traversee where idliaison=$idLiaison";
		$sql = $conn->query($req);	
		
		//Tab generant le code du tableau
		$tabtraversee=array();
		//Tab content le nom des bateaux des traversees
		$tabBateau=array();
		
		// INFOS UTILES POUR LES RADIOBUTTONS ET LE BOUTON SUBMIT
		//Tab content les n° de traversee
		$tabtraverseeid=array();
		//Tab heures
		$tabheures=array();
		
		while ($row = mysqli_fetch_array($sql)) {
			if($row['datetraversee']==$date){
				$tabtraversee[] = '<tr><td>'.$row['idtraversee'].'</td><td>'.$row['heuretraversee'].'</td><td>'.$row['nombateau'].'</td>';
				//echo '<tr><td>'.$row['idtraversee'].'</td><td>'.$row['heuretraversee'].'</td><td>'.$row['nombateau'].'</td></tr>';
				$tabBateau[]=$row['nombateau'];
				$tabtraverseeid[]=$row['idtraversee'];
				$tabheures[]=$row['heuretraversee'];
			}
		}  
		//Requete du tabluea: places
		// Recup Nb places de chaque traversee bateau
		$tabCategorie=array();
		
		for($i=0;$i<count($tabBateau);$i++){
				$tabCategorie[]=array('0','0','0');
		}
		
		//print_r($tabBateau);
		for($i=0;$i<count($tabBateau);$i++){
			
			$req="SELECT nbplaces FROM nbpassagers WHERE nombateau='$tabBateau[$i]'  AND codecategorie='A'";
			$sql = $conn->query($req);	
			while ($row = mysqli_fetch_array($sql)) {
				$tabCategorie[$i][0]=$row['nbplaces'];
			}  
			
			$req="SELECT nbplaces FROM nbpassagers WHERE nombateau='$tabBateau[$i]'  AND codecategorie='B'";
			$sql = $conn->query($req);	
			while ($row = mysqli_fetch_array($sql)) {
				$tabCategorie[$i][1]=$row['nbplaces'];
			}  
			
			$req="SELECT nbplaces FROM nbpassagers WHERE nombateau='$tabBateau[$i]'  AND codecategorie='C'";
			$sql = $conn->query($req);	
			while ($row = mysqli_fetch_array($sql)) {
				$tabCategorie[$i][2]=$row['nbplaces'];
			}  
		}
		
		//Recup Nb places reservees sur chaque bateau
		$tabReserv=array();
		for($i=0;$i<count($tabBateau);$i++){
				$tabReserv[]=array('0','0','0');
		}
		
		for($i=0;$i<count($tabBateau);$i++){
			$req="SELECT reservation.nbplaces FROM reservation, traversee WHERE reservation.idtraversee=traversee.idtraversee AND traversee.nombateau='$tabBateau[$i]' AND codecategorie='A' AND  traversee.idtraversee=$tabtraverseeid[$i]";
			$sql = $conn->query($req);	
			while ($row = mysqli_fetch_array($sql)) {
				$tabReserv[$i][0]=$row['nbplaces'];
			}

			$req="SELECT reservation.nbplaces FROM reservation, traversee WHERE reservation.idtraversee=traversee.idtraversee AND traversee.nombateau='$tabBateau[$i]' AND codecategorie='B' AND  traversee.idtraversee=$tabtraverseeid[$i]";
			$sql = $conn->query($req);	
			while ($row = mysqli_fetch_array($sql)) {
				$tabReserv[$i][1]=$row['nbplaces'];
			}
			
			$req="SELECT reservation.nbplaces FROM reservation, traversee WHERE reservation.idtraversee=traversee.idtraversee AND traversee.nombateau='$tabBateau[$i]' AND codecategorie='C' AND  traversee.idtraversee=$tabtraverseeid[$i]";
			$sql = $conn->query($req);	
			while ($row = mysqli_fetch_array($sql)) {
				$tabReserv[$i][2]=$row['nbplaces'];
			}
			
		}
		
		//Differences des deux tableaux pour obtenir places restantes
		$tabPlacesRestantes=array();
		for($i=0;$i<count($tabBateau);$i++){
				$tabPlacesRestantes[]=array('0','0','0');
		}
		
		for($i=0;$i<count($tabBateau);$i++){
			$tabPlacesRestantes[$i][0]= $tabCategorie[$i][0]-$tabReserv[$i][0];
			$tabPlacesRestantes[$i][1]= $tabCategorie[$i][1]-$tabReserv[$i][1];
			$tabPlacesRestantes[$i][2]= $tabCategorie[$i][2]-$tabReserv[$i][2];
		}
		
		//Affichage tableau
		for($i=0;$i<count($tabtraversee);$i++){
			echo $tabtraversee[$i].'<td>'.strval($tabPlacesRestantes[$i][0]).'</td><td>'.strval($tabPlacesRestantes[$i][1]).'</td><td>'.strval($tabPlacesRestantes[$i][2]).'</td>'.'<td><input type="radio" name="boutons" onChange="document.getElementById(\'valbouton\').value='.$tabtraverseeid[$i].'"> </td></tr>';
			
			echo '<input type="hidden" name="valutiles" id="'.$tabtraverseeid[$i].'" value="'.$tabheures[$i].'" />';
			
		}
		echo '<input type="hidden" name="valutiles" id="valbouton" />';
		echo '</table> ';
		
		//Bouton de réservation
		if (count($tabheures)==1){
			echo '<input type="submit" name="btn_enregistrer" value="Enregistrer" onClick="reserver('.$idLiaison.', document.getElementById(\'valbouton\').value , \''.$date.'\', \''.$tabheures[0].'\')">';
		}else{
			echo '<input type="submit" name="btn_enregistrer" value="Enregistrer" onClick="reserver('.$idLiaison.', document.getElementById(\'valbouton\').value , \''.$date.'\', document.getElementById(document.getElementById(\'valbouton\').value ).value)">';
		}
	}											
												
												
	mysqli_close($conn);											
?>