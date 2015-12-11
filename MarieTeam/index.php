<?php session_start();header( 'content-type: text/html; charset=utf-8' ); ?>
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
		
		</section>
</body>
<footer>

</footer>
</html>
