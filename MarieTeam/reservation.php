<?php
header( 'content-type: text/html; charset=utf-8' );

//Recup variables
if (isset($_POST['idLiaison'])){
			$idLiaison=$_POST['idLiaison'];
}

if (isset($_POST['date'])){
			$date=$_POST['date'];
}

if (isset($_POST['idTraversee'])){
			$idTraversee=$_POST['idTraversee'];
}

if (isset($_POST['heure'])){
			$heure=$_POST['heure'];
}


//Connexion bdd
	$conn = mysqli_connect('localhost', 'root', 'root', 'marieteam');
	$selected="";
	mysqli_query($conn,"SET NAMES UTF8"); 

//echo $idLiaison.' '.$date.' '.$idTraversee.' '.$heure.' ';

echo '<form method="POST" action="reservationfinale.php">';
echo '<br />';

//Affichage type Quiberon-Le Palais.
		$req="SELECT portdepart, portarrivee  FROM liaison WHERE $idLiaison=liaison.idliaison";
		$sql = $conn->query($req);										
		while ($row = mysqli_fetch_array($sql)) {
			echo $row['portdepart'].'-'.$row['portarrivee'].".<br />";
		} 		
// Traversee N°...
echo "Traversée N°$idTraversee le $date à $heure <br />";
echo "Saisir les informations relatives à la réservation <br /><br />";
echo '<label for="txt_name">Nom </label> <input type="text" name="txt_name" id="txt_name"><br />';
echo '<label for="txt_adresse">Adresse </label> <input type="text" name="txt_adresse" id="txt_adresse"><br />';
echo '<label for="txt_cp">Cp </label> <input type="text" name="txt_cp" id="txt_cp"><br />';
echo '<label for="txt_ville"> Ville </label> <input type="text" name="txt_ville" id="txt_ville"> <br /><br />';

//Recuperer les libelles et codes
$tabLibelleType=array();
$tabCodeType=array();
$tabCodeCategorie=array();
$req="SELECT libelletype, codetype, codecategorie FROM typee";
			$sql = $conn->query($req);	
			while ($row = mysqli_fetch_array($sql)) {
				$tabLibelleType[]=$row['libelletype'];
				$tabCodeType[]=$row['codetype'];
				$tabCodeCategorie[]=$row['codecategorie'];
			}
//print_r($tabLibelleType);

// Determination de l'id periode de la date
//Recuperation des periodes

$tabDatesDebut=array();
$tabDatesFin=array();
$tabIdPeriode=array();
//La ligne suivante empeche des erreurs suite au conversion de format de date
date_default_timezone_set('America/New_York');
$req="SELECT idperiode, datedebut, datefin FROM periode";
$sql = $conn->query($req);	
			while ($row = mysqli_fetch_array($sql)) {
				//$tabDatesDebut[]=$row['datedebut'];
				//$tabDatesFin[]=$row['datefin'];
				$tabDatesDebut[]=date('d-m-Y', strtotime($row['datedebut']));
				$tabDatesFin[]=date('d-m-Y', strtotime($row['datefin']));
				$tabIdPeriode[]=$row['idperiode'];
			}
/*print_r($tabIdPeriode);
print_r($tabDatesDebut);
print_r($tabDatesFin);*/

for($i=0;$i<count($tabIdPeriode);$i++){
	if(strtotime($date) >= strtotime($tabDatesDebut[$i]) && strtotime($date) <= strtotime($tabDatesFin[$i])){
		$idPeriode=$tabIdPeriode[$i];
	}
}		
//echo $idPeriode;	
//Recuperer les tarifs en fonction de la période
$tabTarifs=array();
$req="SELECT prix FROM tarif WHERE idperiode=$idPeriode AND idliaison=$idLiaison";
			$sql = $conn->query($req);	
			while ($row = mysqli_fetch_array($sql)) {
				$tabTarifs[]=$row['prix'];
			}
//print_r($tabTarifs);

//Mise en forme du tableau
echo '<table>';
echo '<tr><th></th><th>Tarif en Euros</th><th>Quantité</th></tr>';
for($i=0;$i<count($tabTarifs);$i++){
	echo '<tr><td>'.$tabLibelleType[$i].'</td><td>'.$tabTarifs[$i].'</td><td><input type="text" pattern="[0-9]+" name="'.$tabCodeType[$i].'" id="'.$tabCodeType[$i].'"> </td></tr>';
}
echo '</table>';

//Conversion des tableaux necessaires a la reserv finale en string pour les transmettre en ajax
//$client = array('lastname', 'email', 'phone');
//$client = implode(";", $client);

// Donnees a envoyer a la page suivante

# hidden pour envoyer le tableau concatené
$libelle=implode(";",$tabLibelleType);
$code=implode(";",$tabCodeType);
$tarif=implode(";",$tabTarifs);
$codeCategorie=implode(";",$tabCodeCategorie);
echo '<input  name="libelle" type="hidden" value="'.$libelle.'">';
echo '<input  name="tarif" type="hidden" value="'.$tarif.'">';
echo '<input  name="code" type="hidden" value="'.$code.'">';
echo '<input  name="codeCategorie" type="hidden" value="'.$codeCategorie.'">';

//Envoi de sinfos de la reservation
echo '<input  name="idLiaison" type="hidden" value="'.$idLiaison.'">';
echo '<input  name="idTraversee" type="hidden" value="'.$idTraversee.'">';
echo '<input  name="date" type="hidden" value="'.$date.'">';
echo '<input  name="heure" type="hidden" value="'.$heure.'">';

// Bouton de reservation final
echo '<input type="submit" name="btn_enregistrer" value="Enregistrer">';
//echo '<input type="submit" name="btn_enregistrer" value="Enregistrer" onClick="reserverfinal('.$idLiaison.', '.$idTraversee.', \''.$date.'\', \''.$heure.'\',  )">';

echo '</form>';
mysqli_close($conn);
?>